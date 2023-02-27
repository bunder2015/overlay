# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="NewTek NDI SDK"
HOMEPAGE="https://www.newtek.com/ndi/sdk/"
SRC_URI="https://ndi.palakis.fr/sdk/ndi-sdk-${PV}-Linux.tar.gz"

LICENSE="NDI_SDK"
SLOT="0"
#KEYWORDS="~amd64"
IUSE=""

MY_PV="5.0.10"

# supress QA warnings about stripping etc., i.e. stuff we cannot change since we install prebuilt binaries
QA_PREBUILT="usr/lib64/libndi.so.${MY_PV}"

DEPEND=""
RDEPEND="
	net-dns/avahi[dbus]
	${DEPEND}"

src_unpack() {
	unpack ${A}
	tar xvf "${WORKDIR}/ndi-sdk-${PV}-Linux"

	ARCHIVE=`awk '/^__NDI_ARCHIVE_BEGIN__/ { print NR+1; exit 0; }' "${WORKDIR}/Install_NDI_SDK_v5_Linux.sh"`
	tail -n+$ARCHIVE "${WORKDIR}/Install_NDI_SDK_v5_Linux.sh" | tar xvz

	S="${WORKDIR}/NDI SDK for Linux/"
}

src_install() {
	dolib.so "${S}/lib/x86_64-linux-gnu/libndi.so.${MY_PV}"
	dosym "libndi.so.${MY_PV}" "/usr/lib64/libndi.so.5"
	dosym "libndi.so.5" "/usr/lib64/libndi.so"

	for header in `ls "${S}/include/"`; do
		doheader "${S}/include/${header}"
	done
}
