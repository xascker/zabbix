#!/bin/bash

git pull origin master
git rev-parse HEAD > newversion

if result="$(diff newversion version)"
  then
    echo "Import nothing"
  else
    echo "Are imported:"
    perl import.pl
    git rev-parse HEAD > version
fi


