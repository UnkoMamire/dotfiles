#!/usr/bin/env sh

dotdir=`dirname $0`
cd $dotdir

for f in .??*; do
	[ $f = '.git' ] && continue
	for g in `find $f`; do
		if [ -d $g ]; then
			echo mkdir -p $g
		elif [ -f $g ]; then
			echo ln -sfnv $dotdir/$g ~/$g
		fi
	done
done

