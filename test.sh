#!/bin/bash

for var in open-window-1.sh close-window-1.sh
do
if ./test/$var -eq 0
then
echo "SUCCESS"
else
echo "FAIL"
fi
done