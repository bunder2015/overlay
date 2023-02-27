# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="OBS plugin to integrate with the NDI SDK"
HOMEPAGE="https://github.com/Palakis/obs-ndi"
SRC_URI="https://github.com/Palakis/obs-ndi/archive/dummy-tag-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-qt/qtcore
	media-video/obs-studio
	media-video/ndi-sdk-bin"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	S="${WORKDIR}/${PN}-dummy-tag-${PV}"
}

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
	insopts -m755
	doins "../${P}_build/rundir/Gentoo/obs-plugins/64bit/${PN}.so"

	insinto "/usr/share/obs/obs-plugins/${PN}"
	doins -r "../${P}_build/rundir/Gentoo/data/obs-plugins/${PN}/data/locale"

	dodoc README.md
}
