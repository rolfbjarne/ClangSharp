#!/bin/bash -eu

set -o pipefail
IFS=$'\n\t'

cp ~/Downloads/LLVM-21.1.6-macOS-ARM64/lib//libclang.dylib packages/libclang/libclang.runtime.osx-arm64/

make all

cp artifacts/rolf/clangsharp/install/lib/libClangSharp.dylib packages/libClangSharp/libClangSharp.runtime.osx-arm64

for file in $(git ls-files '*.nuspec'); do
  echo "===="
  echo "$file"
  if grep 'file src="lib' $file; then
    FILE=$(grep 'file src="lib' $file | sed -e 's/.*src="//' -e 's/".*//')
    FILE=${FILE/\\/\/}
    DIR=$(dirname $file)
    FN=$DIR/$FILE
    if test -f "$FN"; then
      echo "Already exists: $FN"
    else
      echo "Creating placeholder file $FN"
      echo "Placeholder" > $FN
    fi
  fi

  nuget pack $file &
done

wait
