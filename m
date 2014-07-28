From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: orion: add support for multiple chip selects
Date: Mon, 28 Jul 2014 22:52:37 +0100
Message-ID: <20140728215237.GJ17528@sirena.org.uk>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJioXg+GvQhSmMus"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406498000-13079-3-git-send-email-thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vJioXg+GvQhSmMus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2014 at 11:53:20PM +0200, Thomas Petazzoni wrote:

> @@ -150,6 +151,11 @@ orion_spi_setup_transfer(struct spi_device *spi, str=
uct spi_transfer *t)
>  	if (rc)
>  		return rc;
> =20
> +	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG,
> +			  ORION_SPI_CS_MASK);
> +	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
> +			  ORION_SPI_CS(spi->chip_select));
> +
>  	if (bits_per_word =3D=3D 16)
>  		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
>  				  ORION_SPI_IF_8_16_BIT_MODE);

I would expect to see this chip select manipulation to be being done in
set_cs not in setup_transfer() otherwise we'll probably get surprised
when the driver is converted to use transfer_one() and pull the chip
select handling out of the driver (among other things).

--vJioXg+GvQhSmMus
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1sYiAAoJELSic+t+oim9SdwP/iGoHF+mB6CbbhPuCp3rKePO
xdTFM05s/yOxPL7pJDu3ETPzJperGTN9NVVz2ycekm6/+VafIMB1jXyTB9+e8x7L
cXSBpuPshxOREgKMMwG89dR+lqwU2Hoo7BZqo8Dzc7htfBBkkVjAzZhYDy9m14xZ
BSJ2PIYZKzYndMf2Q3+nI9d0+TrBwtEl0SdxaFiorT3cHA2RDszA3DXmOSUjdpNN
iG9HxkNDpiNHvEU1I9yFnJ8lVnwc61YhtDWA0eIPa77u6O9ASDztA+DKPXNBbqE1
2rmAPI708mCAnbOLfXKxUy3HmFVOWPzDYEsLeF2mkp5i4ZBPrhlbNIg1MNHTyOUv
dqU2Ngldu9vpEgK8BPyl22AITn3sMJI0Pa+3hfjMpScsVswUA0zu4degLuAZ5Z8K
2KrKKxPmVs0xfxDDtYHaM4JzbNdsclU5NYFdSzi4+w91uZXhIdDjCnAXxPBapYO/
fXyBpmksx9jVtBLQk4U03JaGd9iggnodnzFfcMcou/5/xKwiunT2y0nJulZW/a1s
xcjO6t/QkRZN7rFRQT4D+nekO1VhsHTDrJlv2jhFn8V8c61FIzrcdV2XXLqGcvlZ
M1ayqxsHT9+vSpyCZ2T7Ak3u3Li/JtXTpt8Z/oqmCKYJgl0MVYHm5WFoLyMjOMav
sx4MsAPb7XZX8RK9TUPX
=F0jY
-----END PGP SIGNATURE-----

--vJioXg+GvQhSmMus--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
