#!/usr/bin/env bash

# Color Reset
NC='\033[0m'
# Regular Colors
Green='\033[0;32m'
Blue='\033[0;34m'

# Check if arguments exist, will be the message subject
if [ $# -eq 0 ]; then
    echo "USAGE: git-commit.sh \"the commit subject\""
    exit 1
fi

# commit subject, concatenation of all script argument
subject="$*"

echo -e "Commit type?"
echo -e "${Green}(1)${Blue} Feature ${Green}(2)${Blue} Fix ${Green}(3)${Blue} Refactor ${Green}(4)${Blue} Chore ${Green}(5)${Blue} Doc${NC} "
read -s answer
echo ""

case ${answer} in
    1 )
        type="Feature: "
    ;;
    2 )
        type="Fix: "
    ;;
    3 )
        type="Refactor: "
    ;;
    4 )
        type="Chore: "
    ;;
    5 )
        type="Doc: "
    ;;
    * )
        echo "Value must be in [1-5]..."
        exit 1
    ;;
esac

# Print the message's first line
echo $type${subject[@]}
echo ""

# Read the body message
read -a array -p "Body: "
echo ""

# create a multi line version of the complete message
# including new lines
read -r -d '' msg << EOF
$type${subject[@]}

${array[@]}
EOF
echo $msg

# Run commit command
git commit -m "$msg"
