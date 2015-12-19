From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.4
Date: Sat, 19 Dec 2015 11:44:25 +0000
Message-ID: <20151219114425.GH5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jLmGyUepE/aZfh+l"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jLmGyUepE/aZfh+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9f9499ae8e6415cefc4fe0a96ad0e27864353c89:

  Linux 4.4-rc5 (2015-12-13 17:42:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.4-rc5

for you to fetch changes up to c1f4a149406ce41962c6ba7d92047563f9e26e0b:

  Merge remote-tracking branches 'spi/fix/dspi' and 'spi/fix/spidev' into spi-linus (2015-12-16 13:28:32 +0000)

----------------------------------------------------------------
spi: Fixes for v4.4

A couple of reference counting bugs here, one in spidev and one with
holding an extra reference in the core that we never freed if we removed
a device, plus a driver specific fix.  Both of the refcounting bugs are
very old but they've only been found by observation so hopefully their
impact has been low.

----------------------------------------------------------------
Bhuvanchandra DV (1):
      spi-fsl-dspi: Fix CTAR Register access

Johan Hovold (1):
      spi: fix parent-device reference leak

Mark Brown (3):
      spi: spidev: Hold spi_lock over all defererences of spi in release()
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branches 'spi/fix/dspi' and 'spi/fix/spidev' into spi-linus

 drivers/spi/spi-fsl-dspi.c | 12 ++++++------
 drivers/spi/spi.c          |  2 +-
 drivers/spi/spidev.c       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--jLmGyUepE/aZfh+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWdUMZAAoJECTWi3JdVIfQIEsH/3cHeVhIYqk1o3QNTO8uepmD
l+7od5SIfKdWLuo3kT9sCr2M3cIWE54RsErSUT6Zw27fmEnEFCzJIxUMwckzqiAa
g/Y780X9Hi9TtaiVWzUKAv61LCqwYq+XmD4V2rUYVpKy/aYtezuDJg7m+DOw/RiO
7zKZNGXqNPP+vzyM291XgjFPw4B8A/nrPj/5bdBa/IM7HqMefT5fxqTwjSZw8HVe
XFgH0V/8CUVZhwQavtwS1xiZpvuRGuy9MoZ6fOnReZtm2jTdfrLlaplQoIn2XK94
r5SEtS2Z12akLD45poSITDLw77AjpLJKJJcXiaTIb2GqSyT2L2SR67OUk9598VE=
=p64Y
-----END PGP SIGNATURE-----

--jLmGyUepE/aZfh+l--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
