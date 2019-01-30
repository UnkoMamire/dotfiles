#!/usr/bin/env sh

cd `dirname $0`
dotdir=`pwd`

for f in .??*; do
	[ $f = '.git' ] && continue
	for g in `find $f`; do
		if [ -d $g ]; then
			mkdir -p ~/$g
		elif [ -f $g ]; then
			ln -sfnv $dotdir/$g ~/$g
		fi
	done
done

for f in $dotdir/afterlink_scripts/* ; do
	$f
done
