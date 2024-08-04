#!/bin/bash

# URL of the Flask app
FLASK_APP_URL="http://localhost:5000"

# Function to check the health endpoint
check_health() {
    response=$(curl --write-out "%{http_code}" --silent --output /dev/null "$FLASK_APP_URL/health")
    if [ "$response" -eq 200 ]; then
        echo "Health check passed: $response"
        return 0
    else
        echo "Health check failed: $response"
        return 1
    fi
}

# Function to call the crash endpoint
trigger_crash() {
    response=$(curl --write-out "%{http_code}" --silent --output /dev/null "$FLASK_APP_URL/crash")
    if [ "$response" -eq 500 ]; then
        echo "Crash endpoint triggered: $response"
        return 0
    else
        echo "Failed to trigger crash endpoint: $response"
        return 1
    fi
}

# Main script execution
demo_of_usage() {
    check_health
    health_status=$?

    trigger_crash
    crash_status=$?

    # Check the health status after triggering the crash
    if [ $health_status -eq 0 ]; then
        echo "Initial health check succeeded."
    else
        echo "Initial health check failed."
    fi

    if [ $crash_status -eq 0 ]; then
        echo "Crash endpoint successfully triggered."
    else
        echo "Crash endpoint triggering failed."
    fi

    # Final health check after crash
    check_health
    final_health_status=$?

    if [ $final_health_status -eq 0 ]; then
        echo "Final health check succeeded."
    else
        echo "Final health check failed."
    fi

    # Exit code to indicate success or failure of the whole script
    if [ $health_status -eq 0 ] && [ $crash_status -eq 0 ] && [ $final_health_status -eq 1 ]; then
        exit 0
    else
        exit 1
    fi

}
if [[ "${BASH_SOURCE[0]}" == "${0}" && $1 == "example" ]]; then
    demo_of_usage
fi
