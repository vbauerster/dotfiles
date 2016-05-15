#!/bin/sh

for file in "$PWD"/*; do
  nf=$(basename "$file" .$1)
  mv "$file" "$nf.$2"
done
