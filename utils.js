const fs = require('fs');
const path = require('path');

function deleteFilesOlderThanDays(dirPath, durationInDays) {
  const now = Date.now();
  const msInDay = 86400000; // number of milliseconds in a day

  const files = fs.readdirSync(dirPath);
  files.forEach((file) => {
    const filePath = path.join(dirPath, file);
    const fileAgeInMs = now - fs.statSync(filePath).mtimeMs;
    const fileAgeInDays = fileAgeInMs / msInDay;

    if (fileAgeInDays > durationInDays) {
      fs.unlinkSync(filePath);
      console.log(`Deleted ${filePath}`);
    }
  });
}

// Define the log file path
const logFilePath = path.join(__dirname, 'backup.log');
// Set up a writable stream to the log file
const logStream = fs.createWriteStream(logFilePath, { flags: 'a' });

function log(message, isError = false) {
  const timestamp = new Date().toLocaleString('fr-FR', { timeZone: 'Europe/Paris' });
  const prefix = `${timestamp} - ${isError ? 'ERROR: ' : ''}`;
  const logMessage = `${prefix}${message}`;
  console.log(logMessage);
  logStream.write(logMessage + '\n');
}

module.exports = { deleteFilesOlderThanDays, log };