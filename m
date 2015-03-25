From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH] spi: of: do explicitly request modules for
 of-registered devices
Date: Wed, 25 Mar 2015 14:36:05 -0700
Message-ID: <20150325213605.GO3572@sirena.org.uk>
References: <20150325203222.GA8845@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gqEssfNGWsEa4HfM"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150325203222.GA8845@dtor-ws>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gqEssfNGWsEa4HfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 01:32:22PM -0700, Dmitry Torokhov wrote:
> Trying to register an SPI device asynchronously (via async_schedule() call)
> results in an ugly complaint from request_module() warning about potential
> deadlock (because request_module tries to wait for async works to
> complete, the caller is also an async work in this case).

Applied, thanks.

--gqEssfNGWsEa4HfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEypEAAoJECTWi3JdVIfQq60IAIE7J5ASaSQ1k/VbZW+qGDjx
num6mfo2nyDrL80yQboKu9aES5AWp/wwS7v77BbwuHla/8NHqE2PDqdgrNHdPsV1
Qr2ajrHONSG1M2PsE4nAddnra/7ibz/XrkJZuG1cu7jLCOtZMSlSSB9IUtVZu3pF
r4ODbpcnzJqDMco/dzWuhVZ5jtVd/8ipdztWw8SXGk+DLJzULN1KM+ZPjR1lrz9P
HoDw2DojjjSY+0KrRN1POO1udEF2aBGJ5/aEIcLfO7QkGSJ5/tJmlQ6g/WWX+54E
mLchU51g+hXJUcJmWm7Pc4iPpljK895LiMiF21lCVw/GJufLj4DmKHhyevkeegs=
=Dr6h
-----END PGP SIGNATURE-----

--gqEssfNGWsEa4HfM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
