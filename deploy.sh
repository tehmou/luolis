SERVER='ubuntu@176.34.182.200'
KEY='-i /Users/ttuo/.ssh/home-laptop.pem'
BACKUP_DIR='~/backup/luolis_'`date "+%Y-%m-%d-%T"`
DESTINATION='luolis'

#echo "Copying client files.."
#cp client/* server/public/

echo "Backing up to $BACKUP_DIR"
ssh $SERVER $KEY "mkdir ~/backup"
ssh $SERVER $KEY "mv ~/luolis $BACKUP_DIR"

echo "Copying to $DESTINATION"
scp $KEY -r server $SERVER:$DESTINATION

echo "Starting node"
#ssh $SERVER $KEY "node ~/luolis/server.js &"
