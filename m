From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: __spi_async: why the check for a callback as a requirement?
Date: Mon, 17 Mar 2014 10:59:23 +0000
Message-ID: <20140317105923.GA11706@sirena.org.uk>
References: <E6C88A40-D009-4434-A4A1-A77D4A76DDE3@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E6C88A40-D009-4434-A4A1-A77D4A76DDE3-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2014 at 09:21:47AM +0100, Martin Sperl wrote:

> I found out that with commit 24a0013a04e81e9519 there was a check include=
d=20
> that checks for a valid callback.

> Why would a callback be an _absolute_ requirement for a SPI message?

IIRC there were assumptions elsewhere in the code that there was one,
though I think those may be gone now.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJtWIAAoJELSic+t+oim9W0EP/AuGL8mDmGG8Ud7cfBgagJo/
OzqOCgjFzHJPkfbkbcftw47AtyupQFZehddOfjYHGWqJf3zTaICwHiYz7cG7K+hF
KpJhqfNWuCx5u6BRBe7e3sd64YQQCwEGCQNNTkm/ALpoCkJFSY+LiYpl1Wz4eYMr
Ng9zeJOwtr23uCHRz4rleXnUeY40S/5cFRiLIsM/rViLDEtFyeSvYQ/6hZYdZiGS
AT+00StQJrqwCgrqdnMB7bcrFJuNU9yFvYc8iTlSPF8mNc3SKkZkfvabPoXSmvHX
ZMQvtoRSRnLJ2fOAKEckiH9PkUABxri/SkWlQ45GeW6rCV62ykyIUcG86Ei4cNP7
WJCkXLfUkcv37zrA3qQeOAGdeZDh6U/R6fdY+ZsRdH42muweCEuH0EdQMvAJChO2
tRCpEeWI51JC0+Z4o1Hx2gI9CfkLV4D97SAywHEVeNaeqKcfehHgmQ7iFyaUoW4o
FmS4mU7Z22BoQAVyPUYszhk16WbcB8F1DmISACqhNr+7S6Mq5VjgU3SQgtOgntFm
P7s1CTwcIQT//lqwZlbp/6QQFbnF5srh3zgIkocY7+Sv0eoGnsYVh8lfB+CTbJ3M
OGfdPiN6BP27QyIHnsPVpmlguYRQ9zIlk13wiGM5sSff0GIE8Kq41ZNcHQIZv7wu
H73pT+Q14ZPejxDVL0vu
=20GB
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
