#!/bin/bash

get_diff(){
    echo "test"
}   

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
echo $branch
