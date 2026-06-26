#!/bin/bash

HOST="pixie-ss1-ftp.porkbun.com"
USER="swattransport.llc"

# Read password from .ftp-pass file if it exists, otherwise prompt
if [ -f "$(dirname "$0")/.ftp-pass" ]; then
  PASS=$(cat "$(dirname "$0")/.ftp-pass")
else
  read -s -p "FTP Password: " PASS
  echo ""
fi

echo "Deploying to swattransport.llc..."

curl -s --ftp-pasv -T "$(dirname "$0")/index.html" \
  "ftp://$HOST/" \
  --user "$USER:$PASS" \
  --ftp-create-dirs

if [ $? -eq 0 ]; then
  echo "Done. Live at https://swattransport.llc"
else
  echo "Upload failed. Check your password and try again."
fi
