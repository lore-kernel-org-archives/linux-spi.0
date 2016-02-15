From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.5
Date: Mon, 15 Feb 2016 12:26:21 +0000
Message-ID: <20160215122621.GI18988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.5-rc4

for you to fetch changes up to 4dd638f8ac6b4ed020297b5d994d9346b84f2009:

  Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/bcm2835aux', 'spi/fix/fsl-espi', 'spi/fix/imx', 'spi/fix/loopback' and 'spi/fix/omap2-mcspi' into spi-linus (2016-02-12 23:04:41 +0000)

----------------------------------------------------------------
spi: Fixes for v4.5

A small clutch of driver specific fixes.  The OMAP one is a bit worrying
since it seems to be triggered by some changes in the runtime PM core
code and I suspect there's other drivers across that are going to be
using the same pattern outside of OMAP but nothing seems to be coming up
in the testing people are doing.

----------------------------------------------------------------
Arnd Bergmann (1):
      spi: fix counting in spi-loopback-test code

Cyrille Pitchen (1):
      spi: atmel: fix gpio chip-select in case of non-DT platform

Gao Pan (1):
      spi: imx: fix spi resource leak with dma transfer

Hou Zhiqiang (1):
      spi/fsl-espi: Correct the maximum transaction length

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/bcm2835aux', 'spi/fix/fsl-espi', 'spi/fix/imx', 'spi/fix/loopback' and 'spi/fix/omap2-mcspi' into spi-linus

Stephan Olbrich (1):
      spi: bcm2835aux: fix bitmask defines

Tony Lindgren (1):
      spi: omap2-mcspi: Fix PM regression with deferred probe for pm_runtime_reinit

 drivers/spi/spi-atmel.c         | 1 +
 drivers/spi/spi-bcm2835aux.c    | 4 ++--
 drivers/spi/spi-fsl-espi.c      | 4 ++--
 drivers/spi/spi-imx.c           | 8 +++++---
 drivers/spi/spi-loopback-test.c | 1 +
 drivers/spi/spi-omap2-mcspi.c   | 3 +++
 6 files changed, 14 insertions(+), 7 deletions(-)

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwcPsAAoJECTWi3JdVIfQy68IAIblEn/4bbhQohmZ1xhu4GYH
RRmVHImqjcRtZje7NCPAXkwav+TLvPzRKd3NpWTV4/ff9c/AJVudBETo//m173fn
MnOM4iMD9b20s+aZ8RJcRf3u7Vy0PfeqFisytfu51E6IL6jZvN2xKL7e+bD1ztH1
T8GCUmDE3VAKYvILG3WrnsqkhnJXz4n4u78KvjZ3Tf1CCEeG3qPBUbARg06ZQoLx
mWpRPDK9nhtCuqym7X4Btt62s0tukHyuYeUyhMDU2OhbXQGfeV3xlkhM0p0DXWYH
C9iVLBNB79o4qJ1TkXtt7sNToaHYEiQRmrArTCuovdgmcMOaYsI4QsqkFFpwdnY=
=Ao7z
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
