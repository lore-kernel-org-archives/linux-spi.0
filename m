From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v3.17
Date: Sun, 31 Aug 2014 13:20:45 +0100
Message-ID: <20140831122045.GD29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7QsOHKuLbhbLTwLB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7QsOHKuLbhbLTwLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.17-rc3

for you to fetch changes up to 360b2eaeb563896ab95db45eb7d1b83c9a04c292:

  Merge remote-tracking branches 'spi/fix/au1550', 'spi/fix/davinci', 'spi/fix/doc', 'spi/fix/dw', 'spi/fix/omap-mcspi', 'spi/fix/pxa2xx', 'spi/fix/rockchip' and 'spi/fix/rspi' into spi-linus (2014-08-30 19:28:04 +0100)

----------------------------------------------------------------
spi: Bug fixes for v3.17

A smattering of bug fixes for the SPI subsystem, all in driver code
which has seen active work recently and none of them with any great
global impact.

There's also a new ACPI ID for the pxa2xx driver which required no code
changes and the addition of kerneldoc for some structure fields that
were missing it and generating warnings during documentation builds as a
result.

----------------------------------------------------------------
Addy Ke (1):
      spi/rockchip: fixup incorrect dma direction setting

Alan Cox (1):
      spi/pxa2xx: Add ACPI ID for Intel Braswell

Andy Shevchenko (2):
      spi: dw-pci: fix bug when regs left uninitialized
      spi: dw: fix kernel crash due to NULL pointer dereference

Doug Anderson (1):
      spi/rockchip: Avoid accidentally turning off the clock

Geert Uytterhoeven (2):
      spi: sh-msiof: Fix leaking of unused DMA descriptors
      spi: rspi: Fix leaking of unused DMA descriptors

Grygorii Strashko (1):
      spi: davinci: fix SPI_NO_CS functionality

Jorge A. Ventura (1):
      spi/omap-mcspi: Fix the spi task hangs waiting dma_rx

Manuel Lauss (1):
      spi: spi-au1550: fix build failure

Mark Brown (2):
      Merge remote-tracking branch 'spi/fix/sh-msiof' into spi-linus
      Merge remote-tracking branches 'spi/fix/au1550', 'spi/fix/davinci', 'spi/fix/doc', 'spi/fix/dw', 'spi/fix/omap-mcspi', 'spi/fix/pxa2xx', 'spi/fix/rockchip' and 'spi/fix/rspi' into spi-linus

Thierry Reding (1):
      spi: Add missing kerneldoc bits

 drivers/spi/spi-au1550.c      |  2 +-
 drivers/spi/spi-davinci.c     | 16 ++++----
 drivers/spi/spi-dw-pci.c      |  2 +
 drivers/spi/spi-dw.c          |  2 +-
 drivers/spi/spi-omap2-mcspi.c |  3 +-
 drivers/spi/spi-pxa2xx.c      |  1 +
 drivers/spi/spi-rockchip.c    |  4 +-
 drivers/spi/spi-rspi.c        | 94 ++++++++++++++++++++++++++-----------------
 drivers/spi/spi-sh-msiof.c    | 71 +++++++++++++++++---------------
 drivers/spi/spi.c             |  1 +
 include/linux/spi/spi.h       |  7 ++++
 11 files changed, 121 insertions(+), 82 deletions(-)

--7QsOHKuLbhbLTwLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAxMaAAoJELSic+t+oim92vcP/2sFbhR4VcEFnXqndBOYlI7u
hfJZL23dO1RWpuGT3RGNgxOZv8vjAbZR/CzNc1ysENQIAEy/7L0OdymrHods2oIh
WF9SH192ynnlkxEZKf9de/Cxng/G6pKTTS+86PDii0oBaeiBRm4b8jWrU/v97Pd2
fNsUS9IdQ75eEiKWhapninFLeCzHCg+NxmqjSJXpUHnjn+94f/0HKRgJ2dZSUPhK
D5plWYD2QIXP+k+m5HjRhLLhKrEhCANcfy6u3Cb/KyS3BjIPx8bmVIFkag5qj+or
fkLXOWvNqyJakSUo+tImN/ukHRvTY2inYkjdESIDV7D/ziOSwRAyDwljCdlKpA7m
Px2twVGuPXzeXFz8Y3KhegM/y5P83oX5+BeN6I2ejEDjb8gDLjpaC+Qq4+RwVYFP
j+at4hXNpep32v3k0Al2tEnIfwT485tB0TUg95tr+mqzCbCk8F08cJn9GtmQiNUD
bSu7z8X5He0m01auCtJpjRpGFxSb/RfReOFkBuhliX4GMcZQ0MbIwhZ2GDQ7gPLi
aR5cH9kigckph+0d6hHNIs8ChUJ8xOp6jB1McP9CT4ugfx+BQBOe1HRcj2EBwbYw
Bnq3PTQsVkoTlP4Baajl8uf44XDVNHlmjdQA2Abgc6Hr1eTglC3C8DuwuSlbzd+c
XNjw0M0Hc27aWRAFmiK8
=h8pG
-----END PGP SIGNATURE-----

--7QsOHKuLbhbLTwLB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
