#!/bin/bash

cat 1.txt | while read line
do
    echo $line
done
