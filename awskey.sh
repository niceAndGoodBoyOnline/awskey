#!/bin/bash
SCRIPT=$0

helpInfo(){
echo -e "\n${SCRIPT:2:6} usage:"
echo -e "   This tool creates, stores, and imports SSH keys to AWS EC2 \nExample:"
echo -e "       awskey [key-pair-name]"
echo -e "       Outcome: The key will be saved locally in ~/.ssh/[key-pair-name] and remotely as [key-pair-name]"
}

if [ $# -lt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
    helpInfo
    exit 1
fi

ssh-keygen -t rsa -C "$1" -f ~/.ssh/"$1".pem

aws ec2 import-key-pair --key-name "$1" --public-key-material fileb://~/.ssh/"$1".pem.pub

ls -la ~/.ssh | grep "$1"
