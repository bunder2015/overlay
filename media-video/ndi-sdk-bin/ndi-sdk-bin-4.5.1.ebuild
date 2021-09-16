# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="NewTek NDI SDK"
SRC_URI="https://ndi.palakis.fr/sdk/ndi-sdk-${PV}-Linux.gz"

LICENSE="NDI_SDK"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
#RESTRICT="fetch"

HOMEPAGE="https://www.newtek.com/ndi/sdk/"

# supress QA warnings about stripping etc., i.e. stuff we cannot change since we install prebuilt binaries
QA_PREBUILT="usr/lib64/libndi.so.${PV}"

DEPEND=""
RDEPEND="
	net-dns/avahi[dbus]
	${DEPEND}"

src_unpack() {
	unpack ${A}
	tar xvf "${WORKDIR}/ndi-sdk-${PV}-Linux"

	ARCHIVE=`awk '/^__NDI_ARCHIVE_BEGIN__/ { print NR+1; exit 0; }' "${WORKDIR}/InstallNDISDK_v4_Linux.sh"`
	tail -n+$ARCHIVE "${WORKDIR}/InstallNDISDK_v4_Linux.sh" | tar xvz
	S="${WORKDIR}/NDI SDK for Linux/"
}

src_install() {
	dolib.so "${S}/lib/x86_64-linux-gnu/libndi.so.${PV}"
	dosym "libndi.so.${PV}" "/usr/lib64/libndi.so.4"
	dosym "libndi.so.4" "/usr/lib64/libndi.so"
	for header in `ls "${S}/include/"`; do
		doheader "${S}/include/${header}"
	done
}
