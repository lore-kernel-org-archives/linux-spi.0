From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI fixes for v3.18
Date: Fri, 7 Nov 2014 10:48:17 +0000
Message-ID: <20141107104817.GH8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1IOMu5+WhZnpLp54"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1IOMu5+WhZnpLp54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.18-rc3

for you to fetch changes up to 4e72b4278dbc228e4dc453d4dfeca997e521d9af:

  Merge remote-tracking branches 'spi/fix/fsl-dspi' and 'spi/fix/pxa2xx' into spi-linus (2014-11-06 12:58:46 +0000)

----------------------------------------------------------------
spi: Bug fixes for v3.18

A couple of small driver fixes for v3.18, both quite problematic if you
hit a use case that's affected.

----------------------------------------------------------------
Alexander Stein (1):
      spi: fsl-dspi: Fix CTAR selection

Dmitry Eremin-Solenikov (1):
      spi: pxa2xx: toggle clocks on suspend if not disabled by runtime PM

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/fsl-dspi' and 'spi/fix/pxa2xx' into spi-linus

 drivers/spi/spi-fsl-dspi.c | 4 ++--
 drivers/spi/spi-pxa2xx.c   | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

--1IOMu5+WhZnpLp54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXKNwAAoJECTWi3JdVIfQrBoH/i4D82DBWJKQC83bNbng3Qb+
26W0Pk3ZnWs5mWR6Rlgx4fl/P843D8ogsMDp0rRXWzKg46qM6845MG1tYNyuFqOH
2FMPMJQqcGllM8Hfjv0Nc4A5oDboZonCJZS6wtg6DrgH/LdHJK45ngzRwzaqMPU4
2hBUaEJUx/cPeKrZz0mO6ylNpJaZ//ryxH43c314/IHP2AfMCG2BUh31YxMENbeY
VkAwxa3bOWVNwQQfifCehGZ4jaT6E1xVOu8mz3Js8U8fkTtg6sJ0AXMGvDRdDGoS
sB0V72htq5QRGumVrtWXyG0syHULHFXOfuM0GDfkBwx2vcK6k1AlCYt+3xgXWX4=
=b8Un
-----END PGP SIGNATURE-----

--1IOMu5+WhZnpLp54--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
