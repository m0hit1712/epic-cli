#!/bin/bash


GIT_DIR=".git"
if [ -d "$GIT_DIR" ]; then
    DIR=".git/.epic"
    if [ -d "$DIR" ]; then
        echo "This is already a epic repository"
    else
        mkdir "$DIR"
        echo "Initialized the epic repository"
    fi
else
    echo "This directory needs to be a git repository"
    echo "Make sure this is the root directory of the repository"
    echo "Aborting Initialization..."
fi
