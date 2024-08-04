#!/bin/bash

# Find the Flask app process and kill it
FLASK_APP_PROCESS=$(pgrep -f "server.py")

if [ -n "$FLASK_APP_PROCESS" ]; then
    kill $FLASK_APP_PROCESS
    echo "Flask app stopped successfully"
else
    echo "Flask app is not running"
fi

PID=$(lsof -i :5000 -t)

# Kill the process if it is found
if [ -n "$PID" ]; then
  kill -9 $PID
  echo "Process running on port 5000 has been killed."
else
  echo "No process running on port 5000."
fi
