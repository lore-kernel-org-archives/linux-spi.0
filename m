From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] spi: lpspi: add dma mode support
Date: Mon, 7 Jan 2019 15:22:07 +0000
Message-ID: <20190107152207.GG9570@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-9-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-9-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:47:49AM +0000, Clark Wang wrote:

A couple of small nits but otherwise this looks good:

> +	bytes_per_word =3D fsl_lpspi_bytes_per_word(transfer->bits_per_word);
> +	if (bytes_per_word !=3D 1 && bytes_per_word !=3D 2 && bytes_per_word !=
=3D 4)
> +		return false;

This would be clearer written as a switch statement.

> @@ -301,12 +352,59 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_d=
ata *fsl_lpspi)
>  	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
>  					fsl_lpspi->base + IMX7ULP_CCR);
> =20
> -	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldi=
v=3D%d\n",
> +	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale=3D%d, scldiv=
=3D%d\n",
>  		perclk_rate, config.speed_hz, prescale, scldiv);
> =20
>  	return 0;
>  }
> =20

This looks like an unrelated typo fix, should be a separate patch.

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzbp4ACgkQJNaLcl1U
h9Ajsgf/Yha2C12GozXXbtV+VEOkPRDxY5PnRhuK4O6TJPJ5J1RCKg0OnAPHghyi
pgE8rq3k1wvFu571RkgEAEtqJILViIEXTDDW++UVh1k5ePRx9/61sJEDvmfqLa2V
l4m6tziQVLz94sebXS1De+z7Q2XbxAGj/9KoYeI6eOHEB4UCLbLh/xq5OVL+T0uL
vwL8vlXOFhQF14exiEM7Xs0YfljJaLW5sLHEU6lU4hltFA94/KtwbSULpOXzA81t
I9/frO8i+GYulmgv/29dUGXJMyA3NpSi6lsj+BJ/zPgb0/juf31LjGHIUZCtZRzy
UBz2r8JgovhZRMbL84YGO5mGvYl2tw==
=Dlhv
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
