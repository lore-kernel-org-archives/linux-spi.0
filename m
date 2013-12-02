From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI updates for v3.13
Date: Mon, 2 Dec 2013 13:36:23 +0000
Message-ID: <20131202133623.GG27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GuLbEtPckrXUekoe"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--GuLbEtPckrXUekoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.13-rc2

for you to fetch changes up to c18158f1fdad0de6be5386291189580484e459cf:

  Merge remote-tracking branches 'spi/fix/bcm2835', 'spi/fix/bcm63xx', 'spi/fix/mpc512x-psc', 'spi/fix/mxs', 'spi/fix/pxa2xx', 'spi/fix/qspi', 'spi/fix/rspi' and 'spi/fix/txx9' into spi-linus (2013-11-28 11:31:35 +0000)

----------------------------------------------------------------

spi: Fixes for v3.13

A smattering of driver specific fixes here, including a bunch for a
long standing common pattern in the error handling paths, and a fix for
an embarrassing thinko in the new devm master registration code.

----------------------------------------------------------------
Chew, Chiau Ee (1):
      spi/pxa2xx: Restore private register bits.

Mark Brown (2):
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branches 'spi/fix/bcm2835', 'spi/fix/bcm63xx', 'spi/fix/mpc512x-psc', 'spi/fix/mxs', 'spi/fix/pxa2xx', 'spi/fix/qspi', 'spi/fix/rspi' and 'spi/fix/txx9' into spi-linus

Mika Westerberg (1):
      spi/pxa2xx: add new ACPI IDs

Sourav Poddar (2):
      spi/qspi: cleanup pm_runtime error check.
      spi/qspi: Fix qspi remove path.

Stephen Warren (1):
      spi: core: invert success test in devm_spi_register_master

Wei Yongjun (7):
      spi: bcm2835: fix reference leak to master in bcm2835_spi_remove()
      spi: rspi: use platform drvdata correctly in rspi_remove()
      spi: mpc512x: fix reference leak to master in mpc512x_psc_spi_do_remove()
      spi: txx9: fix reference leak to master in txx9spi_remove()
      spi: bcm63xx: fix reference leak to master in bcm63xx_spi_remove()
      spi: spi-mxs: fix reference leak to master in mxs_spi_remove()
      spi/qspi: set correct platform drvdata in ti_qspi_probe()

 drivers/spi/spi-bcm2835.c     |  2 +-
 drivers/spi/spi-bcm63xx.c     |  2 +-
 drivers/spi/spi-mpc512x-psc.c |  2 +-
 drivers/spi/spi-mxs.c         |  2 +-
 drivers/spi/spi-pxa2xx.c      |  5 +++++
 drivers/spi/spi-rspi.c        |  3 +--
 drivers/spi/spi-ti-qspi.c     | 23 +++++++++++++++++++----
 drivers/spi/spi-txx9.c        |  2 +-
 drivers/spi/spi.c             |  2 +-
 9 files changed, 31 insertions(+), 12 deletions(-)

--GuLbEtPckrXUekoe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnIzUAAoJELSic+t+oim9PTkP/j8NUO2+LYh5AIb5mPTDFBOe
ZMedJ1XYSvX47KI/ut8U5wox5A2XALdzA1/cfUnYgxZb3Ua1PCeXJNNf3Ry5bFsU
KdfptYa0kZ5/eKRvpiaeBH3GEWsUlhpD8oLySo2YmbNe9dDQpYm3utmxFtiJgzP4
AC5xEO30yK5LEwrEy5pAkLB3DGQMo7IdHaQsBTj89wzkEpy5Fpds8Z3XIRoJIMju
W6rhzN+49rUzk+3RxW3VQuvYrJR3w83DSQc038J3rMlHRU82tCHBCsuFSx+d4ynH
B789y7bOBpxlbHD/VlIW4o8YuTLHipGgsTnBZTdCzNOnu4WaVquoG789R6dN39KW
qrMWQW/czJkim6AjeHaB9bghYNhxAAlUGAkqeN3ZsdhafltXfCz8+iq5cFRWw7zH
vvfxnaDOM7rNfmxRJpfBeWNTds1fCF1qyGjz2ABCSHXAAWS6ZcH7UtDJB83iCdqm
JeNx8fBz7yggbnnzcFJlW/Afugu2qa7s5MDiI7HxTPHGTsd6QVVElTuKgT9fDCZ/
/sLaDZPVxBN9evRGETClpr46MpcVdq5V07EQ0iic+YO5d/dumm9cI5QzkmnmVG3u
0oNNClRRUuFznh0RV9jN/VFmKsvO4zPb0prXBu7gUQJPB0rmVEKDHw8BvlT9p7FQ
eslBi5wPwJiU8Ox+OR0c
=Id4e
-----END PGP SIGNATURE-----

--GuLbEtPckrXUekoe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
