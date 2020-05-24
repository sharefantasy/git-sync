#! /bin/bash
set -Ce

# looking for the dir to be sync
if [ ! $AUTO_SYNC_DIR ];then
  echo "Please set up \$AUTO_SYNC_DIR first"
  exit 1
fi
echo "sync dir: " $AUTO_SYNC_DIR

# setup logging dir

SCRIPT_DIR=$(dirname $(realpath $0))
LOG_DIR=$SCRIPT_DIR/log
echo $LOG_DIR
mkdir -p $LOG_DIR
LOG_FILE=$LOG_DIR/`date "+%Y-%m-%d"`.log
if [ ! -f $LOG_FILE ];then
  touch $LOG_FILE
fi

# sync and log
pushd $AUTO_SYNC_DIR
echo "note dir: " $AUTO_SYNC_DIR | tee -a $LOG_FILE
echo "===================="`date +%Y-%m-%dT%H:%M:%S`"====================" | tee -a $LOG_FILE
$SCRIPT_DIR/git-sync sync | tee -a $LOG_FILE 
popd
