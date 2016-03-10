From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v4.5
Date: Thu, 10 Mar 2016 11:14:59 +0700
Message-ID: <20160310041459.GK3898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f6cede5b49e822ebc41a099fe41ab4989f64e2cb:

  Linux 4.5-rc7 (2016-03-06 14:48:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v4.5-rc7

for you to fetch changes up to 3ee20abb063acc57a45ccb2fdab2eb3ce29e85fa:

  Merge remote-tracking branch 'spi/fix/rockchip' into spi-linus (2016-03-10 10:42:24 +0700)

----------------------------------------------------------------
spi: Fixes for v4.5

A few driver specific fixes for the Rockchip and i.MX SPI controllers,
especially for the i.MX they're annoying bugs if you run into them.

----------------------------------------------------------------
Anton Bondarenko (1):
      spi: imx: allow only WML aligned transfers to use DMA

Gao Pan (1):
      spi: imx: fix spi resource leak with dma transfer

Mark Brown (2):
      Merge remote-tracking branch 'spi/fix/imx' into spi-linus
      Merge remote-tracking branch 'spi/fix/rockchip' into spi-linus

Shawn Lin (2):
      spi: rockchip: disable runtime pm when in err case
      spi: rockchip: add missing spi_master_put

 drivers/spi/spi-imx.c      | 17 ++---------------
 drivers/spi/spi-rockchip.c |  3 +++
 2 files changed, 5 insertions(+), 15 deletions(-)

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4PTAAAoJECTWi3JdVIfQqFwH/3lm84jwFrgW5slCKT9xh6op
u3+G9geCXnHS5SIYkDPVGlH/3BVHyZYTdcKi4Qs9oJtCIBpPyse6HuifSAVaKb9K
0P2r6phjJKDmnPoz8wx2T3WZwOUaOu3Xfb6CgsUj2MMB0s5h4vQ2pF4OUiGan6Re
UA7kptsTp8GBiBLhp6gDbLwmMhVPaUN9xhvgTllDMqGz4an+qCBwFHyL5M3wJkic
dQaJq3s1I6Tpc4lCgwMxhTJfdlx+Jd7W2NKYtOGi77EAx+9EY2eVG7mNhSVcgpMH
v9Exg6nZp37mFi08THf/0BgSR04kkFvxi2qwIZaUULvH98y6UFTNpL1ZwSkYcn8=
=oaht
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
