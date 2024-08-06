# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="NewTek NDI SDK"
HOMEPAGE="https://www.ndi.tv/sdk/"
SRC_URI="https://downloads.ndi.tv/SDK/NDI_SDK_Linux/Install_NDI_SDK_v6_Linux.tar.gz -> Install_NDI_SDK_v${PV}_Linux.tar.gz"

LICENSE="NDI_SDK"
SLOT="0"
KEYWORDS="-amd64"
IUSE=""

# supress QA warnings about stripping etc., i.e. stuff we cannot change since we install prebuilt binaries
QA_PREBUILT="usr/lib64/libndi.so.${PV}"

DEPEND=""
RDEPEND="
	net-dns/avahi[dbus]
	${DEPEND}"

src_unpack() {
	unpack ${A}

	ARCHIVE=`awk '/^__NDI_ARCHIVE_BEGIN__/ { print NR+1; exit 0; }' "${WORKDIR}/Install_NDI_SDK_v6_Linux.sh"`
	tail -n+$ARCHIVE "${WORKDIR}/Install_NDI_SDK_v6_Linux.sh" | tar xvz

	S="${WORKDIR}/NDI SDK for Linux"
}

src_install() {
	dolib.so "${S}/lib/x86_64-linux-gnu/libndi.so.${PV}"
	dosym "libndi.so.${PV}" "/usr/lib64/libndi.so.6"
	dosym "libndi.so.6" "/usr/lib64/libndi.so"

	for header in `ls "${S}/include/"`; do
		doheader "${S}/include/${header}"
	done
}
