# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-r1

DESCRIPTION="Linux CLI tool providing real-time system resource monitoring"

HOMEPAGE="https://github.com/scottchiefbaker/dool"

SRC_URI="https://github.com/scottchiefbaker/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~amd64 ~arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"
BDEPEND="${PYTHON_DEPS}"

src_install() {
	# Install the main script
	python_foreach_impl python_doscript dool

	# Install plugins
	insinto /usr/share/dool
	doins plugins/*.py

	# Install man page
	doman docs/dool.1
}
