
cd AsmJit
mkdir -p build
cd tools
sed -i 's/^-DASMJIT_TEST=1"$/-DASMJIT_TEST=1 -DASMJIT_STATIC=1/' configure-makefiles.sh
./configure-makefiles.sh
cd ../build/Release
make all
