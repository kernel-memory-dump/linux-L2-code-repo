#!/bin/bash

# Find the Flask app process and kill it
FLASK_APP_PROCESS=$(pgrep -f "server.py")

if [ -n "$FLASK_APP_PROCESS" ]; then
    kill $FLASK_APP_PROCESS
    echo "Flask app stopped successfully"
else
    echo "Flask app is not running"
fi