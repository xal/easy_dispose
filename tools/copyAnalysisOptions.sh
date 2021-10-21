#!/bin/sh
. ./tools/getAllPackageFolders.sh
for element in "${packageFoldersArray[@]}"; do
  if [ "$element" != "easy_dispose" ]; then
    echo "$element"
    cp easy_dispose/analysis_options.yaml "$element/analysis_options.yaml"
  fi
done
