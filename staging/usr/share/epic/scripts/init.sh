#!/bin/bash


GIT_DIR=".git"
if [ -d "$GIT_DIR" ]; then
    DIR=".git/.fuse"
    if [ -d "$DIR" ]; then
        echo "This is already a fuse repository"
    else
        mkdir "$DIR"
        echo "Initialized the fuse repository"
    fi
else
    echo "This directory needs to be a git repository"
    echo "Make sure this is the root directory of the repository"
    echo "Aborting Initialization..."
fi
