From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v3.18
Date: Mon, 27 Oct 2014 11:43:44 +0000
Message-ID: <20141027114344.GW18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qie/H+CJBZigrS0F"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qie/H+CJBZigrS0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.18-rc2

for you to fetch changes up to 1e2cf73e6bff3405cab85ded034f056ca99c375b:

  Merge remote-tracking branches 'spi/fix/dw', 'spi/fix/orion', 'spi/fix/pl022', 'spi/fix/rockchip' and 'spi/fix/spidev' into spi-linus (2014-10-27 11:26:54 +0000)

----------------------------------------------------------------
spi: Fixes for v3.18

Quite a few driver fixes in here, including some fairly substantial ones
for the recently added Rockchip driver, plus a fix for spidev to more
reliably support bidirectional transfers which is fairly large but
basically mechanical.  It's a bit more code than I'd like but all fixes.

----------------------------------------------------------------
Addy Ke (3):
      spi/rockchip: fix bug that case spi can't go as fast as slave request
      spi/rockchip: fix bug that cause spi transfer timed out in DMA duplex mode
      spi/rockchip: spi controller must be disabled in tx callback too

Greg Ungerer (1):
      spi: orion: fix potential NULL pointer de-reference

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/dw', 'spi/fix/orion', 'spi/fix/pl022', 'spi/fix/rockchip' and 'spi/fix/spidev' into spi-linus

Ray Jui (2):
      spi: spidev: Use separate TX and RX bounce buffers
      spi: pl022: Fix incorrect dma_unmap_sg

Thor Thayer (1):
      spi: dw: Initialize of_node to discover DT node children

 drivers/spi/spi-dw.c       |  1 +
 drivers/spi/spi-orion.c    |  2 +-
 drivers/spi/spi-pl022.c    |  2 +-
 drivers/spi/spi-rockchip.c | 50 ++++++++++++++++++++++-------
 drivers/spi/spidev.c       | 79 ++++++++++++++++++++++++++++++----------------
 5 files changed, 93 insertions(+), 41 deletions(-)

--qie/H+CJBZigrS0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUTi/vAAoJECTWi3JdVIfQJkQH/0o9CXtRTPPkXwZhqIJB25zy
C96z/r2ftGcGdJuuQ+a3pcZMrbv33chFG9V1HddV/eGAIiQvg1pLj2zcrLI2kEUS
dVEbZBXiCnTGjKFw/9pj8AE9596GxwCWgFdtl3rI3ZkerEr+gnAsLLKaVMfjjjAE
REizlQMkwNcfJ+u1yEROrelRE+b+QNjthypWxJoG+C7OOR7JGgU1lCdz+Q7OwSDq
+U4/uox5EgwdrGpMK+4qnIIeZy9rjj9KfkrebXHaBtahehkkRQ557IdC1qtzgM1Z
TzVm0aABkvwNBKFHqlmsPfWquOLMwDLMzRMuv3E3A5RM6TNuICmXxIh5x+7S6SU=
=u1MJ
-----END PGP SIGNATURE-----

--qie/H+CJBZigrS0F--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
