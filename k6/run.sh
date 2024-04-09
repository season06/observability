#!/bin/bash

if [ "$1" = "trace" ] || [ "$1" = "no_trace" ]
then
    echo "$1"
else
    echo "folder is not exist"
    exit 1
fi

# echo "===== GET ====="

# k6 run get_10.js >> ./"$1"/get_r10.txt
# echo "GET with rps = 10, done"
# sleep 10

# k6 run get_100.js >> ./"$1"/get_r100.txt
# echo "GET with rps = 100, done"
# sleep 30

# k6 run get_300.js >> ./"$1"/get_r300.txt
# echo "GET with rps = 300, done"
# sleep 60

# k6 run get_500.js >> ./"$1"/get_r500.txt
# echo "GET with rps = 500, done"


echo "===== POST ====="

k6 run post_10.js >> ./"$1"/post_r10.txt
echo "Post with rps = 10, done"
sleep 10

k6 run post_100.js >> ./"$1"/post_r100.txt
echo "Post with rps = 100, done"
sleep 10

k6 run post_300.js >> ./"$1"/post_r300.txt
echo "Post with rps = 300, done"
sleep 10

k6 run post_500.js >> ./"$1"/post_r500.txt
echo "Post with rps = 500, done"
