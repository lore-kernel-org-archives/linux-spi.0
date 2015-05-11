From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v4.1
Date: Mon, 11 May 2015 19:18:20 +0100
Message-ID: <20150511181820.GV3458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hFEw+uh9kF5V6COn"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hFEw+uh9kF5V6COn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.1-rc3

for you to fetch changes up to c8b350424d1862619c311204290cd42bae4ebaa3:

  Merge remote-tracking branches 'spi/fix/fsl-cpm', 'spi/fix/fsl-dspi' and 'spi/fix/fsl-espi' into spi-linus (2015-05-11 17:29:49 +0100)

----------------------------------------------------------------
spi: Fixes for v4.1

A number of driver specific fixes (including several missing
dependencies for randconfig type cases) plus two core fixes.  One makes
the setup_transfer() callback optional which unbreaks some drivers which
had been merged with it omitted due to local versions of this patch and
another ensures that we don't corrupt data by leaking internal dummy
buffers to callers, causing the callers to think they allocated those
buffers.

----------------------------------------------------------------
Christophe Leroy (2):
      spi: fsl-spi: use devm_ioremap_resource() to map parameter ram on CPM1
      spi: fsl-spi: fix devm_ioremap_resource() error case

Fionn Cleary (1):
      spi/omap2-mcpsi: Always call spi_finalize_current_message()

Guenter Roeck (1):
      spi: bcm2835: Add GPIOLIB dependency

Haikun Wang (1):
      spi: Kconfig: Add SOC_LS1021A to SPI_FSL_DSPI dependence

Jonatas Rech (1):
      spi: fsl-espi: fix behaviour for full-duplex xfers

Mark Brown (4):
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branches 'spi/fix/bcm2835', 'spi/fix/bcm2835-code', 'spi/fix/bitbang', 'spi/fix/fsl-cpm' and 'spi/fix/omap2-mcspi' into spi-linus
      Merge tag 'spi-v4.1-rc1' into spi-linus
      Merge remote-tracking branches 'spi/fix/fsl-cpm', 'spi/fix/fsl-dspi' and 'spi/fix/fsl-espi' into spi-linus

Martin Sperl (1):
      spi: bcm2835: change timeout of polling driver to 1s

Pelle Nilsson (1):
      spi: bitbang: Make setup_transfer() callback optional

Robin Gong (1):
      spi: check tx_buf and rx_buf in spi_unmap_msg

 drivers/spi/Kconfig           |  3 ++-
 drivers/spi/spi-bcm2835.c     |  5 ++---
 drivers/spi/spi-bitbang.c     | 17 +++++++++-------
 drivers/spi/spi-fsl-cpm.c     | 40 ++++++++++++++++++++++----------------
 drivers/spi/spi-fsl-espi.c    | 45 +++++++++++++++++++++++++++++--------------
 drivers/spi/spi-omap2-mcspi.c | 16 +++++++++++----
 drivers/spi/spi.c             |  9 +++++++++
 7 files changed, 89 insertions(+), 46 deletions(-)

--hFEw+uh9kF5V6COn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUPJrAAoJECTWi3JdVIfQNGkH+weBFCEzqPgywHa0FLf4cZkk
XfXD0ScZdP3tmig3qHo5HsnK9cT6cYilMr3pdIDZJ2ndEStOdDHhzJjDaJVYUh+t
CwI/38gM+pFBRntwu16eoLpZai3K1FztLD00tuGCAGkbBTPnFMuEZKYDTD1o+vkH
sugihBmogpHUYuNl/g4SrkwRUbLQgYvUgREvOQ3qnsQ/0NuYmEWoKiQDvxCP2Xwl
BsydohaJLt+ZbE2+pxPxQ5dHDTUzJs51HnQQWi0fTUnRZ0nqOXqABHjaU/FZVFyb
2DYnGsjpJfJADf1woHJgh2WI+yRxlZxDewrrm6xJElFDFqoxwJHpGdpIEiu1u3I=
=Pn9i
-----END PGP SIGNATURE-----

--hFEw+uh9kF5V6COn--
