From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: dw: revisit FIFO size detection again
Date: Thu, 26 Feb 2015 11:10:02 +0900
Message-ID: <20150226021002.GY6236@finisterre.sirena.org.uk>
References: <1424857176-4711-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bEH3Ad9qdU9b/Xs9"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424857176-4711-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bEH3Ad9qdU9b/Xs9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 11:39:36AM +0200, Andy Shevchenko wrote:
> The commit d297933cc7fc (spi: dw: Fix detecting FIFO depth) tries to fix the
> logic of the FIFO detection based on the description on the comments. However,
> there is a slight difference between numbers in TX Level and TX FIFO size.

Applied, thanks.

--bEH3Ad9qdU9b/Xs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oB5AAoJECTWi3JdVIfQZBQH/RbR1hbcH6fx/kxwotgx/cQG
yW+bW+kh+XIo1NLINEDSjKwk0+5vCazcWxYwM6r1ocMHdYg4pBJoX2h/YHTaL6VF
TVISGYgXYBdSI/5Sxe3Qk2rDRAOTG2nr4XZ5j9gEu25M/HP74zLiQV6+bVYKai/t
ziTRSKnYK9LS5LkoV3L7TFaHmTENBmYzDn+T0ANpHFbYtD0VSLyWXchwyJKpqduN
iK7AXtkrnVXRA74e8mejIXzRnpxNoP3sZs5v4IWCD+anlX655H4iY0EZLXVQ7v6L
vSe0Z1b62dGd22kR59DwQa19N+oP+d/jX5UTKQFVyp/Kmg3zphsDeL/hxjIuAtw=
=ngPW
-----END PGP SIGNATURE-----

--bEH3Ad9qdU9b/Xs9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
