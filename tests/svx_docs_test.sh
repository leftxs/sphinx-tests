#!/bin/bash

# VARS


# Check if file exits, if so remove

if [ -f .aspell.plone.pws ]; then
   #echo "Remove old file"
   rm .aspell.plone.pws
else
   :
fi

# Convert spelling_wordlist.txt to .aspell.plone.pws
sed '1 i personal_ws-1.1 en 0' spelling_wordlist.txt > .aspell.plone.pws

# Get list with last changed .rst files
#git diff HEAD~1 --name-only > /tmp/testlist
LISTOFFILES=$(git diff HEAD~1 --name-only)

for line in $LISTOFFILES; do
    cat $line | aspell list --personal={pwd}.aspell.plone.pws | sort -u
done

#for line in $(cat /tmp/testlist); do
#    cat $line | aspell list --personal={pwd}.aspell.plone.pws | sort -u
#done
