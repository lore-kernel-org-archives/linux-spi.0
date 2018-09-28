From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] spi fixes for v4.19
Date: Fri, 28 Sep 2018 15:30:41 +0100
Message-ID: <20180928143041.GQ20825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xYEXny2b0/vlBQCR"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xYEXny2b0/vlBQCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5223c9c1cbfc0cd4d0a1b50758e0949af3290fa1:

  spi: spi-fsl-dspi: fix broken DSPI_EOQ_MODE (2018-08-28 20:55:23 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.19-rc5

for you to fetch changes up to c949a8e8b43f2c75567269bcc9a50d704ae3c420:

  spi: spi-mem: Move the DMA-able constraint doc to the kerneldoc header (2018-09-20 12:23:31 -0700)

----------------------------------------------------------------
spi: Fixes for v4.19

Quite a few fixes for the Renesas drivers in here, plus a fix for the
Tegra driver and some documentation fixes for the recently added spi-mem
code.  The Tegra fix is relatively large but fairly straightforward and
mechanical, it runs on probe so it's been reasonably well covered in
-next testing.

----------------------------------------------------------------

There's also a small fix for error checking in the bitbanging GPIO
driver I forgot to mention above.

Boris Brezillon (2):
      spi: spi-mem: Add missing description for data.nbytes field
      spi: spi-mem: Move the DMA-able constraint doc to the kerneldoc header

Gaku Inami (1):
      spi: sh-msiof: Fix invalid SPI use during system suspend

Geert Uytterhoeven (2):
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Fix interrupted DMA transfers

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Linus Walleij (1):
      spi: gpio: Fix copy-and-paste error

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

 drivers/spi/spi-gpio.c          |  4 ++--
 drivers/spi/spi-rspi.c          | 34 ++++++++++++++++++++++++++++++----
 drivers/spi/spi-sh-msiof.c      | 28 +++++++++++++++++++++++++++-
 drivers/spi/spi-tegra20-slink.c | 31 +++++++++++++++++++++++--------
 include/linux/spi/spi-mem.h     |  7 ++++---
 5 files changed, 86 insertions(+), 18 deletions(-)

--xYEXny2b0/vlBQCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluuOxEACgkQJNaLcl1U
h9B7aggAgQW3GoHvmPvS9TM5XOANT/6KBbq5XAadZdUQMry0SNJx4FKtzsLFTf7G
xeMXPAC5RgYwoNrVtLkJatWATXzt5Gc7tshwlZDiARIEWFHtsL99C3PyyRhlxw5m
jVHJkyXxPXZbHRc5Ou2E0PouSB7W/ej5/53XWo92HsdaW1ld/Ll/ZYXaf9W8oT6M
Zby2XpQRFsUrlF2l4aGw2zT576rpKlueSCN17aQfzt0+mJleroP7qWy0TxIaj6/j
lCIxFxrBJcCxkJsVSD61wvFThQoOnfegXd5haeYxhb4WnTips+WMZQ3ewUCVGMbF
wGX50uh7eWi++f57H3/VprB1RrY/7Q==
=aExT
-----END PGP SIGNATURE-----

--xYEXny2b0/vlBQCR--
