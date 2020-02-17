#!/bin/bash
gawk -F\; 'BEGIN { OFS= "," } { print $1, $4, $5  }' \
../../data/2019-12_sds011.csv >> ../../data/trimmed.csv
