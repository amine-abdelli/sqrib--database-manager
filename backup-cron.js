const express = require('express');
const cron = require('node-cron');

const { spawn } = require('child_process');

const app = express();
const port = 3000;

// Define the path to the backup script
const backupScriptPath = './backup.sh';

cron.schedule('0 0 * * *', async () => {
  // Spawn a child process to run the backup script
  const backupProcess = spawn('bash', [backupScriptPath]);

  // Log the output of the backup script to the console
  backupProcess.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
  });

  // Log any errors that occur during the backup process to the console
  backupProcess.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`);
  });

  // Log a message to the console when the backup process exits
  backupProcess.on('exit', (code) => {
    console.log(`Backup process exited with code ${code}`);
  });

  // Check and remove backups older than 7 days
}, {
  timezone: 'Europe/Paris',
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
