#!/bin/bash -eux

set -o pipefail
IFS=$'\n\t'

make cl -C ../../..

(
  cd ../../sources/ClangSharp.Interop
  dotnet format ClangSharp.Interop.csproj
)

dotnet format *.csproj

export FORCE_RUN=1
dotnet test -f net10.0
