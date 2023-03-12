import express from 'express';
import cron from 'node-cron';

const { spawn } = require('child_process');

const app = express();
const port = 3000;

// mardi et vendredi : Ordure ménagère. mercredi : Poubelle recyclable
cron.schedule('49 19 * * 1,2,4,7', async () => {
  // Define the path to the backup script
  const backupScriptPath = '/path/to/backup-script.sh';

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
}, {
  timezone: 'Europe/Paris',
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
