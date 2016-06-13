From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 01/13] spi: sunxi: set maximum and minimum speed of
 SPI master
Date: Mon, 13 Jun 2016 21:55:02 +0200
Message-ID: <20160613195502.GA2600@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
 <2db0ce0ea1ddc17e9bb790c8cc50bcb4bb97be58.1465490774.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timo Sigurdsson <public_timo.s-fWgRPtSzPNU3WX+qO2AYSQ@public.gmane.org>,
	Jonathan Liu <net147-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>,
	Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel@list
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2db0ce0ea1ddc17e9bb790c8cc50bcb4bb97be58.1465490774.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 05:46:49PM -0000, Michal Suchanek wrote:
> The speed limits are unset in the sun4i and sun6i SPI drivers.
>=20
> The maximum speed of SPI master is used when maximum speed of SPI slave
> is not specified. Also the __spi_validate function should check that
> transfer speeds do not exceed the master limits.
>=20
> The user manual for A10 and A31 specifies maximum
> speed of the SPI clock as 100MHz and minimum as 3kHz.
>=20
> Setting the SPI clock to out-of-spec values can lock up the SoC.
>=20
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> --
> v2:
> new patch
> v3:
> fix constant style
> ---
>  drivers/spi/spi-sun4i.c | 2 ++
>  drivers/spi/spi-sun6i.c | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 1ddd9e2..4213508 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -387,6 +387,8 @@ static int sun4i_spi_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	sspi->master =3D master;
> +	master->max_speed_hz =3D 100 * 1000 * 1000;
> +	master->min_speed_hz =3D          3 * 1000;
>  	master->set_cs =3D sun4i_spi_set_cs;
>  	master->transfer_one =3D sun4i_spi_transfer_one;
>  	master->num_chipselect =3D 4;
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 42e2c4b..fe70695 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -386,6 +386,8 @@ static int sun6i_spi_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	sspi->master =3D master;
> +	master->max_speed_hz =3D 100 * 1000 * 1000;
> +	master->min_speed_hz =3D          3 * 1000;
>  	master->set_cs =3D sun6i_spi_set_cs;
>  	master->transfer_one =3D sun6i_spi_transfer_one;
>  	master->num_chipselect =3D 4;

I really don't get why you want to do that kind of padding, when no
one does in the rest of the driver, or the rest of the kernel.

Once properly changed,
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXXw+WAAoJEBx+YmzsjxAggbAP/i3j7Ax9XN5zRI16Qt44rEAn
M6r958+FQFSwBXYRSphSLRF6jlHoGoPSsmLx4cQph10+7K++2X6KqCs2WAQGXvbc
FJVYdeC7KWGTn/+AIIW2ygeq/r6cjWdRwrHKQi2IvCMUdfog8fy8Zgle/m0Komsd
ZYXJaW6TnCn5HJXMd/9y3s54NWGHOthZkSRvdD+bSKgp/p5bHQ2kLkqDjphYkHzH
KHI6bHk8YZQBzhtCrHs0tTopKLip4xAcHOkhfkznELg2PWsZWitLUoDYcAwIgVwG
ZjOnmQcGyEDC3LTYH5V4qxfa3y7olqrPjosbsdjEPCCLW3d/+L29L4ESl2sCPoKI
043XCWEywl+gA/hGPgm/CcuapcYApIRPpLIfyf7N80chLLBZvq29BbXARNu7pGCP
SovSkKkubYQaFALaAWhnq8iNvbVTwd/JeV84qjchcAuaMqpCuVfdcQw14XtmPhPC
dmyvSsdpS0TxFm4OGSlLYAYJyZNO7OoqFY33DvFYTr876aYJNhr5xpjX8d+bLdzL
pmcal09EW9PKNMPCsYxPuCmOe0e7BHqjDJA8IrvMBmCqn8Gy9lCeo+T8dide0G4s
HZBzkBE3y17Hsnh9X7GnMZEtWCaeBGT8ks2E/GKIdt5nTlP9RS+SXIsFy44jDwgq
b9SeLukbeImMPnJtI2Ho
=vXou
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
