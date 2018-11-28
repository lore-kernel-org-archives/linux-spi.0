From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v4.20
Date: Wed, 28 Nov 2018 15:54:04 +0000
Message-ID: <20181128155404.GJ6828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0FRtVia6Q6lt+M0P"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0FRtVia6Q6lt+M0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0c903aafc8529f64d24d2cd6df32f2bf16aad20b:

  spi: lpspi: add imx8qxp compatible string (2018-10-21 16:55:23 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git spi-fix-v4.20-rc4

for you to fetch changes up to 91b9deefedf4c35a01027ce38bed7299605026a3:

  spi: omap2-mcspi: Add missing suspend and resume calls (2018-11-15 16:20:43 -0800)

----------------------------------------------------------------
spi: Fixes for v4.20

A few driver specific fixes here, nothing big or that stands out for
anyone other than the driver users.

----------------------------------------------------------------

Forgot to note that the mcspi thing is a fix for issues that started
showing up with a change in defconfig in this release to make cpuidle
get turned on by default.

Keiji Hayashibara (1):
      spi: uniphier: fix incorrect property items

Leilk Liu (1):
      spi: mediatek: use correct mata->xfer_len when in fifo transfer

Tony Lindgren (1):
      spi: omap2-mcspi: Add missing suspend and resume calls

 .../devicetree/bindings/spi/spi-uniphier.txt       | 14 ++++----
 drivers/spi/spi-mt65xx.c                           |  4 +--
 drivers/spi/spi-omap2-mcspi.c                      | 37 +++++++++++++++-------
 3 files changed, 35 insertions(+), 20 deletions(-)

--0FRtVia6Q6lt+M0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+uhsACgkQJNaLcl1U
h9CQ2Qf8Ch14TJIWzZKoqdxC0TfLYDzF4DXB0Yyc8XXKk00RGB1LFbjw7qL4M2jL
5w941OlkAdVxz6g2V4ZX5JPwl7vFeCvdXvfVCprs95BGJfrFHJv5X4QdSOqJbTAI
dWft8/QU8xk167iuf2JZdk0nmCLQxnSddktavaTwMoqqRWGRfT/kl+jP45fwYEZN
EBciJtOjTe+0if3VaX0tMnRE7cchhAvv/nS405XHDyuENPIdT/5Rq6JKQQcPiRea
bSlSx+spCGstk7rO24LkatJSSKt95kX1vgX6h5jzFX/i6fmOs9pTyHs3csXZ//jP
BFujcsR6hqJcOnyQLBMcNEDrSoaFxw==
=eYeu
-----END PGP SIGNATURE-----

--0FRtVia6Q6lt+M0P--
