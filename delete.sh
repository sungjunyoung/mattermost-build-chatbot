#!/usr/bin/env bash

usage="$(basename "$0") [-h] [-n function_name] -- delete openwhisk function

where:
    -h  show this help text
    -n  function name to delete"

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

# remove function directory
rm -rf ${function_name}

# create openwhisk function
wsk action delete ${function_name}

