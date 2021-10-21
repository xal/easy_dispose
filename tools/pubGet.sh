#!/bin/sh
. ./tools/getAllPackageFolders.sh
for element in "${packageFoldersArray[@]}"; do
  cd "$element"
  pwd
  fvm dart pub get
  cd ../
done
