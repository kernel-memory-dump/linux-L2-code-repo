#!/bin/bash
#
# Logging Library

# Color palette
RESET='\033[0m'
GREEN='\033[38;5;2m'
RED='\033[38;5;1m'
YELLOW='\033[38;5;3m'

source config.sh
# Log file location (default: "./logger.log")
# DEFAULT VALUE if not specified var=var:-default-value
LOG_FILE_LOCATION=${LOG_FILE_LOCATION:-"./logger.log"}

# Functions

########################
# Log message to stderr and file
# Arguments:
#   $1 - Color-coded message to log to terminal
#   $2 - Plain message to log to file
#########################
log() {
    local message_terminal="${1}"
    local message_file="${2}"
    printf "%b\\n" "${message_terminal}" >&2
    if [[ -n "${LOG_FILE_LOCATION}" ]]; then
        printf "%b\\n" "${message_file}" >> "${LOG_FILE_LOCATION}"
    fi
}

########################
# Log info message
# Arguments:
#   $1 - Message to log
#########################
info() {
    local message="${*}"
    log "${GREEN}INFO ${RESET} ==> ${message}" "INFO ==> ${message}"
}

########################
# Log warning message
# Arguments:
#   $1 - Message to log
#########################
warn() {
    local message="${*}"
    log "${YELLOW}WARN ${RESET} ==> ${message}" "WARN ==> ${message}"
}

########################
# Log error message
# Arguments:
#   $1 - Message to log
#########################
error() {
    local message="${*}"
    log "${RED}ERROR ${RESET} ==> ${message}" "ERROR ==> ${message}"
}
