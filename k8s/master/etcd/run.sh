#!/bin/bash

ETCD_BIN=/etcd_home/bin
ETCD_DATA=/etcd_home/data

mkdir -p $ETCD_BIN
mkdir -p $ETCD_DATA

mv etcd.tar.gz $ETCD_BIN/
mv run.sh $ETCD_BIN/

cd $ETCD_BIN
tar zxf etcd.tar.gz
rm etcd.tar.gz

ln -s $ETCD_BIN/etcd /usr/local/bin/etcd
ln -s $ETCD_BIN/etcdctl /usr/local/bin/etcdctl

#$ETCD_BIN/etcd --version

#cp etcd /usr/local/bin/etcd

which etcd

etcd --version
