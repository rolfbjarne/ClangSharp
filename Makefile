LLVM_BIN_DIR=../artifacts/llvm/bin
LLVM_INSTALL_DIR=../artifacts/llvm/install
CLANGSHARP_ARTIFACTS_DIR=artifacts/rolf/clangsharp/bin/native
CLANGSHARP_ARTIFACTS_INSTALL_DIR=artifacts/rolf/clangsharp/install

LIBCLANGSHARP_DYLIB=$(CLANGSHARP_ARTIFACTS_INSTALL_DIR)/lib/libClangSharp.dylib

all:: $(LIBCLANGSHARP_DYLIB)


$(LIBCLANGSHARP_DYLIB): $(CLANGSHARP_FILES) Makefile
	@echo "Building libClangSharp.dylib..."
	mkdir -p $(CLANGSHARP_ARTIFACTS_DIR)
	cd $(CLANGSHARP_ARTIFACTS_DIR) && cmake -DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) -DCMAKE_INSTALL_PREFIX=$(abspath $(CLANGSHARP_ARTIFACTS_INSTALL_DIR)) -DPATH_TO_LLVM=$(abspath $(LLVM_INSTALL_DIR)) $(abspath .)
	cd $(CLANGSHARP_ARTIFACTS_DIR) && make install
	codesign -s - $@


rere:
	git clean -xfd
	./nuget-pack.sh
	cd sources/ClangSharpPInvokeGenerator && dotnet run -p:Mode=GenerateClang -bl
	$(MAKE) generateclangsharp

generateclangsharp:
	cd sources/ClangSharpPInvokeGenerator && dotnet run -p:Mode=GenerateClangSharp -bl
