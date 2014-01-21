From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: Correct set_cs() documentation
Date: Tue, 21 Jan 2014 18:13:30 +0000
Message-ID: <20140121181330.GL17314@sirena.org.uk>
References: <1390317009-8292-1-git-send-email-geert@linux-m68k.org>
 <1390317009-8292-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4pX28sySFCT/oEO"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390317009-8292-3-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--T4pX28sySFCT/oEO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 04:10:07PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>=20
> The documentation for spi_master.set_cs() says:
>=20
>     assert or deassert chip select, true to assert

Applied, thanks.

--T4pX28sySFCT/oEO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3rjHAAoJELSic+t+oim9gP4QAJ0UYRehilvm3LteGuGep6kF
v4RNiYE2WguRXOc6WxtisLTOgOvtDbn4zW8MJAHZMizp22QLPQKFZSMcPktTxkhq
c+B20mN0I8zZDz3g585jPxNbcZ1zjAnGazvRc86+JPPPYdIbLoTiWGW3GDYlSeZi
9itLTUYI2mWfO/FKx6TBGW8SPksd79Ajh5ziFQyRaf3egA4znkmrAzLNmwuPCAgm
wvLFc7/AwWWxLdpwHokQFgWebdIbHcuFd1bCbh8pDIBjOH7ZnxQjZCqXMhXat8Cb
yaSaS+4V887+Sl1Uy0Euk05ugOCwLDrC+qPr3RV25ZRjZCP2Ii5m/rnNW8Cs6/PW
LiWplPDomdZwpHQ4f0DhjOC4gr+RjFu46yXzBfHLRZQwfzfmfY+KYmYXnX2Y0DOp
qGB2895NKdAWIz/eEFEOuMx+qopdMhQxj1B1nGGq72j51tATSGTl360b7Mi4CJKr
zY6MEsLiiC7amoiQbt+enS+uYuPLeF3dteLm2rS3ew7LFP8Q7Gb/vkDixyBs3rFf
yfSPIUqujMjso1XG9y+kc9N/5VJ4LHG/uxsezMol8uNRZdSre54EK1P2RC+MuAh0
IA1JP10HoLnQ8iUKh8yS8mm01zNf1BiF4w9eb9o+WskwKbovIYz0X41LKsytFr9q
D51FbS92nJ8lX/BKzQlY
=D8s5
-----END PGP SIGNATURE-----

--T4pX28sySFCT/oEO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
