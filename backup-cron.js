const fs = require('fs');
const path = require('path');
const express = require('express');
const cron = require('node-cron');

const { spawn } = require('child_process');
const { deleteFilesOlderThanDays, log } = require('./utils');

const app = express();
const port = 3000;

// Define the path to the backup script
const backupScriptPath = './db_backup.sh';

// Trigger the backup script every day at midnight
cron.schedule('*/10 * * * * *', async () => {
  try {
    log('Starting backup process...');
    // Spawn a child process to run the backup script
    const backupProcess = spawn('bash', [backupScriptPath]);

    // Log the output of the backup script to the console
    backupProcess.stdout.on('data', (data) => {
      log(data);
    });

    // Log any errors that occur during the backup process to the console
    backupProcess.stderr.on('data', (data) => {
      log(`stderr: ${data}`, true);
    });

    // Log a message to the console when the backup process exits
    backupProcess.on('exit', (code) => {
      log(`Backup process exited with code ${code}`);
    });

    // Check and remove backups older than 7 days
    deleteFilesOlderThanDays('./backups', 7);
  } catch (error) {
    log(error, true);
  }
}, {
  timezone: 'Europe/Paris',
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
