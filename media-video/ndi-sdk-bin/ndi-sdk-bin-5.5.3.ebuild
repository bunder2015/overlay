# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="NewTek NDI SDK"
HOMEPAGE="https://www.newtek.com/ndi/sdk/"
SRC_URI="https://github.com/Palakis/obs-ndi/releases/download/4.11.0-RC/libndi5_${PV}-1_amd64.deb"

LICENSE="NDI_SDK"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# supress QA warnings about stripping etc., i.e. stuff we cannot change since we install prebuilt binaries
QA_PREBUILT="usr/lib64/libndi.so.${PV}"

DEPEND=""
RDEPEND="
	net-dns/avahi[dbus]
	${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	dolib.so "${S}/usr/lib/libndi.so.${PV}"
	dosym "libndi.so.${PV}" "/usr/lib64/libndi.so.5"
	dosym "libndi.so.5" "/usr/lib64/libndi.so"
}
