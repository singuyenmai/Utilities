####################
# Author: Si-Nguyen Mai
# Source of `try_getopt_script`: Robert Siemer [https://stackoverflow.com/a/29754866/8913383]
# Last update: April 29, 2020
# Function: try and test `getopt` of the system, which is expected to be enhanced version of `getopt`
# Expected output: 5 lines of "verbose: y, force: y, debug: y, in: /tmp/someFile, out: /tmp/otherFile"
####################

cat >/tmp/try_getopt_script <<'EOF'
#!/bin/bash

# saner programming env: these switches turn some bugs into errors
set -o errexit -o pipefail -o noclobber -o nounset

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null 
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'I’m sorry, `getopt --test` failed in this environment.'
    exit 1
fi

OPTIONS=dfo:v
LONGOPTS=debug,force,output:,verbose

# -regarding ! and PIPESTATUS see above
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    # e.g. return value is 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

d=n f=n v=n outFile=-
# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -d|--debug)
            d=y
            shift
            ;;
        -f|--force)
            f=y
            shift
            ;;
        -v|--verbose)
            v=y
            shift
            ;;
        -o|--output)
            outFile="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

# handle non-optional arguments
if [[ $# -ne 1 ]]; then
    echo "$0: A single input file is required."
    exit 4
fi

echo "verbose: $v, force: $f, debug: $d, in: $1, out: $outFile"
EOF

chmod a+x /tmp/try_getopt_script

touch /tmp/someFile 
touch /tmp/otherFile

/tmp/try_getopt_script -vfd /tmp/someFile -o /tmp/otherFile
/tmp/try_getopt_script -v -f -d -o /tmp/otherFile -- /tmp/someFile
/tmp/try_getopt_script --verbose --force --debug /tmp/someFile -o /tmp/otherFile
/tmp/try_getopt_script --output=/tmp/otherFile /tmp/someFile -vfd
/tmp/try_getopt_script /tmp/someFile -df -v --output /tmp/otherFile