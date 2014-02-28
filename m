From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Fix bits per word setting when
 t->bits_per_word is not set
Date: Fri, 28 Feb 2014 14:23:28 +0900
Message-ID: <20140228052328.GN9383@sirena.org.uk>
References: <1393463102.12945.3.camel@phoenix>
 <530F7167.7000307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ECfFjUQjeBf+wxqf"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <530F7167.7000307-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ECfFjUQjeBf+wxqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 10:09:59AM -0700, Stephen Warren wrote:
> On 02/26/2014 06:05 PM, Axel Lin wrote:
> > This ensures to use spi_device's bits_per_word setting when t->bits_per_word is
> > not set. This looks like a bug introduced by commit 24778be20f8
> > "spi: convert drivers to use bits_per_word_mask".

> I thought the SPI core already contained this kind of logic, so that
> drivers could rely on t->bits_per_word always being set up? Yes, this:

Indeed - if there weren't such logic the better fix would be to add it.

--ECfFjUQjeBf+wxqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEB1HAAoJELSic+t+oim9zxUP/0jUwqa9HhMuGSBj/NkHVYNA
2FUc0m2SIBrtEeZ8eNM7izKHGHSuNwPoEJfDaoswcFFNZychzK9pkTvQRKuJ1pak
eneKs1WplVDEjTsyoDwLIo+0C8OPHQqViQM/t9USPOc6U/FNQBmP+XDdBBpTN571
Qc6Y5mrTr+f+XeDWga2CyQzMLHbp2racoIo8GuAdx3gKPRnIINkfOtWn7BvLUbwC
tlCkuw+WM5utnknisY/fylazpFPICiZWS6C1qJXkG/AUCWj6y98bJybqBKiINlz9
YjUk6Vuhxu9vi6P+SUWp7otRaEpm0T25ROfKcKh3ZwSuQ+LJEWep/stWm81rf46h
1saN+aGxFp6K0ytFy+qe6GIb+fv7G9OQzN/W0P1DYy31fFTgS3G3lTlezuXPo+OS
N14876fE384tUmcIGPTlOa9VsktDkksuQ7huX1vLdAj460w3sKoCXb3qlMr2AUDT
XwrmchFMwUVwXWTsZt5tA/ehteguuYyFsttZx1ivpi1eKTdyDOJU40czTY9l9S0c
egE4kSJVAIn5zRA32lzH0sS5loTUbaMXP18qeTzmT0PSviOiOx0DwCjm9Zq64QoK
h9bMqw+48a+alTKJ7xihBM9IgLVsBtVlmlNM/0ESJSHGsiKnFzppppSJKXowBxun
sSOkT7pfaQuEVL/Jx4Q8
=MR1K
-----END PGP SIGNATURE-----

--ECfFjUQjeBf+wxqf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
