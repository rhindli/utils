#!bin/bash

SOURCE_WORKSPACE=$1
DEST_WORKSPACE=$2


if [ -z "$SOURCE_WORKSPACE" ]; then
	echo Usage:
	echo
	echo copyAWSprojects.sh source [destination]
	echo.
	echo source          source workspace directory
	echo destination     destination workspace directory
	echo                 If not specified copy is performed in current directory

	exit 1
fi

if [ ! -d $SOURCE_WORKSPACE ]; then
	echo Source workspace folder "$SOURCE_WORKSPACE" does not exists.
	exit 1
fi

if [ -z $DEST_WORKSPACE ]; then
	DEST_WORKSPACE=$(pwd)
fi

if [ ! -d $DEST_WORKSPACE ]; then
	mkdir -p $DEST_WORKSPACE
fi

#remove previous projects
rm -fr $DEST_WORKSPACE/.metadata
rm -fr $DEST_WORKSPACE/capi
rm -fr $DEST_WORKSPACE/core-business
rm -fr $DEST_WORKSPACE/core-framework
rm -fr $DEST_WORKSPACE/csec
rm -fr $DEST_WORKSPACE/db
rm -fr $DEST_WORKSPACE/dev
rm -fr $DEST_WORKSPACE/extend
rm -fr $DEST_WORKSPACE/installer
rm -fr $DEST_WORKSPACE/lib
rm -fr $DEST_WORKSPACE/pbit
rm -fr $DEST_WORKSPACE/pirw
rm -fr $DEST_WORKSPACE/prks
rm -fr $DEST_WORKSPACE/reporting
rm -fr $DEST_WORKSPACE/sagr
rm -fr $DEST_WORKSPACE/scld
rm -fr $DEST_WORKSPACE/scqm
rm -fr $DEST_WORKSPACE/scwi
rm -fr $DEST_WORKSPACE/sdei
rm -fr $DEST_WORKSPACE/sedi
rm -fr $DEST_WORKSPACE/sems
rm -fr $DEST_WORKSPACE/server
rm -fr $DEST_WORKSPACE/sfro
rm -fr $DEST_WORKSPACE/sfxa
rm -fr $DEST_WORKSPACE/sgap
rm -fr $DEST_WORKSPACE/shrmWs
rm -fr $DEST_WORKSPACE/sicm
rm -fr $DEST_WORKSPACE/smlm
rm -fr $DEST_WORKSPACE/smon
rm -fr $DEST_WORKSPACE/smrp
rm -fr $DEST_WORKSPACE/smstr
rm -fr $DEST_WORKSPACE/smstrWS
rm -fr $DEST_WORKSPACE/sobk
rm -fr $DEST_WORKSPACE/soff
rm -fr $DEST_WORKSPACE/sohh
rm -fr $DEST_WORKSPACE/spos
rm -fr $DEST_WORKSPACE/sprc
rm -fr $DEST_WORKSPACE/sprx
rm -fr $DEST_WORKSPACE/srpd
rm -fr $DEST_WORKSPACE/stln
rm -fr $DEST_WORKSPACE/strl
rm -fr $DEST_WORKSPACE/sweb
rm -fr $DEST_WORKSPACE/sweb-themes
rm -fr $DEST_WORKSPACE/swms
rm -fr $DEST_WORKSPACE/swss


#copy projects
cp -r $SOURCE_WORKSPACE/.metadata $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/capi $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/core-business $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/core-framework $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/csec $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/db $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/dev $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/extend $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/installer $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/lib $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/pbit $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/pirw $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/prks $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/reporting $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sagr $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/scld $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/scqm $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/scwi $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sdei $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sedi $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sems $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/server $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sfro $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sfxa $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sgap $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/shrmWs $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sicm $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/smlm $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/smon $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/smrp $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/smstr $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/smstrWS $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sobk $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/soff $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sohh $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/spos $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sprc $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sprx $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/srpd $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/stln $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/strl $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sweb $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/sweb-themes $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/swms $DEST_WORKSPACE
cp -r $SOURCE_WORKSPACE/swss $DEST_WORKSPACE
