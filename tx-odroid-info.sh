# tx-odroid-info.sh
#
# To be executed at start-up and perhaps cyclically using "cron".
#
# This script transmits Odroid IP & MAC to Dropbox-folder as text-file using "curl".
#
# Uses "Odroids"-app in Dropbox to create token for Dropbox arc@millestugan.se
# View link for Dropbox-folder: https://www.dropbox.com/sh/xi8f4vlka3jryn3/AADM_AM5DrGyAsorm24KAKkNa?dl=0
#
# 2017-05-04/GF  Introduced, based on https://www.dropbox.com/developers/documentation/http/documentation
#      


# Get filename as IP.txt (e.g. 127.168.1.123.txt) Needs "sed" to remove space at end...              
TX_FILE_NAME=$(hostname -I | sed 's/ /.txt/')

# Get IP/MAC info from "arp" to file
arp > $TX_FILE_NAME

# Copy IP-info-file to Dropbox using predefined token
curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer 6p-eC8abUAAAAAAAAAAACj99PBK6Aiu7hyIWalIDZw0eaGjiZJlrttn9YonK7nOW" \
    --header "Dropbox-API-Arg: {\"path\": \"/$TX_FILE_NAME\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @$TX_FILE_NAME
echo
echo Finished!
echo

