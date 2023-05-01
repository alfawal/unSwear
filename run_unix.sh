#!/bin/bash

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
PURPLE='\033[35m'
CYAN='\033[36m'
RESET='\033[0m'

# Check if Python3 is installed
echo -n "Checking for Python3..."
if ! command -v python3 &> /dev/null
then
    echo -e " ${RED}Failed${RESET}"
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null
    then
        echo "Python3 is not installed. Please install it."
        exit 1
    else
        echo "Python3 is not installed. You can install it using Homebrew with the following command:"
        echo -e "${PURPLE}brew install python@3.y${RESET}"
        exit 1
    fi
fi
echo -e " ${GREEN}Done${RESET}"

# Create a virtual environment
echo -n "Creating a virtual environment..."
python3 -m venv venv >/dev/null 2>&1
echo -e " ${GREEN}Done${RESET}"

# Install the dependencies
echo -n "Checking for dependencies..."
./venv/bin/python3 -m pip install -r requirements.txt >/dev/null 2>&1
echo -e " ${GREEN}Done${RESET}"

# Run unswear.py
echo -e "Running unswear.py... ${YELLOW}(Press Control+C to stop)${RESET}"
./venv/bin/python3 unswear.py

# Exit message
echo -e "${CYAN}"
echo "Hope you had some good games :D"
echo "Don't forget to star the repo if you liked the experience!"
echo "https://github.com/mhavelka77/unSwear"
echo -e "${RESET}"
echo -e "${BLUE}If you had any issues, please report them at https://github.com/mhavelka77/unSwear/issues${RESET}"
