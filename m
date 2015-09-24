From: Mark Brown <broonie-ZdStD+zOWIVAfugRpC6u6w@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v4.3
Date: Thu, 24 Sep 2015 10:39:30 -0700
Message-ID: <20150924173930.GB30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S9LeEiRi8vXSwqvt"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--S9LeEiRi8vXSwqvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.3-rc2

for you to fetch changes up to 711e020cae9cd105d81a783686cb8c8059c08b2c:

  Merge remote-tracking branches 'spi/fix/spidev' and 'spi/fix/xtfpga' into spi-linus (2015-09-22 09:48:41 -0700)

----------------------------------------------------------------
spi: Fixes for v4.3

A disappointingly large collection of fixes for SPI issues, though
almost all in drivers (and there mainly the newly added Mediatek
driver) and the core fixes are documentation and error handling.  The
driver fixes are all of the usual important if you see them variety.

----------------------------------------------------------------
Alexandre Belloni (1):
      spi: atmel: remove warning when !CONFIG_PM_SLEEP

Geliang Tang (1):
      spi: fix kernel-doc warnings in spi.h

Guenter Roeck (1):
      spi: Fix documentation of spi_alloc_master()

Javier Martinez Canillas (1):
      spi: mediatek: fix wrong error return value on probe

Leilk Liu (4):
      spi: mediatek: remove clk_disable_unprepare()
      spi: mediatek: fix spi clock usage error
      spi: Mediatek: Document devicetree bindings update for spi bus
      spi: mediatek: fix spi cs polarity error

Luis de Bethencourt (1):
      spi: meson: Fix module autoload for OF platform driver

Mark Brown (3):
      Merge tag 'v4.3-rc1' into spi-fix-doc
      Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/bcm2835', 'spi/fix/doc', 'spi/fix/mediatek', 'spi/fix/meson', 'spi/fix/mtk' and 'spi/fix/pxa2xx' into spi-linus
      Merge remote-tracking branches 'spi/fix/spidev' and 'spi/fix/xtfpga' into spi-linus

Martin Sperl (1):
      spi: bcm2835: BUG: fix wrong use of PAGE_MASK

Max Filippov (1):
      spi: xtensa-xtfpga: fix register endianness

Sudip Mukherjee (1):
      spi: spidev: fix possible NULL dereference

Tan, Jui Nee (1):
      spi: spi-pxa2xx: Check status register to determine if SSSR_TINT is disabled

 .../devicetree/bindings/spi/spi-mt65xx.txt         | 16 ++++---
 drivers/spi/spi-atmel.c                            |  2 +
 drivers/spi/spi-bcm2835.c                          |  6 +--
 drivers/spi/spi-meson-spifc.c                      |  1 +
 drivers/spi/spi-mt65xx.c                           | 53 ++++++++++------------
 drivers/spi/spi-pxa2xx.c                           |  4 ++
 drivers/spi/spi-xtensa-xtfpga.c                    |  4 +-
 drivers/spi/spi.c                                  |  3 +-
 drivers/spi/spidev.c                               |  3 +-
 include/linux/spi/spi.h                            |  2 +-
 10 files changed, 49 insertions(+), 45 deletions(-)

--S9LeEiRi8vXSwqvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWBDVSAAoJECTWi3JdVIfQvzkH/3j6b7nUDzNvgOreDshRyMbq
9a9BZ2CLEtwHMD8wq7NNhq1qNJ55qt9iWr9wtMFPl4Dyii++OXcJpTUVRtD1Yk32
9eYeQTSBN3ANqjTnxNt3wtMf1G/toARNENQKDef1dXSWAu642pq7OQTV1yfhs9Fi
KGveP74wOYUFHHYSeXX8OmYvLxEmxk89/wBN2164I4mxSLNULfnAOTxcqyjg4uFE
sSjKaJVYVRzQ9xZEwLoiFwjYNNo8b0TR2txZzpC4C5X+GVubtpRSeDJ8OAo1pSpM
1056x53kCoknZ8mfVVkYi4s2UVrfPeykv9zVhRaS7izXwELXZpjUkLO7mLqGvZE=
=c4UQ
-----END PGP SIGNATURE-----

--S9LeEiRi8vXSwqvt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
