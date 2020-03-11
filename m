From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Date: Wed, 11 Mar 2020 19:57:50 +0000
Message-ID: <20200311195750.GL5411@sirena.org.uk>
References: <20200306085052.28258-1-gch981213@gmail.com>
 <20200309121020.GD4101@sirena.org.uk>
 <2471214.x7VzW1FXlQ@localhost.localdomain>
 <4427171.IzkiAjLLdB@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        vigneshr-l0cyMroinI0@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org,
        matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4427171.IzkiAjLLdB-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 09:11:29AM +0000, Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org wrote:

> You can also create an immutable tag that I can merge in my spi-nor/next=
=20
> branch, so that Linus doesn't have to deal with the conflict.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/mtk-=
mtd-spi-move

for you to fetch changes up to e11e8473bcec748c3820636f11b986f611c9309b:

  mtd: spi-nor: remove mtk-quadspi driver (2020-03-11 19:56:08 +0000)

----------------------------------------------------------------
spi: Rewrite mtk-quadspi spi-nor driver with spi-mem

This patchset from Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> adds a spi-mem
driver for Mediatek SPI-NOR controller, which already has limited
support by mtk-quadspi. This new driver can make use of full quadspi
capability of this controller.

----------------------------------------------------------------
Chuanhong Guo (4):
      spi: make spi-max-frequency optional
      spi: add support for mediatek spi-nor controller
      dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
      mtd: spi-nor: remove mtk-quadspi driver

 .../{mtd/mtk-quadspi.txt =3D> spi/spi-mtk-nor.txt}   |  15 +-
 drivers/mtd/spi-nor/Kconfig                        |   8 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/mtd/spi-nor/mtk-quadspi.c                  | 565 -----------------
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mtk-nor.c                          | 689 +++++++++++++++++=
++++
 drivers/spi/spi.c                                  |   9 +-
 8 files changed, 708 insertions(+), 590 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt =3D> spi/spi=
-mtk-nor.txt} (75%)
 delete mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c
 create mode 100644 drivers/spi/spi-mtk-nor.c

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5pQr0ACgkQJNaLcl1U
h9BuJgf+J4BVeDZ89cXm1ecHsmkFxwEbC3B2+ALUZTKsTZ4n5rM4aliKanEGJ5XX
llfEUpxE7QAnZE9vv8yoKCfE8njVTTmyYi2TBJKg0hrcXb1Q3pvbsQJTO8uXm57g
iajxxjrO0mdISzR0gErKYgJjdDyIUThSR89v5b7YXpWP4dHf7JSA4qwIWFhOLCZd
fX3G8RIjqXkSJx2yKPjK7+xkA7u7GvP7U9kt1Nynt1NOlRtGyUywUZblL5MhZ2MG
Bjln0lpBnhN285Mvntm49LmpoEnPdeHzbozsMVZHmD0+sdpGZ8PIQSiILb/mGCJf
jpg/Q++KbM01LDw26eSGVIsnqAFBdA==
=Neg9
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
