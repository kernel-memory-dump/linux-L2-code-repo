#!/bin/bash

set -e

source ./decrypt.sh

if [ -z "$smtp_server" ] || [ -z "$smtp_user" ] || [ -z "$smtp_pass" ]; then
    echo "Failed to decrypt credentials."
    exit 1
fi


# Function to send an email to a list of email addresses.
# Parameters:
#   $1 - subject: The subject of the email.
#   $2 - body: The body of the email.
#   $3 - email_addresses: An array of email addresses to send the email to.
# Returns:
#   0 if emails were sent successfully, 1 otherwise.

send_email() {
    # Email subject and body
    subject="$1"
    body="$2"
    email_addresses=("${!3}")
    # Loop through each email address and send the email via swaks
    for email in "${email_addresses[@]}"; do
        echo "Sending email to $email"
        swaks --to "$email" \
              --from "$smtp_user" \
              --server "$smtp_server" \
              --port "26" \
              --auth LOGIN \
              --auth-user "$smtp_user" \
              --auth-password "$smtp_pass" \
              --timeout 10 \
              --header "Subject: $subject" \
              --tls \
              --body "$body"
        if [[ $? -ne 0 ]]; then
            echo "Failed to send email to $email"
            return 1
        fi
    done

    echo "Emails sent successfully."
    return 0
}

# Example call to the function
example_of_usage() {
    subject="Test Email 2"
    body="This is a test email."
    email_addresses=($smtp_user)

    send_email "$subject" "$body" email_addresses[@]

    # Check the return value to see if the emails were sent successfully
    if [[ $? -eq 0 ]]; then
        echo "All emails sent successfully."
    else
        echo "There was an error sending the emails."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" && $1 == "example" ]]; then
    example_of_usage
fi
