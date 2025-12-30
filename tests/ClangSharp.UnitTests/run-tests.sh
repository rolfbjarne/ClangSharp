#!/bin/bash -eux

set -o pipefail
IFS=$'\n\t'

make cl -C ../../..

(
  cd ../../
  dotnet format
)

dotnet format *.csproj

export FORCE_RUN=1
dotnet test -f net10.0
