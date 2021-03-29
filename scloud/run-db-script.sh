
#!/bin/bash

set -eu -o pipefail

##########################################################
# Constants
##########################################################
#get full path of the directory where this script resides
THIS_SCRIPT="$0"
THIS_SCRIPT_DIR="$(cd $(dirname $THIS_SCRIPT) && pwd)"
THIS_SCRIPT_NAME="$(basename $THIS_SCRIPT)"

DB_HOST=
DB_PORT=5432
DB_NAME=
DB_USER=
DB_PWD=

##########################################################
# Function: display_usage
# Params: -
# Return: -
##########################################################
display_usage() {
    echo
    echo "$THIS_SCRIPT_NAME script_file log_file"
    echo "script_file                                - script file to run"
    echo "log_file                                   - log file"
}

##########################################################
# Initialization
##########################################################

if [ $# -lt 2 ]; then
    echo 'Error: Missing parameters'
    display_usage
    exit 1
fi

sql_file="$1"
log_file="$2"

##########################################################
# Main
##########################################################

PGOPTIONS='--client-min-messages=warning' PGPASSWORD=${DB_PWD} psql -h $DB_HOST -p $DB_PORT -d $DB_NAME -U $DB_USER --echo-errors -f "$sql_file" > "$log_file" 2>&1