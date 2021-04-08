#!/usr/bin/env bash

#Change this env variable to the number of processors you have
if [ -f /proc/cpuinfo ]; then
	JOBS=$(grep flags /proc/cpuinfo |wc -l)
elif [ ! -z $(which sysctl) ]; then
	JOBS=$(sysctl -n hw.ncpu)
else
	JOBS=2
fi

export ANDROID_API=28
export ANDROID_ABI=23
export ANDROID_CPU=arm64-v8a
source setenv-android.sh
cd ..
make -j$JOBS -f GNUmakefile-cross distclean
make -j$JOBS -f GNUmakefile-cross static dynamic
