#!/bin/bash

# Exit code 1 -> Fail in execution
# Exit code 0 -> Normal execution

# Raises error if there are not 2 command line arguments
if [ $# -ne 2 ]
then
	echo -e "ERROR: You must provide exactly 2 arguments to the script, as follows:\n\t 1) Filepath to a directory on the filesystem; \n\t 2) Text string which will be searched within the files."
	exit 1
fi

filesdir=$1
searchstr=$2

# Raises error if filesdir is not a directory
if ! [ -d $filesdir ]
then
	echo "ERROR: Filepath must be a directory"
	exit 1
fi

# Executes normally if the criteria are met
num_files=0
num_matches=0
for file in $filesdir/*
do	
	if ! [ -d $file ]
	then
		num_matches_grep=$(cat $file | grep -c $searchstr)
		echo $num_matches_grep
		num_matches=$(( $num_matches + $num_matches_grep))
		num_files=$(( $num_files +  1))
	fi
done 

echo "The number of files are $num_files and the number of matching lines are $num_matches"
