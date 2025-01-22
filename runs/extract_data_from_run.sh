#!/usr/bin/env bash

for file in "${@:1:$#-1}"; do
    node extract_data_from_run.js $file ${@:$#}
done
