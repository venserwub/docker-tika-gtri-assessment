#! /bin/bash

#parse user input on what file to upload
export target_file="$1"


#if no user input ask user for a file
if [ "$target_file" = "" ]; then
	read -p 'Enter path to target file:' target_file
fi

#parse user input for tika server location
export target_server="$2"

#if no user input ask user for a target server
if [ "$target_server" = "" ]; then
	read -p 'Enter the ip and port of target server (ip:port):' target_server
fi

#upload file to tika
export output=$(curl -s -T $target_file "http://$target_server/tika" --header "Accept: text/plain")

#return output to user
echo $output
