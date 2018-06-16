Recommended settings for Mate 1.20

Profile:
default/linux/amd64/17.0/desktop

/etc/portage/package.keywords/keywords:
mate-base/* ~amd64
mate-extra/* ~amd64
app-arch/engrampa ~amd64
app-editors/pluma ~amd64
app-text/atril ~amd64
dev-libs/libmateweather ~amd64
media-gfx/eom ~amd64
media-libs/libmatemixer ~amd64
x11-misc/mozo ~amd64
x11-misc/mate-notification-daemon ~amd64
x11-terms/mate-terminal ~amd64
x11-themes/mate-backgrounds ~amd64
x11-themes/mate-icon-theme ~amd64
x11-themes/mate-themes ~amd64
x11-themes/mate-themes-meta ~amd64
x11-wm/marco ~amd64

/etc/portage/package.use/use:
app-text/atril caja
mate-base/mate-menus python
