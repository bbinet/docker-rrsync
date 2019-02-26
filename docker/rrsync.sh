#!/bin/sh

# This rrsync.sh script validates SSH_ORIGINAL_COMMAND before running rrsync.

# SSH_ORIGINAL_COMMAND should look like:
# rsync --server -rze.iLsf --append --append . <path>

RRSYNC="/rrsync/rrsync"
BASEPATH="/data"

# Here we should validate the SSH_ORIGINAL_COMMAND is allowed
validated_path=$(echo "$SSH_ORIGINAL_COMMAND" | sed -n \
    "s/^rsync --server -[^ ]* --append \([0-9a-z_-]*\)$/\1/p")

if [ -z "$validated_path" ]
then
    echo "Not allowed: command validation has failed..."
    exit 1
fi

SSH_ORIGINAL_COMMAND=$(echo "$SSH_ORIGINAL_COMMAND" | sed -n \
    "s/ \([0-9a-z_-]*\)$//p")
export SSH_ORIGINAL_COMMAND

validated_abspath="${BASEPATH%%/}/$validated_path"
mkdir -p $validated_abspath
$RRSYNC $validated_abspath
