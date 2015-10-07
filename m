From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.3
Date: Wed, 7 Oct 2015 11:56:38 +0100
Message-ID: <20151007105638.GH12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3hIvOD7G0d3u+a8M"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3hIvOD7G0d3u+a8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.3-rc4

for you to fetch changes up to c2c80bdb9e91b412ea68f6dcc49c5d7b91e0b930:

  Merge remote-tracking branches 'spi/fix/davinci' and 'spi/fix/sh-msiof' into spi-linus (2015-10-07 11:43:39 +0100)

----------------------------------------------------------------
spi: Fixes for v4.3

A couple of very minor fixes, one for error handling in the Davinci
driver probe function and another making the Renesas sh-msiof DT binding
documentation correspond to what's actually implemented.

----------------------------------------------------------------
Andrzej Hajda (1):
      spi: davinci: fix handling platform_get_irq result

Geert Uytterhoeven (1):
      spi: sh-msiof: Match renesas,rx-fifo-size in DT bindings doc with driver

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/davinci' and 'spi/fix/sh-msiof' into spi-linus

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 2 +-
 drivers/spi/spi-davinci.c                          | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

--3hIvOD7G0d3u+a8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFPplAAoJECTWi3JdVIfQnkEH/j2DAccJibiUclgxC//2Jp7b
giQWE9MFZLysLjjIZLkWQl7H/okt0Fb7Kf4jgvI8ahwxGqF6IVFmT5xFDdp65Ie1
MUaI8dL3fNZvG8n4j7iKhqK8qfVyRR92OVKSzMX0zm8S5pchmroO6mm9o8tdKCHZ
nCAGShRtMjM6VeRL6LycsG6UclgJs1T+uXSmG6/rHmq82pb4Jv/vVCqsDrtwp7V9
H0R9ELCUNlM+NeJfXM70pvG0NorTMGNkGWlnt3RBsznrH+EmCYNsLDuvjPHjifBS
ILAqj6BvI7SwHaCE8ahFrxk6sltnY3DGsVxZeLCmQXIbBW/ZAqohOLAciCntH8U=
=INLd
-----END PGP SIGNATURE-----

--3hIvOD7G0d3u+a8M--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
