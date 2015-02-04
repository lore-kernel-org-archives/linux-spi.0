From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi fixes for v3.19
Date: Wed, 4 Feb 2015 21:08:30 +0000
Message-ID: <20150204210830.GO21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uYN4FLSULGyR+p/T"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uYN4FLSULGyR+p/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e36f014edff70fc02b3d3d79cead1d58f289332e:

  Linux 3.19-rc7 (2015-02-01 20:07:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.19-rc7

for you to fetch changes up to d426a842b0c203c182ec2658efc4282ef1eb80be:

  Merge remote-tracking branches 'spi/fix/fsl-dspi' and 'spi/fix/imx' into spi-linus (2015-02-04 20:57:31 +0000)

----------------------------------------------------------------
spi: Fixes for v3.19

A couple of driver specific fixes:

 - Disable DMA mode for i.MX6DL chips due to a hardware bug.
 - Don't use devm_kzalloc() outside of bind/unbind paths in the fsl-dspi
   driver, fixing memory leaks.

----------------------------------------------------------------
Bhuvanchandra DV (1):
      spi: spi-fsl-dspi: Remove usage of devm_kzalloc

Mark Brown (1):
      Merge remote-tracking branches 'spi/fix/fsl-dspi' and 'spi/fix/imx' into spi-linus

Robin Gong (1):
      spi: imx: use pio mode for i.mx6dl

 drivers/spi/spi-fsl-dspi.c | 14 ++++++++++++--
 drivers/spi/spi-imx.c      |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

--uYN4FLSULGyR+p/T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0opNAAoJECTWi3JdVIfQQuIH/2sc2iauv5eljwQqdSFjflkJ
cwhl2DYz++doCESddNi7/MF2O4i6bBN/nMLmmae4n10Sm8n46F5pgWpW6VIGgcw0
/BBcPbP+1r+8plV7o57OUqe7S/P/+WZFK9XclqXHjWxKTG+UVjPEIzei/vE8gV+j
0lnaBHHbaq2lqmoaTbC9oX6IhOYeBofYc/seTfDkaLKrNCcuPL+F0RODdCrIJBi9
OVsv3USIZUj3GOw9TR7OcJI9tkXXJQGk2P5//RG38Pe5mgbKnirCFEFhPrsuLSTE
tnQJ83x6PZCJ6w3A8qovOq1X74iyUjmofnNLkzgLrf9qM3R/kl3KYtI8Aysz79Q=
=m6Km
-----END PGP SIGNATURE-----

--uYN4FLSULGyR+p/T--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
