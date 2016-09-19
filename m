From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: bcm-qspi: fix build error
Date: Mon, 19 Sep 2016 10:20:44 +0100
Message-ID: <20160919092044.GG10189@sirena.org.uk>
References: <1474223614-18406-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        arnd@arndb.de
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474223614-18406-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2016 at 07:33:34PM +0100, Sudip Mukherjee wrote:
> While building m68k allmodconfig, the build was failing with the error:
>=20
> drivers/spi/spi-bcm-qspi.c:1300:13:
> error: 'bcm_qspi_suspend' undeclared here (not in a function)
>   .suspend =3D bcm_qspi_suspend,
>=20
> drivers/spi/spi-bcm-qspi.c:1301:13:
> error: 'bcm_qspi_resume' undeclared here (not in a function)
>   .resume  =3D bcm_qspi_resume,

This doesn't apply against current code, please check and resend if it's
not because it's already fixed.

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX363rAAoJECTWi3JdVIfQmXoH/ihaTM6wkYYL34rLGByOZODz
3u8oG857UUwqLNkbmDw8VFXQQJPyUc+J8umXOLcTgFAEUU9LPkN+TVoDjnL3g4Jb
19+/nQaK5jAYQZAwcEFOFlbr42K2BPsj7I6MM2OHVE7W4qwY4t5Wa5mb3HGWUQEc
cqEKt3hMTil6KUzagD7Cyi6Hzw7nmfmXMtE0e7GmXHWZpFuORHSx2xg4e9qJ4ZYj
FsbVTfqrvjry8Nfxfw2rl8zn0CZI0Rvi7wNsiWIz3yFdfXD25eCG8q8GZZSrQCW3
zxrqBFaWfTfG9Mbqu6R4Xyj5R9Y7xwCJyHZHFKdp/hVpFA8MjncxhH1SwWFUyhM=
=d8rM
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
