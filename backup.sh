#!/bin/sh
DATE=`date +%Y-%m-%d`
#extract database
mongodump -h localhost:27017 -d DATABASENAME -u USERNAME -p PASSWORD -o "/home/backups/back-local-$DATE"

#delete old backups
find /home/backups/ -type f -name "output*" -delete

#zip and remove the origin-folder and upload a copy to Google Drive / Backups
zip -rm "/home/backups/output-$DATE" "/home/backups/back-local-$DATE"

#using rclone tool to copy backup zipped file to google drive folder (mybackups)
/home/backups/rclone copy "/home/backups/output-$DATE.zip" "google:mybackups/back-google-$DATE"
