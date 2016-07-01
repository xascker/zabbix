#!/bin/bash

#git pull origin master

#git rev-parse HEAD > newversion && diff newversion version
#git rev-parse HEAD > version


#perl import.pl



result=$(diff newversion version)

if [ $? -eq 0]; then
echo "files are the same"
else
echo "files are different"
echo "$result"
fi
