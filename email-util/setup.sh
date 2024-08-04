#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "PYTHON EMAIL CLIENT SETUP\n\n"

# Update the package list
echo "Updating package list..."
sudo apt-get update

# Install Python3 and pip3
echo "Installing Python3..."
sudo apt-get install -y python3

echo "Installing pip3..."
sudo apt-get install -y python3-pip

# Install python-dotenv in the current directory
echo "Installing python-dotenv in the current directory..."
pip3 install python-dotenv --target .


echo "\nPYTHON EMAIL CLIENT SETUP COMPLETE!\n\n"
