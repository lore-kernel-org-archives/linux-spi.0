From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-altera: Fix NULL pointer dereference in
 spi_bitbang_transfer_one
Date: Wed, 3 Dec 2014 13:03:24 +0000
Message-ID: <20141203130324.GY7712@sirena.org.uk>
References: <1417605949-11447-1-git-send-email-iain.baron@newtons4th.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vjg+GLJqDh9WF8VH"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Iain Baron <iain.baron-YmHWzhjmega9Zq0HfjR8jw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417605949-11447-1-git-send-email-iain.baron-YmHWzhjmega9Zq0HfjR8jw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Vjg+GLJqDh9WF8VH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 11:25:49AM +0000, Iain Baron wrote:
> spi-altera.c is missing a bitbang setup_transfer callback to setup
> the clock and wordsize for the SPI transfer.  This triggers a NULL
> pointer dereference in spi_bitbang_transfer_one.
> Provide the missing callback, which simply returns success, because
> the parameters are not configurable at runtime for this hardware.

If we can safely handle not having the callback then we should fix the
call site to safely handle a null pointer rather than adding dummy
callbacks.  That way this is fixed once for all drivers that need it.

I'd expect to see some code that checks to see if the caller is trying
to change paramters.

--Vjg+GLJqDh9WF8VH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfwobAAoJECTWi3JdVIfQBjcH/0OfjfiGWWsbGWIRPBoz5uDF
dKQVbRysnxKTNs1UGykqmCattQwhfcYtioS1lMqOwF3IHbrE+ftNGLPaevl6op1C
nJe+dD74ZaHU/yAYmnEOvanc4vJKqqt3HgYlblWq5ZgOhP2k4l3w1Bum8JjW0EpG
EBBT4tZFoXuUc52x92tnghM4J/PDoPW34hGgrJ8CKaVAnOGXHkah/SHDbC5HizAG
KhE0rc46O39NfVhjoCNPxJ7jAdvoi5UHoKq8CTEOkQzdzIW6FqSLx5KKHAI8X6I5
DUKoxd2iz74qyn5yGXE3AIuNpmk7idIhbveqMn6ycph9ilSagq6XYOGMQHgufpg=
=BI8K
-----END PGP SIGNATURE-----

--Vjg+GLJqDh9WF8VH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
