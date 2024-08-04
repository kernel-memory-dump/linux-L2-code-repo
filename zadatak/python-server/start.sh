#!/bin/bash

# Start the Flask app using nohup for detached mode
nohup python3 server.py > flask_app.log 2>&1 &

# Check if the app started successfully
sleep 5
if pgrep -f "server.py" > /dev/null; then
    echo "Flask app started successfully"
else
    echo "Failed to start Flask app"
fi