#!/bin/sh
. ./tools/getAllPackageFolders.sh
for element in "${packageFoldersArray[@]}"; do
  cd "$element"
  pwd
  fvm dart pub run build_runner build --delete-conflicting-outputs
  cd ../
done
