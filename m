From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] spi fixes for v4.9
Date: Mon, 31 Oct 2016 11:55:13 -0600
Message-ID: <20161031175513.g7pgdaidlmwhgshb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mml77k3zcwztxbxi"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--mml77k3zcwztxbxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.9-rc3

for you to fetch changes up to 2fbef66e1407d1b13d181f7f5614a5897b452188:

  Merge remote-tracking branches 'spi/fix/dt', 'spi/fix/fsl-dspi' and 'spi/fix/fsl-espi' into spi-linus (2016-10-29 12:51:55 -0600)

----------------------------------------------------------------
spi: Fixes for v4.9

A few small fixes for SPI, one core fix that only applies in cases where
we're handling DT overlays and a couple of driver specific fixes:

 - Fix handling of error cases when instantiating DT overlays so we
   don't end up just ignoring devices that encountered an error during
   instantiation.
 - Avoid reading uninitialized data when handing spurious interrupts
   in the espi driver.
 - A driver specific fix for the dspi driver to fix a bad interaction
   with u-boot.

----------------------------------------------------------------
Arnd Bergmann (1):
      spi: fsl-espi: avoid processing uninitalized data on error

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/dt', 'spi/fix/fsl-dspi' and 'spi/fix/fsl-espi' into spi-linus

Ralf Ramsauer (1):
      spi: mark device nodes only in case of successful instantiation

Yuan Yao (1):
      spi: dspi: clear SPI_SR before enable interrupt

 drivers/spi/spi-fsl-dspi.c | 7 +++++++
 drivers/spi/spi-fsl-espi.c | 2 +-
 drivers/spi/spi.c          | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

--mml77k3zcwztxbxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYF4WAAAoJECTWi3JdVIfQpdcH/2VVDR3NC7iWtI7aL767JlHT
JX/bvcX3/w+Fig5iToRjnn0ho5dYDYdv3Vvtx+6SdLjJ9jnJlJW/UJydJ5ycub4J
ZIIp0s/MaJC0kWn1tAQtp9XrOXZS1fnorvakg8Z61l+OgFmBoq+e2E22GjvmVh4+
ufelUMKfG7nWkHPv6PoqTKdoz0mviscZTgW2Xnr+T/gTp4I5fq19GjjgDwBOXt8d
icsIS3MPReC/LKNu8WfRtpFABvvloZf0/GgDWxA5wvgwPDlUwXATYgZR+ZNOf3U+
uGQr3IvS8I9Aw2hcVVeUKKbXZ2syJ+iKf8mqfM2QLxINCxsL9EHoOYANMFfhwIU=
=g+ii
-----END PGP SIGNATURE-----

--mml77k3zcwztxbxi--
