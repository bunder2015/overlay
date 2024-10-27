# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="OBS plugin to integrate with the NDI SDK"
HOMEPAGE="https://github.com/DistroAV/DistroAV"
SRC_URI="https://github.com/DistroAV/DistroAV/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="
	dev-qt/qtbase:6
	>=media-video/obs-studio-30
	>=media-video/ndi-sdk-bin-6.0.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	default

	# Patch the correct path to the NDI library into the source
	sed -e "s:/usr/lib:/usr/lib64:g" \
		-i "src/plugin-main.cpp" || die

	cmake_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE=$(usex debug RelWithDebInfo Release)

	local mycmakeargs=(
		-DENABLE_QT=1
	)

	cmake_src_configure
}

src_install() {
	insinto /usr/lib64/obs-plugins
	doins "../${P}_build/distroav.so"

	insinto "/usr/share/obs/obs-plugins/${PN}"
	doins -r "../${P}/data/locale"

	dodoc README.md
}
