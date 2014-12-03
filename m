From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-altera: Fix NULL pointer dereference in
 spi_bitbang_transfer_one
Date: Wed, 3 Dec 2014 15:54:48 +0000
Message-ID: <20141203155448.GA7712@sirena.org.uk>
References: <1417605949-11447-1-git-send-email-iain.baron@newtons4th.com>
 <20141203130324.GY7712@sirena.org.uk>
 <6438CE2D8332724FAD5D85EF6ED23E1912952563@NEWTONS4THSBS.newtons4th.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8J6R6OvZZ0rcaFC"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Iain Baron <Iain.Baron-YmHWzhjmega9Zq0HfjR8jw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6438CE2D8332724FAD5D85EF6ED23E1912952563-ERkBUouPzqe8yxLPduiYWyEMcTpanLKPuOMsETyM3/Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--e8J6R6OvZZ0rcaFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 03:16:41PM +0000, Iain Baron wrote:

Please fix your mailer to word wrap within paragraphs so your mail is
legible.

> > If we can safely handle not having the callback then we should fix the
> > call site to safely handle a null pointer rather than adding dummy
> > callbacks.  That way this is fixed once for all drivers that need it.

> Is it better to test for a null pointer at the spi-bitbang call-site,
> or get spi-bitbang to add a dummy callback of its own in
> spi_bitbang_start? The former has the overhead of a test every call,
> even for those drivers that provide the callback, while the latter has
> the overhead of a dummy call only for those drivers that don't.

If this is a valid thing to do it is better to have the test; if you
really want to avoid the test then the core needs to provide the default
implementation that users can reference.

> > I'd expect to see some code that checks to see if the caller is trying
> > to change paramters.

> If you mean in the spi-altera code: The spi-altera driver does not
> know what the hardware fixed parameters are, so it can't make a
> decision about whether the caller is trying to change them to
> something else.

> If you mean in the spi-bitbang code: The code appears to do this with
> the do_setup test, but it will always do a setup for the very first
> transfer in a message regardless, invoking the missing callback.

In some generic code.  There's nothing device specific about a missing
callback.  If the device does not know the initial settings we can at
least check that nothing is trying to change the settings later.

--e8J6R6OvZZ0rcaFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfzJHAAoJECTWi3JdVIfQX60H/09dCKH/g9Kq96WprXrAI0gt
C7d087PsMQaPvlP2sQQzRz4Wyl7buekQgrIbM719/j2zvKKVUW4OITnF1+wRFX+V
cfuL0mv9LOY76Kcwu4Y7SgiNggaCsTf6Ji3Nt3P1o4Z+mcMSGosFojupm6zEnxvf
rHIn9BBrQCsH/F1Ato7a3RJDlYKrs08xj4YuyCNbYUWVMufgoA9fI9hNsPmwPSEB
dkt0y0ccNPOdRJJ0pqS2EYfNsH9GUxHLARClcdTH+V+Xr6QRsc4sGaHDk32TZ/g1
EvFHGIB5wYfgtMW7o2S8/HUkEFxD6f/C9vcn1qN8jklgQvwCXVIyfV4RihcjQWo=
=rDoT
-----END PGP SIGNATURE-----

--e8J6R6OvZZ0rcaFC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
