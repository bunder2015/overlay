# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="OBS plugin to integrate with the NDI SDK"
HOMEPAGE="https://github.com/Palakis/obs-ndi"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	media-video/obs-studio
	media-video/ndi-sdk-bin
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Patch the correct path to the NDI library into the source
	sed -e "s:/usr/lib:/usr/lib64:g" \
		-i src/obs-ndi.cpp || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DLIBOBS_INCLUDE_DIR=/usr/include/obs/UI"
	)

	cmake_src_configure
}
