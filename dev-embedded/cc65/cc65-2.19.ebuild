# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="complete cross development package for 65(C)02 systems"
HOMEPAGE="https://cc65.github.io/cc65/"
SRC_URI="https://github.com/cc65/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( app-text/linuxdoc-tools )"
RDEPEND=""

src_compile() {
	emake
	use doc && emake -C doc
}

src_install() {
	PREFIX=/usr DESTDIR=${D} emake install
}
