#!/bin/bash -eux

set -o pipefail
IFS=$'\n\t'

# "commandLineArgs": "\"@$(MSBuildProjectDirectory)/Properties/GenerateClangSharp.rsp\" --file-directory \"$(MSBuildProjectDirectory)/..\" --include-directory \"$(LLVMIncludePath)\" --libraryPath $(LibClangSharpName)"

D=$(pwd)

rm -rf ../sources

dotnet build
cp ../../../artifacts/llvm/bin/lib/libclang.dylib /Users/rolf/work/dotnet/ClangSharp/ClangSharp/artifacts/bin/sources/ClangSharpPInvokeGenerator/Debug/net10.0/

/Users/rolf/work/dotnet/ClangSharp/ClangSharp/artifacts/bin/sources/ClangSharpPInvokeGenerator/Debug/net10.0/ClangSharpPInvokeGenerator \
  @$D/Properties/GenerateClangSharp.rsp \
  --file-directory $D/../ \
  --include-directory /Applications/Xcode_26.2.0.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/v1 \
  --include-directory /Users/rolf/work/dotnet/ClangSharp/ClangSharp/sources/ClangSharpPInvokeGenerator/../../../artifacts/llvm/install/include \
  --include-directory /Users/rolf/work/dotnet/ClangSharp/ClangSharp/sources/ClangSharpPInvokeGenerator/../../../artifacts/llvm/install/lib/clang/21/include \
  --include-directory /Applications/Xcode_26.2.0.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include \
  --include-directory /Users/rolf/work/dotnet/ClangSharp/artifacts/clangsharp/install/include/ \
  --libraryPath libClangSharp || true


if test -f ../sources/ClangSharp/Interop/clangsharp.cs; then
  sed -i '' 's/class clangsharp/class @clangsharp/' ../sources/ClangSharp/Interop/clangsharp.cs
  cp ../sources/ClangSharp/Interop/clangsharp.cs ../ClangSharp.Interop/clangsharp/clangsharp.cs
  git diff ../ClangSharp.Interop/clangsharp/clangsharp.cs
fi
