#!/bin/bash

# fail if any command returns a non-zero code
set -e

# set the new seed to argument 1 or default to autoseed
seed=${1:-'autoseed'}

# regex to check if a value is a number
numberCheck='^[0-9]+$'

# replace the current seed with the new seed
if  [[ $seed =~ $numberCheck ]] ; then
    sed -ri "s/([0-9]+\s*random\s*)[^ ]+/\1seed=${seed}/" sys161.conf
else
    sed -ri "s/([0-9]+\s*random\s*)[^ ]+/\1${seed}/" sys161.conf
fi
