#!/bin/bash

for dir in `ls -d1 */ | cut -d/ -f1`; do
    echo $dir
    $(stow -t.. $dir)
done
