#!/bin/bash


git rev-parse HEAD > newversion && diff newversion version
git rev-parse HEAD > version


git fetch
if $(git rev-parse HEAD) == $(git rev-parse @{u});
then
    echo "not need pull"
else
    echo "pull"
   
fi

#git pull origin master
#perl import.pl
