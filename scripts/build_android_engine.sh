#!/bin/bash

cd $TRAVIS_BUILD_DIR/xash3d-android-project
sh android/gen-version.sh travis build
sh android/gen-config.sh test
python2 scripts/makepak.py xash-extras android/assets/extras.pak
ndk-build -j2 APP_CFLAGS="-w" NDK_CCACHE=ccache
cd ./android/
ant debug -Dtest.version=1
cd ../
cp bin/xashdroid-debug.apk $TRAVIS_BUILD_DIR/xash3d-generic.apk
tar cJf $TRAVIS_BUILD_DIR/android-debug-symbols.txz obj/local/*/*.so
