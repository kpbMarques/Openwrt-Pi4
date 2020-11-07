#!/bin/bash


# updade and install deps

sudo pacman -Syu --noconfirm
sudo pacman -S --needed bash bc bin86 binutils bzip2 cdrkit core/which diffutils \
 fastjar findutils flex gawk gcc gettext git intltool libusb libxslt make ncurses \
  openssl patch perl-extutils-makemaker pkgconf python3 rsync sharutils time unzip \
  util-linux wget zlib --noconfirm


# Env systems
BASE_DIR=$(pwd)

unset SED
unset GREP_OPTIONS
export GREP_OPTIONS=
export PATH=$PATH:$BASE_DIR/openwrt/openwrt/staging_dir/host/bin
export PATH=$PATH:$BASE_DIR/openwrt/openwrt/staging_dir/toolchain-mips_34kc_gcc-5.3.0_musl-1.1.16



# Clone Repo - You must uncomment the line if the openwrt is not in here
#git clone https://github.com/openwrt/openwrt.git

#From OpenWRT Source Tree

cp  $BASE_DIR/.config  $BASE_DIR/openwrt/.config
cp  $BASE_DIR/feeds.conf  $BASE_DIR/openwrt/feeds.conf

cd $BASE_DIR/openwrt || exit

./scripts/feeds update -a
./scripts/feeds install -a

#  create a custom banner:

# Set text banner.
cat <<EOF > package/base-files/files/etc/banner.txt

#!/bin/bash
echo \$PWD
echo $PWD

EOF

