#!/bin/bash

# We like color output
# Colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`


changed_files="$(git diff HEAD~1 --name-only | grep ".*\.rst$")"

#echo "$changed_files" | grep --quiet "$1" && eval "$2"
echo "$changed_files"
if [[ "$changed_files" == *.rst ]]
then
    echo "${green} DUDE ! Awesome we found some .rst files in your last commit, lets run tests against them!${reset}"
    echo "${yellow} Start running spell, link and html checks, please be patient ....!${reset}"
    for line in $changed_files; do
       docker run -it --rm -v "${PWD}":/source:rw testthedocs/ttd.coala:1 '-c=/source/.coafile' DOCS
       docker run --rm -v "${PWD}/docs":/build/docs:rw -u "$(id -u)":"$(id -g)" quay.io/tiramisu/mr.docs testhtml
       docker run --rm -v "${PWD}/docs":/build/docs:rw -u "$(id -u)":"$(id -g)" quay.io/tiramisu/mr.docs spellcheck

    done

    
    #else
#    echo "rst not found."
fi

