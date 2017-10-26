From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] spi fixes for v4.14
Date: Thu, 26 Oct 2017 11:54:19 +0200
Message-ID: <20171026095419.2hs5qjhsrpmns3by@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h5crlpcha5mistqv"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--h5crlpcha5mistqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:

  Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.14-rc5

for you to fetch changes up to 7555aa766b63f00fea8280883eb7db6834204605:

  Merge remote-tracking branches 'spi/fix/armada', 'spi/fix/idr', 'spi/fix/qspi', 'spi/fix/stm32' and 'spi/fix/uapi' into spi-linus (2017-10-25 14:06:34 +0200)

----------------------------------------------------------------
spi: Fixes for v4.14

There are a bunch of device specific fixes (more than I'd like, I've
been lax sending these) plus one important core fix for the conversion
to use an IDR for bus number allocation which avoids issues with
collisions when some but not all of the buses in the system have a fixed
bus number specified.

The Armada changes are rather large, specificially "spi: armada-3700:
Fix padding when sending not 4-byte aligned data", but it's a storage
corruption issue and there's things like indentation changes which make
it look bigger than it really is.  It's been cooking in -next for quite
a while now and is part of the reason for the delay.

----------------------------------------------------------------
Baruch Siach (1):
      spi: uapi: spidev: add missing ioctl header

Christos Gkekas (1):
      spi: stm32: Fix logical error in stm32_spi_prepare_mbr()

Florian Fainelli (1):
      spi: bcm-qspi: Fix use after free in bcm_qspi_probe() in error path

Lucas Stach (1):
      spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/armada', 'spi/fix/idr', 'spi/fix/qspi', 'spi/fix/stm32' and 'spi/fix/uapi' into spi-linus

Maxime Chevallier (1):
      spi: a3700: Return correct value on timeout detection

Miquel Raynal (1):
      spi: armada-3700: Fix failing commands with quad-SPI

Zachary Zhang (1):
      spi: armada-3700: Fix padding when sending not 4-byte aligned data

 drivers/spi/spi-armada-3700.c   | 145 +++++++++++++---------------------------
 drivers/spi/spi-bcm-qspi.c      |   9 +--
 drivers/spi/spi-stm32.c         |   4 +-
 drivers/spi/spi.c               |  13 ++--
 include/uapi/linux/spi/spidev.h |   1 +
 5 files changed, 65 insertions(+), 107 deletions(-)

--h5crlpcha5mistqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnxsMsACgkQJNaLcl1U
h9Bp7Qf/aZKFyTSUaV7RVmCJQP36yVDxfhkfZJjbl4nWHvp6rUBGK/tGsERdeSdj
J8vht5TKe/hVOh6nWuy/gd2mQ3yx97xlzQ+0k6czD49tTkVYdvyk+HKJkmcQrgCE
+WMJWthlCQbzy6xh5FCGcr/Jv6AIPZ2hlY9x8Yvl4NmaKJOrpipSGBp2qrgnK212
mpkFjF7N70UxrA/qGqB58l5qqVuOjk18tccsczi30eF+klNt//zo9zm1we+Bfu60
mKeZdARtJpOMR6LgQk66GA/FUzphrcmRaMLE6QsB4UYTH2jgqZFr8SxjINuU7Cmz
y7+bV0AKbm4BI1scpaY4NS+UnJTr8w==
=y1x6
-----END PGP SIGNATURE-----

--h5crlpcha5mistqv--
