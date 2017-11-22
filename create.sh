#!/usr/bin/env bash

usage="$(basename "$0") [-h] [-n function_name] -- create openwhisk function directory, and deploy to openwhisk

where:
    -h  show this help text
    -n  function name to create"

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

# make project skeleton

mkdir ${function_name}
touch ${function_name}/index.js
touch ${function_name}/package.json

echo "function main(args) {" >> ${function_name}/index.js
echo "    return {'result':'hello world'}" >> ${function_name}/index.js
echo "}" >> ${function_name}/index.js
echo "exports.main = main;" >> ${function_name}/index.js

echo "{\"name\": \"${function_name}\",\"version\": \"1.0.0\",\"main\": \"index.js\",\"dependencies\": {}}" >> ${function_name}/package.json


# zip function
cd ${function_name}
zip create.zip index.js package.json
mv create.zip ../
cd ../

# create openwhisk function
wsk action create ${function_name} create.zip --kind nodejs:6 --web true

# clear zipped file
rm -rf create.zip
