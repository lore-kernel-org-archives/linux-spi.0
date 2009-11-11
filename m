From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/3] mpc52xx_spi: add missing mode_bits definition
Date: Wed, 11 Nov 2009 11:38:53 +0100
Message-ID: <20091111103853.GB4234@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de> <1257844329-20687-2-git-send-email-l.fu@pengutronix.de> <1257844329-20687-3-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
To: Luotao Fu <l.fu@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757182AbZKKKjE@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1257844329-20687-3-git-send-email-l.fu@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2009 at 10:12:08AM +0100, Luotao Fu wrote:
> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>

SPI_CS_HIGH should be dropped, otherwise:

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  drivers/spi/mpc52xx_spi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
> index 5b036f2..79ba678 100644
> --- a/drivers/spi/mpc52xx_spi.c
> +++ b/drivers/spi/mpc52xx_spi.c
> @@ -430,6 +430,8 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  	master->num_chipselect =3D 1;
>  	master->setup =3D mpc52xx_spi_setup;
>  	master->transfer =3D mpc52xx_spi_transfer;
> +	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> +
>  	dev_set_drvdata(&op->dev, master);
> =20
>  	ms =3D spi_master_get_devdata(master);
> --=20
> 1.6.5.2
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr6lD0ACgkQD27XaX1/VRts5gCeMIoCcdxQ1HfutQ0PsKq60GR5
+mEAnjM2LXjIpDuZJ43GElcC4l9SFHmk
=2J75
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
