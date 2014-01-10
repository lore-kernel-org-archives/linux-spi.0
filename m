From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi_write_then_read with different tx/rx bits_per_word
Date: Fri, 10 Jan 2014 10:27:45 +0000
Message-ID: <20140110102745.GA29039@sirena.org.uk>
References: <20140108223538.GA2861@frolo.macqel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philippe De Muyter <phdm-KobBqTBAxd8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140108223538.GA2861-NqYOdiUDesgPnqCj3zZnUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 11:35:38PM +0100, Philippe De Muyter wrote:

> Is there a convenience function similar to spi_write_then_read
> to handle that case or must I roll my own one in my driver ?

Try regmap?

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSz8seAAoJELSic+t+oim9iSwP/0YtGL260EdkIHVo/Ho3ZW6t
FKxxvGkmxloTfoKRKNsBxDXaSO1YX33p1wlTwYGZ2y2fGMWRFeYuV6UZ5Ts+kDw5
zCr68i4u6BpkzIZN1yU/DiBO/w6T4LeuS+DTe+0eTDP6a7AH95zgSTZg1thtWT2l
NQmL2dbuCCDHBla55ukFylCm1GuuljGit6viyYTJ7DCp8cZ3qkGtvTrcJ4RSk26P
lCCAU49oWQwuvrSSD50//oacxB7/estKOlR7SYgrWKByRlLIfaZsn6AOClvQvI9L
CPRnRkCn7hpzqVd/Yh7QahyrfL/mp7LhTVVHrbFkVh5hkr3C6YTfmxfuevo5Gith
OKeZeP6KHE2B31+pt0BIozGfjwtKpMOwfEk29GmcZibxQyxVvhyZsIdNd8EgVoaz
eGGvzaBkWbIxtgLneUHEdAoAS3WP2wqBOfEB5eJUGHepkCvh2B0HE5MvJaM4uBE2
c+noPQK/mQlyuKZxVpuncOh2a1nYyXdyAP5UFtVJScgDFSUxo6Ysu8E7S7vBhDQ9
Jfdj2sX2HINqGPsq7BqwGRMXD41ezXFWAGR7FaiQNHnQB9lhqHPeJZqpLX5oBya/
yX+KKCQ+H2YgUA6bKXiPqIOSvKNOTRlKBkeGs8RnG7s2Rcd9zJS6Db4cuthdmgHn
4rdyvd68BSdqTwqihQ0T
=vXKY
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
