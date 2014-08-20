# Android Compilation Script
#
# This script automates the process of compiling android
# operating system on build servers
#
# Copyright (C) 2014 Shubhang Rathore
#
# This script is to compile android firmware for
# Samsung Galaxy Grand i9082
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Get time of startup
res1=$(date +%s.%N)


# Patches

# Put the *.patch or *.diff file in the base folder of each indivisual repo
# where the patches need to applied


echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#          COMPILING ANDROID          #"
echo -e "#                                     #"
echo -e "#   SAMSUNG GALAXY GRAND DUOS i9082   #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""


# Change directory to android source
cd ~/aogp-source

# Clean previous build
echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#              CLEANING               #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""

make clean


# Fetch and sync source
echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#            SYNCING SOURCE           #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""

repo sync -j50


# Get prebuilts
echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#          FETCHING PREBUILTS         #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""

./vendor/cm/get-prebuilts


# Patching source
echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#           APPLYING PATCHES          #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""

./patches/install-all.sh

cd external/chromium_org/
repo sync .
git am 00*
cd ../../


# Setup environment
echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#           BUILD ENVIRONMENT         #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""

. build/envsetup.sh


# Set extra build flags

# Set release type as NIGHTLY
export RELEASE_TYPE=NIGHTLY


# Lunch device
echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#            LUNCHING DEVICE          #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""

lunch cm_i9082-userdebug


# Start compilation
echo -e ""
echo -e "#######################################"
echo -e "#                                     #"
echo -e "#               COMPILING             #"
echo -e "#                                     #"
echo -e "#######################################"
echo -e ""

mka bacon
echo -e ""


# Copy the compiled zip to another folder
cp out/target/product/i9082/*NIGHTLY* ~/compiled_builds/i9082


# Get elapsed time
res2=$(date +%s.%N)
echo -e ""
echo -e ""
echo -e "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
echo -e ""
echo -e ""
