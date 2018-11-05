#!/usr/bin/env sh

dotdir=`dirname $0`
cd $dotdir

for f in setup_scripts/* ; do
	cat $f
done

