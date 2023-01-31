#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if [[ "$(git branch --show-current)" = "master"  ||  "$(git branch --show-current)" = "main" ]]; then
    echo "You cannot create a diff on master or main branch!";
    exit 0;
fi

untracked_files_list=$(git ls-files --others --exclude-standard)
unstaged_changes_list=$(git ls-files -m)

untracked_files() {
    
    echo "You have untracked files in your working copy"
    echo -e "${RED}\n\t${untracked_files_list//$'\n'/$'\n\t'}\n${NC}"

    addedfiles() {
        echo "Added files:"
        echo -e "${GREEN}\t${untracked_files_list//$'\n'/$'\n\t'}\n${NC}"
        git add -AN
    }

    while true; do
        read -p "Do you want to ignore above untracked files? [y/N] " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) addedfiles && break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

unstaged_files() {
    echo "Changed files:"
    echo -e "${YELLOW}\n\t${unstaged_changes_list//$'\n'/$'\n\t'}\n${NC}"

    prepare_commit() {
        git add -u .
        git commit --amend
    }

    while true; do
        read -p "Do you want to amend this change to current commit? [y/N] " yn
        case $yn in
            [Yy]* ) prepare_commit && break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}


if [[ $(git ls-files --others --exclude-standard) ]]; then
    untracked_files
fi

if [[ $(git ls-files --modified) ]]; then
    unstaged_files
else
    echo "There are no any changes to be committed in this repository"
fi


