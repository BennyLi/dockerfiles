#! /usr/bin/env bash

#
# Check if we are root, otherwise we cannot work properly!
#
if test "$(id -u)" -ne "0"; then
    echo "This script has to be run with root priviledges!"
    exit 1
fi



#
# Stop the running containers, remove them 
# and do some cleanup (remove the images as well).
#
docker-compose down --rmi all



#
# Create a backup of this project
#
PROJECT_PATH="{{ firefly_project_path }}"
BACKUP_DATE="$(date +%Y-%m-%d_%H%M)"
BASE_BACKUP_PATH="{{ firefly_backup_basepath }}"
CURRENT_BACKUP_PATH="${BASE_BACKUP_PATH}/${BACKUP_DATE}"

echo "########################################"
echo "# Creating a new Firefly III backup !"
echo "########################################"
echo ""
echo "Backup path is: $CURRENT_BACKUP_PATH"

mkdir -p "$CURRENT_BACKUP_PATH"

pushd "$PROJECT_PATH" > /dev/null
echo "Putting everything in the project path into one .tar.gz file ..."
tar --create \
    --gzip \
    --file "${CURRENT_BACKUP_PATH}/firefly_backup.tar.gz" \
    --verbose \
    "./"
echo "For convenience, we copy the docker-compose.yml into the backup dir directly ..."
cp docker-compose.yml "${CURRENT_BACKUP_PATH}"
popd > /dev/null

echo "[DONE]"



#
# Pull latest Docker images
#
docker-compose pull --quiet



#
# Start the project again and do migrations if needed
#
docker-compose up --detach
