From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/5] spi: sunxi: set maximum and minimum speed of SPI
 master
Date: Mon, 30 May 2016 11:17:23 +0200
Message-ID: <20160530091723.GH4247@lukather>
References: <cover.1464130597.git.hramrach@gmail.com>
 <7292b1fa08de4f453a643beb63e9faa7826726f6.1464130597.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Cc: linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7292b1fa08de4f453a643beb63e9faa7826726f6.1464130597.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 26, 2016 at 07:25:25PM -0000, Michal Suchanek wrote:
> The maximum speed of SPI master is used when maximum speed of SPI slave
> is not specified. Also the __spi_validate function should check that
> transfer speeds do not exceed the master limits.
>=20
> The user manual for A10 and A31 specifies maximum
> speed of the SPI clock as 100MHz and minimum as 3kHz.
>=20
> Setting the SPI clock to out-of-spec values can lock up the SoC.
>=20
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 2 ++
>  drivers/spi/spi-sun6i.c | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index bf52b09..e1a75dd6 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -405,6 +405,8 @@ static int sun4i_spi_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	sspi->master =3D master;
> +	master->max_speed_hz =3D 100*1000*1000;

You need spaces around the * operator.

> +	master->min_speed_hz =3D        3*1000;

And I'm not exactly sure why you have that weird indentation.

The same applies for the sun6i driver

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXTAUjAAoJEBx+YmzsjxAg4GAP/3egWi/MfFwQ+AVhNjivp3vK
iMcKd9/4Ww/uYb2IaPDUxoDMR0gqhQ/vBlrcR/l9zm9oSAhwFz8ZnBZLYQl+3jvk
mTLYbOUSBECX0k0ZXAFvXlVbTC/xpkmlrDLq5UzTFCWUs7bzFGjegVkkh9e8whmo
Ddevub2+3ZYUPljPUH4ZrZtAvz5yEgMa4XneYD9Vrf6RqHYqYEqzqWcJWUmCTCqK
AokLQCNup3/aNZdNNXK1l2QEs2xH4OrjPy3Vs3M4IutA+E+rYjrH6EjxPkjz5ERR
lSVtkUjl9z9FCNFWSvSla0OI1WYt8vKEIxDhfz2k/5H/qeuC32rNf4oFaTDcnLmz
+kVcPuHSKsmKF9y983LEZ5Uxb2lN0E47MWwwjfiiznN3OpcVaCQABxezCSI0Smvc
oRpgMQUtZ2lpcaV/pXeSDuw7n+vQBTjTBmbdhLOtO75pYm0FsU0yspwGDquBB4z8
88Fq3ejNfDPOcynXxNJi7aVfd2YsnIJRyg8A4Gm/Neb1KEf6YB2FL8Ip8zEl6J3Y
yOGL5HnzelkUyxxktmUcX8Q6DnGeQmxZjDxbCq40pf9EzKHaZFtfuddXBLBWc5oP
MgjLc5aRF2am24l/ih2sa6fOmCO7EQOaCIywX1t89khsmIaUz/GIvyRYH6+uYM3Z
PX7fD0JV9M9oiFBySbHM
=1Hs8
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--
