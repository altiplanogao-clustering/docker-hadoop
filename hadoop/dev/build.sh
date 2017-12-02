#!/bin/bash
this_dir=`dirname $0`
image_name="andy/hadoop"

if [[ $1 == "clean" ]]; then
  while true
  do
    # (1) prompt user, and read command line argument
    read -p "Sure to delete $image_name, exit now? (y or n) " answer
    # (2) handle the input we were given
    case $answer in
     [yY]* ) 
        docker image rm $image_name:latest $image_name:2.8.2
		    break
		    ;;
     [nN]* )
        break
        ;;
     * )     echo "Dude, just enter Y or N, please. not $idx -$answer-";;
    esac
  done

  # docker image rm $image_name:latest $image_name:2.8.2
else
  docker build -t $image_name $this_dir/.. --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy}
  docker tag $image_name:latest $image_name:2.8.2
fi