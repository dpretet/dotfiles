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

echo ""
echo -e "${Green}(1)${Blue} Feature ${Green}(2)${Blue} Fix ${Green}(3)${Blue} Refactor ${Green}(4)${Blue} Chore ${Green}(5)${Blue} Doc${NC} "
read -p "Commit type: " answer
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

# the commit message is stored in a file to simply the
# message construction. Handling new line support
# and edition capability with Readline is not possible

# First store the message header
header=$type${subject[@]}
echo $header > msg.txt
echo "" >> msg.txt

echo "Body:"
# iterate over user entires until he fills an empty line
while read line
do
    [ -z "$line" ] && break
    echo "$line" >> msg.txt
done

# Run commit command
git commit --file msg.txt
rm -f msg.txt
