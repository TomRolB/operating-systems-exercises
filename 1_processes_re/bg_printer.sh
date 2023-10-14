#!/bin/bash

# if [ $# -ne 2 ];
# then
#     echo "Please input a string and a number"
#     exit 1
# fi    

# ./printer.sh $1 $2 &
# pid=$!

# renice -n 19 -p $pid
# echo "Running printer with pid $pid"
# sleep 20

# renice -n 5 -p $pid
# echo "Press enter to kill the process"

# while true;
# do
#     read -n 1 -s KEY
#     if [ -z $KEY ]; then
#         kill -9 $pid
#         echo "Process was killed"
#         exit 0
# done

./printer.sh "Background Printing" 5 &
pid=$!

echo "ID del proceso: $pid"

renice -n 19 -p $pid
sleep 20
renice -n 5 -p $pid

read -p "Presiona ENTER para matar el proceso."
kill -9 $pid