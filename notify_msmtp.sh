#!/bin/bash

set -e


# if the file DOES NOT exist, then the script will exit
if [[ ! -f ~/.msmtprc ]]; then
    echo "MSMTP is not configured! Run ./config-msmtp.sh first"
    exit 1 # make it a failure
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
    # NOTES on the !3 syntax:
    #
    # Word Splitting:
        # If the array is not referenced correctly, word splitting might occur,
        # which means the array elements might not be handled as expected. 
        # This could lead to incorrect email addresses being processed.
    

    # Loop through each email address and send the email via MSMTP
    for email in "${email_addresses[@]}"; do
        echo "Sending email to $email"
        echo -e "From: $smtp_user\nTo: $email\nSubject: $subject\n\n$body" | msmtp -a default "$email"
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
    subject="Test Email 1"
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