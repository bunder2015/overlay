# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PV="${PV/_rc/-RC}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="OBS plugin to integrate with the NDI SDK"
HOMEPAGE="https://github.com/Palakis/obs-ndi"
SRC_URI="https://github.com/Palakis/obs-ndi/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt6"

DEPEND="
	qt6? (
		dev-qt/qtbase:6
	)
	!qt6? (
		dev-qt/qtcore:5
	)
	>=media-video/obs-studio-28
	~media-video/ndi-sdk-bin-5.5.3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	# Patch the correct path to the NDI library into the source
	sed -e "s:/usr/lib:/usr/lib64:g" \
		-i "src/${PN}.cpp" || die

	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}

src_install() {
	insinto /usr/lib64/obs-plugins
	doins "../${MY_P}_build/rundir/RelWithDebInfo/obs-plugins/64bit/${PN}.so"

	insinto "/usr/share/obs/obs-plugins/${PN}"
	doins -r "../${MY_P}_build/rundir/RelWithDebInfo/data/obs-plugins/${PN}/data/locale"

	dodoc README.md
}
