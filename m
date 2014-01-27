From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: dw: add support for gpio controlled chip
 select
Date: Mon, 27 Jan 2014 18:57:54 +0000
Message-ID: <20140127185754.GK11841@sirena.org.uk>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <b9ce1224f836ec84d5c75636b6838039a7664c89.1390723880.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b9ce1224f836ec84d5c75636b6838039a7664c89.1390723880.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2014 at 10:14:34AM +0200, Baruch Siach wrote:

> =20
> -	if (!last_transfer->cs_change && dws->cs_control)
> -		dws->cs_control(MRST_SPI_DEASSERT);
> +	if (!last_transfer->cs_change) {
> +		if (dws->cs_control)
> +			dws->cs_control(MRST_SPI_DEASSERT);
> +		if (gpio_is_valid(cs_gpio))
> +			gpio_set_value(cs_gpio, !(mode & SPI_CS_HIGH));
> +	}

Why is this not using spi_chip_sel()?  I know the old code wasn't either
but since both sites need to be changed...

> +		spi_chip_sel(dws, spi->chip_select, spi->cs_gpio,
> +				spi->mode & SPI_CS_HIGH);

I would expect the /CS polarity handling to be abstracted inside the
function?

> +	if (gpio_is_valid(spi->cs_gpio)) {
> +		ret =3D devm_gpio_request(&spi->dev, spi->cs_gpio,
> +				dev_name(&spi->dev));
> +		if (ret)
> +			return ret;
> +		ret =3D gpio_direction_output(spi->cs_gpio,
> +				!(spi->mode & SPI_CS_HIGH));
> +		if (ret)
> +			return ret;
> +	}

Should be devm_gpio_request_one().  This won't work with probe deferral,
it's outside the probe() function so nothing will retry.

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5qwvAAoJELSic+t+oim9vXkQAJZs4vvwUlj7d5wZUtX2ZeVi
0aDki0n0IgYvEmeHmtA/C/rLCimtmFLWRZPIf2xraPxAPfWWy2wncvuLWrA7/K/P
GYs/6CnUv+j2gtbCHJUXfCcygAJYAeHNVON1/VTeI52PNGMlKFrSyuHDgZJaRxML
Doxand0utFNThAMujBANQf/7KomyX3tP0yhSOmUc9TsbpnoMKs9lpQ49araY/Wxb
fMm2+7lTVBbiTwgxh0uLL/s07SycqOOuVHmdjJ83A/MFjlw5ufQRFTZ6dBwxBnwq
cz0LI2q/naebwvwFMs5R8LKaU7Csuhc+SwhmlQAnAGNJey1uXORNNs67ZjaLzdVS
RQNsqFdI6k922nvOPf0vMQrYBjwGizB0nOf2+uZs9YITv8kYqR7AMMFUJUNayXwV
dXmm/F2P9/4vGqZMLAEj+PXRcqCWnGT+BjY+YJnAxIR3VuMJ0bzQuMODh+9whqg8
vKHciquf/ALn3cPhuXZ67WrGb9HF63XaW7D3HceWojrLz7sMDJMLY2zo+idIIpVD
XcBQIUPK2LVJumBqvtn5JDtEh8ZxHxqdPV36wKp+5DwLO3rTTfUEHOy5/rxVWdP+
FytJGBb5NcsTcVaopW7JNZue4OImou/YZdZARh37k0lwBXNjsYovFqgVaIbg7jOM
jQ8pftYkFCV0B5d4b45R
=tX6h
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
