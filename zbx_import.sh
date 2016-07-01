#!/bin/bash

#git pull origin master

#git rev-parse HEAD > newversion && diff newversion version
#git rev-parse HEAD > version


#perl import.pl



if result="$(diff newversion version)"
  then
    echo "Files are the sames"
  else
    echo "Files are differents"
    echo "$result"
  fi


