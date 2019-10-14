#!/bin/bash

low() {
START1=$(date +%s)
nice -20 tar czvf /tmp/archive_low.tar.gz /usr/* > /dev/null  2>&1
END1=$(date +%s)
DIFF1=$(( $END1 - $START1 ))
echo "LOW process finished on $DIFF1 seconds"
}

high() {
START2=$(date +%s)
nice --19 tar czvf /tmp/archive_high.tar.gz /usr/* > /dev/null  2>&1
END2=$(date +%s)
DIFF2=$(( $END2 - $START2 ))
echo "HIGH process finished on $DIFF2 seconds"
}

low &
high &


