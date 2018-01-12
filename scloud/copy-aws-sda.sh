#!/bin/bash

display_usage() {
	echo Usage:
	echo copy-aws-sda.sh YY MM folder
	echo YY - Version year
	echo MM - Version month
	echo folder - destination folder
}

#init environment variables

#get full path of the directory where this script resides
script="$0"
scriptdir="$(dirname $(readlink -f $script))"

source $scriptdir/prepare-env.sh $1 $2
INIT_ENV_RESULT=$?
if [ ! $INIT_ENV_RESULT -eq 0 ]; then
  if [ $INIT_ENV_RESULT -eq 2 ]; then
    echo
    display_usage
  fi
  echo
  echo "Copy aws SDAs failed!"
	exit 1
fi

if [ $# -lt 3 ]; then
  echo
  display_usage
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

DESTFOLDER=$3

if [ ! -d $VERSION_KIT_HOME/data ]; then
	echo Not found $VERSION_KIT_HOME/data
fi

if [ ! -d $DESTFOLDER ]; then
	mkdir -p $DESTFOLDER
fi


cp -f $VERSION_KIT_HOME/data/soref.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSFLT.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSFRO.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSFXA.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSHRM.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSWEB.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSDEI.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSEDI.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSGAP.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSMRP.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSOBK.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSOHH.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSPRC.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSRPD.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSWSS.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefCAPI.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefCSEC.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefITAS.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefPIRW.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSAGR.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSBIT.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSCLD.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSCQM.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSCWI.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSDWH.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSEMS.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSMLM.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSMOB.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSMON.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSMST.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSOFF.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSPOS.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSPRJ.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSPRV.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSTLN.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSTRL.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSWMS.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSWST.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSZPM.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefXHRS.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefPRKS.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

cp -f $VERSION_KIT_HOME/data/sorefSICM.sda $DESTFOLDER
if [ ! $? -eq 0 ]; then
  echo
  echo "Copy aws SDAs failed!"
  exit 1
fi

echo "Done."