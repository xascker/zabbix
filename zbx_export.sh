#!/bin/bash

perl export.pl

if [ -d ./templates/ ];
then
    git add .
    git commit -m "Export templates from $(date '+%b %d, %Y')"
    git push origin master
else
    echo "Export file does not exists!"
    exit 1
fi
