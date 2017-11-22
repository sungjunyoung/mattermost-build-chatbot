#!/usr/bin/env bash

usage="$(basename "$0") [-h] [-n function_name] -- update openwhisk function

where:
    -h  show this help text
    -n  function name to update"

function_name=""
while getopts ':hn:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    n) function_name=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

if [ "$function_name" == "" ];then
   printf "function name not passed!: -%s\n" "$OPTARG" >&2
   echo "$usage" >&2
   exit 1
fi

# zip function
cd ${function_name}
zip -r update.zip *
mv update.zip ../
cd ../

# create openwhisk function
wsk action update ${function_name} update.zip --kind nodejs:6 --web true

# clear zipped file
rm -rf update.zip
