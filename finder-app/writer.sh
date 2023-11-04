#!/bin/bash

# Exit code 1 -> Fail in execution
# Exit code 0 -> Normal execution

# Raises error if there are not 2 command line arguments
if [ $# -ne 2 ]
then
        echo -e "ERROR: You must provide exactly 2 arguments to the script, as follows:\n\t 1) Filepath to a file on the filesystem; \n\t 2) Text string which will be written within the especified file."
        exit 1
fi

writefile=$1
writestr=$2

parentdir=$(dirname $writefile)

# Executes the script

if ! [ -d $parentdir ]
then
	mkdir -p $parentdir
fi

echo $writestr > $writefile
