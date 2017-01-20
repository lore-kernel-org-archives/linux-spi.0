From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v4.10
Date: Fri, 20 Jan 2017 15:11:40 +0000
Message-ID: <20170120151140.qer24dbfp3sivysq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ijvkimhd7ly3x2id"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ijvkimhd7ly3x2id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fafd67940774733fa97f4b09412aea6981b82e0a:

  Merge remote-tracking branches 'spi/topic/spidev', 'spi/topic/sunxi', 'spi/topic/ti-qspi', 'spi/topic/topcliff-pch' and 'spi/topic/xlp' into spi-next (2016-12-12 15:54:20 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.10-rc4

for you to fetch changes up to 52cc720c568efd8fd454053b98fe4b4fd94688fe:

  Merge remote-tracking branch 'spi/fix/sh-msiof' into spi-linus (2017-01-17 18:48:13 +0000)

----------------------------------------------------------------
spi: Fixes for v4.10

The usual small smattering of driver specific fixes.  A few bits that
stand out here:

 - The R-Car patches adding fallbacks are just adding new compatible
   strings to the driver so that device trees are written in a more
   robustly future proof fashion, this isn't strictly a fix but it's
   just new IDs and it's better to get it into mainline sooner to
   improve the ABI.
 - The DesignWare "switch to new API part 2" patch is actually a
   misleadingly titled fix for a bit that got missed in the original
   conversion.

----------------------------------------------------------------
Andy Shevchenko (2):
      spi: dw-mid: switch to new dmaengine_terminate_* API (part 2)
      spi: pxa2xx: add missed break

Christophe JAILLET (1):
      spi: spi-axi: Free resources on error path

Colin Ian King (1):
      spi: armada-3700: fix unsigned compare than zero on irq

Dan Carpenter (1):
      spi: armada-3700: Set mode bits correctly

Geert Uytterhoeven (1):
      spi: SPI_FSL_DSPI should depend on HAS_DMA

Kevin Hilman (1):
      spi: davinci: use dma_mapping_error()

Mark Brown (2):
      Merge remote-tracking branches 'spi/fix/armada', 'spi/fix/axi', 'spi/fix/davinci', 'spi/fix/dw', 'spi/fix/fsl-dspi' and 'spi/fix/pxa2xx' into spi-linus
      Merge remote-tracking branch 'spi/fix/sh-msiof' into spi-linus

Phil Reid (1):
      spi: dw: Make debugfs name unique between instances

Simon Horman (2):
      spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings
      spi: sh-msiof: Do not use C++ style comment

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 19 +++++++++++++------
 drivers/spi/Kconfig                                |  1 +
 drivers/spi/spi-armada-3700.c                      | 11 ++++++-----
 drivers/spi/spi-axi-spi-engine.c                   |  3 ++-
 drivers/spi/spi-davinci.c                          |  4 ++--
 drivers/spi/spi-dw-mid.c                           |  4 ++--
 drivers/spi/spi-dw.c                               |  5 ++++-
 drivers/spi/spi-pxa2xx.c                           |  1 +
 drivers/spi/spi-sh-msiof.c                         |  4 +++-
 9 files changed, 34 insertions(+), 18 deletions(-)

--ijvkimhd7ly3x2id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliCKKwACgkQJNaLcl1U
h9CZqgf/SRp/zTh5YQoP/YFOSozqhKlcSiEtWGD6o2dBbR5aNnZkOg7hooTZzJeA
QC/hm8ZMPslYcCXVHuYeKu9s/bNMkyPh1X8JpINazqsolWohHrpGOE1BIX8MF5aI
NO9rtWyt76pipDijJBC2qkMDNTjFAxr0LLqtGCGyQal8wnqb4ymjyKcLSVtjttg0
JxmaHdhzjeZa/aHrywWNhsB0L15mpMFzmWbgNqn78FBtOJoqEdcseYfeVR0BTY22
19d4YCJVts7RQQFnadUNAzVMHTbSXLtJFwd9OGfhns9gXOmAKKdAkkSdsKmSb5HT
9fuPL+iYenQoLuEDGBkim0/EM0IoWg==
=qFIl
-----END PGP SIGNATURE-----

--ijvkimhd7ly3x2id--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
