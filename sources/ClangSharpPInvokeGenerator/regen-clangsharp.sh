#!/bin/bash -eux

set -o pipefail
IFS=$'\n\t'

# "commandLineArgs": "\"@$(MSBuildProjectDirectory)/Properties/GenerateClangSharp.rsp\" --file-directory \"$(MSBuildProjectDirectory)/..\" --include-directory \"$(LLVMIncludePath)\" --libraryPath $(LibClangSharpName)"

D=$(pwd)

dotnet run --no-launch-profile -- \
  @$D/Properties/GenerateClangSharp.rsp \
  --file-directory $D/../ \
  --include-directory /Applications/Xcode_26.2.0.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/v1 \
  --include-directory /Users/rolf/work/dotnet/ClangSharp/ClangSharp/sources/ClangSharpPInvokeGenerator/../../../artifacts/llvm/install/include \
  --include-directory /Users/rolf/work/dotnet/ClangSharp/ClangSharp/sources/ClangSharpPInvokeGenerator/../../../artifacts/llvm/install/lib/clang/21/include \
  --include-directory /Applications/Xcode_26.2.0.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include \
  --include-directory /Users/rolf/work/dotnet/ClangSharp/artifacts/clangsharp/install/include/ \
