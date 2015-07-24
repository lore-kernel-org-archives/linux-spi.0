From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.2
Date: Fri, 24 Jul 2015 17:54:50 +0100
Message-ID: <20150724165450.GO11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bUZXtnY6La1DoU2p"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bUZXtnY6La1DoU2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 52721d9d3334c1cb1f76219a161084094ec634dc:

  Linux 4.2-rc3 (2015-07-19 14:45:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.2-rc3

for you to fetch changes up to 0c38ec716cdc0397f5225047c33a3144da93f5d8:

  Merge remote-tracking branches 'spi/fix/gqspi', 'spi/fix/imx', 'spi/fix/mg-spfi' and 'spi/fix/spidev' into spi-linus (2015-07-24 16:19:50 +0100)

----------------------------------------------------------------
spi: Fixes for v4.3

A small collection of pretty much unremarkable driver specific fixes
here plus the addition of a new device ID to spidev which requires no
other code changes.

----------------------------------------------------------------
Dan Carpenter (1):
      spi: zynq: missing break statement

Geert Uytterhoeven (1):
      spi: SPI_ZYNQMP_GQSPI should depend on HAS_DMA

Jiri Prchal (1):
      spi: spidev: add compatible value for LTC2488

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/gqspi', 'spi/fix/imx', 'spi/fix/mg-spfi' and 'spi/fix/spidev' into spi-linus

Sascha Hauer (1):
      spi: imx: Fix small DMA transfers

Sifan Naeem (1):
      spi: img-spfi: fix support for speeds up to 1/4th input clock

 drivers/spi/Kconfig            | 2 +-
 drivers/spi/spi-img-spfi.c     | 2 ++
 drivers/spi/spi-imx.c          | 5 +++--
 drivers/spi/spi-zynqmp-gqspi.c | 1 +
 drivers/spi/spidev.c           | 1 +
 5 files changed, 8 insertions(+), 3 deletions(-)

--bUZXtnY6La1DoU2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVsm3aAAoJECTWi3JdVIfQ7uoH/REcg56bRX7iM1sdu6xMu4hw
45PHyqsdj/48XpWk0nHH+JgkM+xGOOrkUeQgLq4+/idLc1uvECxuX8ZCQ+u6XSii
8UvDWF2NUoEGmfJ8QQErISs0TJK8W9p8BRfc0pSIns4A8prDUts542NMZj2wfTzs
Mu3EeGUGd4EPDN/TWP/hFSUdAftmWqlbJv/bDPyzSa76xUtdLRAnA8jl/PKqgfAN
UAdlTvScKDmHeR2McC3n7nTXKoF8B90tYLh5R8OaIX4P/CyB2RfnQO/BdxAV1Zoa
qq78LvGS3BzIxq8IVTcU1oJpTbKerPkyiHFVOJMZC/AUeFiELwCwhM8jXK+XMPw=
=I3ir
-----END PGP SIGNATURE-----

--bUZXtnY6La1DoU2p--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
