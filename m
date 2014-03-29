From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: bitbang: Make spi_bitbang_stop() return void
Date: Sat, 29 Mar 2014 11:11:43 +0000
Message-ID: <20140329111143.GJ21628@sirena.org.uk>
References: <1396090212.3823.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396090212.3823.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 29, 2014 at 06:50:12PM +0800, Axel Lin wrote:
> spi_bitbang_stop() never fails, so make it return void.

Applied, thanks.

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNqpnAAoJELSic+t+oim9O1oP/iW0C/ja8+2QNCqVqD3pJFks
X+VKmOu4KzoSEXzjdM+7Isq50GF6fNx2pPgdKbvQ85OdAZ+wfBLNxHuwuNbr1BjK
6EKhn/x17W82a2LDzC0XYXahJbW9WGPn9Zgd73HBf21uskUNyDFc8HH9P263ibNO
6omAifs0O/W5urR3XAhwRuC7RJVU7B7xfYuoaAXvLGJFTbfs5IieUlvo3g3GGRdV
jnJzlCrFWaa68Ptczmgh+yEpDLUxzJOrViM4Q2zqjaDz9g4cJanfHGsIwVq8X40W
f4tWKXkw4LCv56MTlvZvlmohwZtP2mgFWQmfWqKqOGemJpEBAK3zTmFSwbg0trlK
bWf1Rwa8vIQ5MBKMePykwMNqLcUu+HNjtof2cEM8Vkitk85EgbEHNgXbCUNpj25I
NhtgBVB8Ge8xx2+XgCZzaveqr31JjPdy+WGNDrJYxV1tw4tP429+cVrmq9lZOmRz
PGKYnq+3PbQWOWNnsCov1A8tcRsucWaSlJysL8drl4EdoOsyDqi1VbHVYp5tpLVZ
3SSnKmtVmbGX1M328KzJI+JgeE9EORNWXx1xTds9A/AcblXP0qtz7EJixeZhbJ8R
G23bMdNVT+1jwWZBx6t8wJO4nLoT2zXZfZMd2acRogU1j+ApdM0dWR29Uo5byd8V
aEAyrl81InkOAd0LjbZr
=k9qq
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
