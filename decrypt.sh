# Function to decrypt credentials
decrypt_credentials() {
    gpg --decrypt credentials.txt.gpg 2>/dev/null
}

# Read the decrypted credentials into variables
eval "$(decrypt_credentials)"

gpg --decrypt credentials.txt.gpg > decrypted-credentials.txt  2>/dev/null
echo "output also saved to ./decrypted-credentials.txt"


gpg --decrypt credentials.txt.gpg > ./email-util/.env  2>/dev/null
echo "output also saved to ./email-util/.env for the python client"

# Check if decryption was successful
if [ -z "$smtp_server" ] || [ -z "$smtp_user" ] || [ -z "$smtp_pass" ]; then
    echo "Failed to decrypt credentials."
    exit 1
fi

echo "decrypted credentials successfully"
export smtp_server smtp_user smtp_pass