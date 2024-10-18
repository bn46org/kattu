#!/bin/bash
# decrypt-gpg-key.sh

set -e

# Ensure the environment variable GPG_PASSPHRASE is set
if [ -z "$GPG_PASSPHRASE" ]; then
  echo "Error: GPG_PASSPHRASE is not set."
  exit 1
fi

# Decrypt the GPG key
gpg --batch --yes --passphrase "$GPG_PASSPHRASE" -o user_map.json -d .github/keys/user_map.json.gpg
