# Get time of startup
#res1=$(date +%s.%N)

# Patches

# Put the *.patch or *.diff file in the base folder of each indivisual repo
# where the patches need to applied


# Move to aogp source
cd ~/aogp-source

# Clean previous build
make clean

# repo sync will discard all external commits
repo sync -j50


# Get prebuilts
./vendor/cm/get-prebuilts


echo -e ""
echo -e ""
echo -e "Applying patches for Galaxy Grand..."
echo -e ""
echo -e ""

./patches/install-all.sh

echo -e ""
echo -e ""
echo -e "Fixing Chromium..."
echo -e ""
echo -e ""
cd external/chromium_org/
repo sync .
git am 00*
cd ../../


# Setup environment
echo -e ""
echo -e ""
echo -e "Setting up build environment..."
echo -e ""
echo -e ""
. build/envsetup.sh

# Set release type as NIGHTLY
export RELEASE_TYPE=NIGHTLY

# Lunch device
echo -e ""
echo -e ""
echo -e "Lunching device - i9082"
echo -e ""
echo -e ""
lunch cm_i9082-userdebug

echo -e ""
echo -e ""
echo -e "Starting compilation..."
echo -e ""
echo -e ""

# Start compilation
mka bacon
echo -e ""


# Copy the compiled zip to another folder
cp out/target/product/i9082/*NIGHTLY* ~/compiled_builds/i9082



# Get elapsed time
#res2=$(date +%s.%N)
#echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"