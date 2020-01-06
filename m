From: Mark Brown <broonie@kerenl.org>
Subject: [GIT PULL] spi fixes for v5.5
Date: Mon, 6 Jan 2020 13:12:32 +0000
Message-ID: <20200106131232.GC6448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 63aa6a692595d47a0785297b481072086b9272d2:

  spi: fsl: use platform_get_irq() instead of of_irq_to_resource() (2019-12-16 11:54:55 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.5-rc5

for you to fetch changes up to 09b6636cea4f8e419d7cca4155e8695e462535a6:

  spi: Document Octal mode as valid SPI bus width (2020-01-03 01:02:11 +0000)

----------------------------------------------------------------
spi: Fixes for v5.5

A small collection of fixes here, one to make the newly added PTP
timestamping code more accurate, a few driver fixes and a fix for the
core DT binding to document the fact that we support eight wire buses.

----------------------------------------------------------------
Kunihiko Hayashi (1):
      spi: uniphier: Fix FIFO threshold

Vignesh Raghavendra (1):
      spi: Document Octal mode as valid SPI bus width

Vladimir Oltean (2):
      spi: Don't look at TX buffer for PTP system timestamping
      spi: spi-fsl-dspi: Fix 16-bit word order in 32-bit XSPI mode

wuxu.wu (1):
      spi: spi-dw: Add lock protect dw_spi rx/tx to prevent concurrent calls

 .../devicetree/bindings/spi/spi-controller.yaml    |  4 +--
 drivers/spi/spi-dw.c                               | 15 ++++++++---
 drivers/spi/spi-dw.h                               |  1 +
 drivers/spi/spi-fsl-dspi.c                         | 24 +++++++----------
 drivers/spi/spi-uniphier.c                         | 31 +++++++++++++---------
 drivers/spi/spi.c                                  | 22 ++++++---------
 include/linux/spi/spi.h                            |  4 +--
 7 files changed, 54 insertions(+), 47 deletions(-)

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4TMkAACgkQJNaLcl1U
h9Avjgf9GlqKPfiuEc9tJ7BwdeCWC5muNQl/ME0FOwxBZr1pmup24A5ZiL+/6r+G
dpdWZbGeiM90jsbcGqSDVjsg+v8brmKM0G6WJH8YQiZEBFzbrZ5kOqC8xYXoKaOi
LX9yvAQKrIfl+eKltGZ4Mspnu+fUfF4Xa5ZiK5nXkbfZPN/B0zaPH8NvnjoQnwro
oQnsKixrp3Q1A9MHZi4HgUrBha1wHZwjpS3Z9u2QmKRGXjuyxJHPSb57VoYXtb42
hDVd/5BWreHe4z2LeIQVsvQPXx4fgmZCi25nEOdfYDzkBT30zJA15c1GtmkW6j5J
9fSTGiOc2oRuLFG+itKtwSkx/stKcg==
=OS15
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
