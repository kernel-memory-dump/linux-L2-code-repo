import smtplib
import ssl
import os
import argparse
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# SMTP server configuration
smtp_server = os.getenv("smtp_server")
smtp_port = 465  # SMTP over SSL/TLS port
smtp_user = os.getenv("smtp_user")
smtp_password = os.getenv("smtp_pass")

# Parse command line arguments
parser = argparse.ArgumentParser(description="Send an email via SMTP")
parser.add_argument("recipient", help="Recipient email address")
parser.add_argument("subject", help="Subject of the email")
parser.add_argument("body", help="Body of the email")
args = parser.parse_args()

# Email content
from_email = smtp_user
to_email = args.recipient
subject = args.subject
body = args.body

# Create a multipart message
message = MIMEMultipart()
message["From"] = from_email
message["To"] = to_email
message["Subject"] = subject

# Add body to the email
message.attach(MIMEText(body, "plain"))

# Send the email
try:
    # Create a secure SSL context
    context = ssl.create_default_context()

    with smtplib.SMTP_SSL(smtp_server, smtp_port, context=context) as server:
        server.login(smtp_user, smtp_password)
        server.sendmail(from_email, to_email, message.as_string())
        print("Email sent successfully.")
except Exception as e:
    print(f"Failed to send email: {e}")
