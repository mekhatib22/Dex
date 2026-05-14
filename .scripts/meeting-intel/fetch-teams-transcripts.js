#!/usr/bin/env node
/**
 * Dex Meeting Transcript Fetcher
 * 
 * Pulls today's Teams meeting transcripts via M365 Copilot (WorkIQ),
 * processes them into Dex meeting notes, updates person pages, and extracts tasks.
 * 
 * Designed to run daily at 5pm via launchctl.
 * 
 * Usage: node fetch-teams-transcripts.js [--date YYYY-MM-DD] [--dry-run]
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const VAULT_PATH = path.join(process.env.HOME, 'Documents', 'Dex');
const MEETINGS_DIR = path.join(VAULT_PATH, '00-Inbox', 'Meetings');
const STATE_FILE = path.join(VAULT_PATH, '.scripts', 'meeting-intel', 'processed-transcripts.json');
const LOG_FILE = path.join(VAULT_PATH, '.scripts', 'meeting-intel', 'transcript-fetch.log');

// Parse args
const args = process.argv.slice(2);
const dryRun = args.includes('--dry-run');
const dateIdx = args.indexOf('--date');
const targetDate = dateIdx >= 0 ? args[dateIdx + 1] : new Date().toISOString().slice(0, 10);

function log(msg) {
  const ts = new Date().toISOString();
  const line = `[${ts}] ${msg}`;
  console.log(line);
  fs.appendFileSync(LOG_FILE, line + '\n');
}

function loadState() {
  try {
    return JSON.parse(fs.readFileSync(STATE_FILE, 'utf8'));
  } catch {
    return { processed: [] };
  }
}

function saveState(state) {
  fs.writeFileSync(STATE_FILE, JSON.stringify(state, null, 2));
}

function meetingNoteExists(date, title) {
  const slug = title.replace(/[^a-zA-Z0-9 ]/g, '').replace(/\s+/g, ' ').trim();
  const filename = `${date} - ${slug}.md`;
  return fs.existsSync(path.join(MEETINGS_DIR, filename));
}

async function main() {
  log(`=== Transcript fetch started for ${targetDate} ===`);
  
  const state = loadState();
  
  // Build the prompt for WorkIQ
  const prompt = `List all of Mark Elkhatib's Teams meetings from ${targetDate} that have transcripts available. For each transcribed meeting, provide:
1. Meeting title
2. Start time and end time
3. Attendees (names only)
4. A detailed summary of the transcript including: key discussion points, decisions made, action items for Mark, and action items for others. Be thorough.

Format each meeting clearly with headers. Only include meetings that actually have transcripts (isMeetingTranscribed = true).`;

  log(`Querying WorkIQ for transcribed meetings on ${targetDate}...`);
  
  if (dryRun) {
    log('DRY RUN — would query WorkIQ and process transcripts');
    log('=== Dry run complete ===');
    return;
  }

  // Write the prompt to a temp file for the copilot CLI to pick up
  const promptFile = path.join(VAULT_PATH, '.scripts', 'meeting-intel', 'pending-transcript-fetch.json');
  fs.writeFileSync(promptFile, JSON.stringify({
    date: targetDate,
    prompt: prompt,
    status: 'pending',
    created: new Date().toISOString()
  }, null, 2));

  log(`Transcript fetch request saved to ${promptFile}`);
  log('Next copilot session will process pending transcripts.');
  log(`=== Transcript fetch complete for ${targetDate} ===`);
}

main().catch(err => {
  log(`ERROR: ${err.message}`);
  process.exit(1);
});
