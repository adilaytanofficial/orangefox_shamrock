#rm -rf out/
#mkdir -p out/target/product/shamrock/root
#mkdir -p out/target/product/shamrock/recovery/root/system/etc

export ALLOW_MISSING_DEPENDENCIES=true 
export FOX_BUILD_DEVICE=shamrock
export LC_ALL="C"

source build/envsetup.sh
lunch fox_shamrock-eng
mka adbd recoveryimage