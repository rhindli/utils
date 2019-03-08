#!/bin/bash

set -eu -o pipefail

display_usage() {
    echo
    echo "Unzip Java archive (jar, war, ear)"
    echo
    echo "unzip-java-archive.sh zipfile [destdir]"
    echo
    echo "zipfile    - jar/war/ear file"
    echo "destdir    - directory where the zip file is unpacked (optional)"
    echo "             If not specified, the file is unzipped to current directory"
    echo
    echo "If zipfile is a war or an ear, all classes from the included jars"
    echo "together with the classes from war will be unpacked to a directory named"
    echo "'allclasses' inside destdir"
    echo
    echo
}

#########################
# Initialization
#
if [ "$#" -lt 1 ]; then
    display_usage
    exit 1
fi

zipfile="$1"
destdir="$(pwd)"

if [ "$#" -eq 2 ]; then
    destdir="$2"
fi

#create dest directory if not exists
if [ ! -d "$destdir" ]; then
    mkdir -p "$destdir"
fi

zipfilename="$(basename $zipfile)"

#create a temp working directory to be used in unzipping
tmpworkdir="$destdir/$zipfilename-###"
if [ -d "$tmpworkdir" ]; then
    rm -fr "$tmpworkdir"
fi

mkdir -p "$tmpworkdir"

#########################
# Unzip main archive
#
unzipdir="$destdir/$zipfilename"

if [ -d "$unzipdir" ]; then
    rm -fr "$unzipdir"
fi

mkdir -p "$unzipdir"

unzip "$zipfile" -d "$unzipdir"

#copy classes directory (which exists only if main archi ve is a war)
find "$unzipdir" -type d -name 'classes' -exec cp -fR {} "$unzipdir/allclasses" \;

#########################
# Unzip wars inside main archive
#

for f in "$unzipdir"/*.war
do
    #check if file exists; This is necessary because when there is no file 
    #with for one of the specified extensions f will be set to the pattern
    #for that file extension
    #E.g. if there are no *.zip files f will be set to *.zip
    if [ -f "$f" ]; then
        echo "$f"
        mv "$f" "$tmpworkdir/"

        f="$tmpworkdir/$(basename $f)"

        #unzip
        unzip "$f" -d "$unzipdir/$(basename $f)"

        #copy classes from war to 'allclasses' dir
        find "$unzipdir" -type d -name 'classes' -exec cp -fR {} "$unzipdir/allclasses" \;
    fi
done

#########################
# Unpack all jars
#

#find "$unzipdir" -type f -name '*.jar' -exec unzip -o {} -d "$unzipdir/allclasses" \;

find "$unzipdir" -type f \( -name '*.jar' ! -name 'nimbus-oauth2-oidc-sdk.jar' ! -path '*/smon/sc/*' \) -exec unzip -o {} -d "$unzipdir/allclasses" \;


rm -fr $tmpworkdir
