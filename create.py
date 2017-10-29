import argparse
import os
from glob import glob
from subprocess import call


def parse_args():
    desc = "create openwhisk function with folder structure."
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument('--name', type=str, required=True,
                        help='function name')
    return parser.parse_args()


def main():
    args = parse_args()
    function_name = args.name

    os.makedirs(function_name)
    call(['touch', function_name + '/index.js'])

    # call(['zip', '-r', function_name + '.zip'] + glob(function_name + '/*'))
    call(['wsk', 'action', 'create', function_name, '--kind', 'nodejs:6', function_name + '/index.js'])
    # call(['rm', '-R', function_name + '.zip'])


if __name__ == '__main__':
    main()
