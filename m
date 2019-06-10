From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] spi fixes for v5.2
Date: Mon, 10 Jun 2019 15:26:48 +0100
Message-ID: <20190610142648.GB5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d61ad23cb3be09ff4956e9b9794134456522817f:

  spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO chip-select (2019-05-02 10:38:00 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.2-rc4

for you to fetch changes up to f3440d9a0da292dc4998d9393162fcfb996fd671:

  spi: abort spi_sync if failed to prepare_transfer_hardware (2019-05-23 14:36:13 +0100)

----------------------------------------------------------------
spi: Fixes for v5.2

A small set of fixes here, one core fix for error handling when we fail
to set up the hardware before initiating a transfer and another one
reverting a change in the core which broke Raspberry Pi in common use
cases as part of some optimization work.  There's also a couple of
driver specific fixes.

----------------------------------------------------------------
Christophe Leroy (1):
      spi: spi-fsl-spi: call spi_finalize_current_message() at the end

Mark Brown (1):
      spi: Fix Raspberry Pi breakage

Super Liu (1):
      spi: abort spi_sync if failed to prepare_transfer_hardware

YueHaibing (1):
      spi: bitbang: Fix NULL pointer dereference in spi_unregister_master

 drivers/spi/spi-bitbang.c |  2 +-
 drivers/spi/spi-fsl-spi.c |  2 +-
 drivers/spi/spi.c         | 11 ++++++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz+aKcACgkQJNaLcl1U
h9CIFAf/ROOT3trWHzotcI7wHH8gQPZdZ9Ojm2mjxC6XGbhafTvd+XgLv9dDiT88
B70DVcuR7VUBtJSDSirKXeOuDQ+vG9/xKtRQMLjIojmkJ2+yO6MzmZLCX3xRZZ9K
xIgj8U+A5Mbed48XvwD9kHRd57SpUvjaUwp4GBypxHVp6cqJnFDoEcLkN15MNgOQ
6t2hReLFATJdEPMVRfADLkr6ksVc25pIfmXgpeedT7NXiErkDNez5AtVY0gukLqK
YM4TSwidRhp8gnXD6wZtBZtniiI881zw25YbCGpIyNJBfL2PykskDGDARB4Gl1t7
uaEtGcGKR23bSzjQQ2+s9cDmwpADZA==
=XCGZ
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
