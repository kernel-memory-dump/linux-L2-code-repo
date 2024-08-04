#!/bin/bash

set -e

source ./decrypt.sh

# ONLY if exists, remove the msmtp configuration file
if [[ -f ~/.msmtprc ]]; then
    rm ~/.msmtprc
fi

# Write decrypted credentials to msmtp config file
cat <<EOF > ~/.msmtprc
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
tls_certcheck off
account        default
host           $smtp_server
port           465
from           $smtp_user
user           $smtp_user
password       $smtp_pass
logfile        ~/.msmtp.log
timeout 60
EOF

chmod 600 ~/.msmtprc

echo "msmtp configuration file created successfully."