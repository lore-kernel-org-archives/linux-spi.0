From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] spi fixes for v4.17
Date: Fri, 18 May 2018 11:01:07 +0100
Message-ID: <20180518100107.GE24209@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e241e3f2bf975788a1b70dff2eb5180ca395b28e:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2018-04-11 18:58:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git spi-fix-v4.17-rc5

for you to fetch changes up to bc519d9574618e47a0c788000fb78da95e18d953:

  spi: bcm2835aux: ensure interrupts are enabled for shared handler (2018-05-04 08:09:02 +0900)

----------------------------------------------------------------
spi: Fixes for v4.17

A small collection of fixes accumilated since the merge window, all
fairly small and driver specific.

----------------------------------------------------------------
Andy Shevchenko (1):
      spi: pxa2xx: Allow 64-bit DMA

Kamal Dasu (2):
      spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
      spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL

Rob Herring (1):
      spi: bcm2835aux: ensure interrupts are enabled for shared handler

Vladimir Zapolskiy (1):
      spi: sh-msiof: Fix bit field overflow writes to TSCR/RSCR

sxauwsk (1):
      spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()

wangbo (1):
      spi: imx: Update MODULE_DESCRIPTION to "SPI Controller driver"

 drivers/spi/spi-bcm-qspi.c   | 28 ++++++++++++++++++----------
 drivers/spi/spi-bcm2835aux.c |  5 +++++
 drivers/spi/spi-cadence.c    |  8 ++++++++
 drivers/spi/spi-imx.c        |  2 +-
 drivers/spi/spi-pxa2xx.h     |  2 +-
 drivers/spi/spi-sh-msiof.c   |  1 +
 6 files changed, 34 insertions(+), 12 deletions(-)

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr+pGIACgkQJNaLcl1U
h9Bx3QgAgN/z4QCLB6XTufdU7rbmowc/oZA6SZL5XrZ9hODiuhW5ttdpbq9GmuwM
7S97ixGgs/zeq2zVYD+xYSQYjzaZaV4R6Kkzx3HWyuRXHpmrJkG7NxbwMFUMEUHI
x4Jy+WI4HLyiTvhjA0i7VM6o2grXzO5PFqhS6tHLG8CyExtHDycBJOFpwJgoHQEa
PkweuTjY++6kKk1OWGy3LyaZGEhoqB8g0qDrhL/VnDTxX2l+MHj6qqyriEEwwVxQ
x58OxP2kHFESLQEh71L3TpORzvrSA9SaTpyKAoISpPrKPE5uVemLZJCkuTkUB9wQ
KWBUBjb2rHdVFcHZdGFD0bUz2koS4Q==
=+tcx
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
