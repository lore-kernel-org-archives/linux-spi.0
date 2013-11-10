From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Sun, 10 Nov 2013 11:05:24 +0000
Message-ID: <20131110110524.GA878@sirena.org.uk>
References: <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org>
 <20131106232605.GC2674@sirena.org.uk>
 <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
 <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131109183056.GU2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2013 at 06:30:56PM +0000, Mark Brown wrote:

> You've been doing a bunch of other performance improvements as well,
> it's not clear to me how much of this is coming from the API change and
> how much of this is due to changes which can also be done by improving
> the implementation and without requiring drivers to be specifically
> updated to take advantage of it.=20

An example of the sort of thing I'm concerned about: if I understand
correctly one of the things the prepare and unprepare operations in the
driver do is the DMA mapping.  This will mean that if you prepare in the
caller the system will be able to do the DMA mapping while a prior
transfer is in progress which should help performance.  That's a good
thing to do but it should be something that can be done as part of the
existing API without needing drivers using SPI to be updated.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSf2hsAAoJELSic+t+oim9R8EP/j6JlaV1Q7PuO2dwvf8YL78A
sv4d2DLuiD+DbVo6otNuCfQ7YpLr4+KsiEeHwSDI1On8YedAdvnssVVwIzJv26JX
Cb2WsZQAyA6zRRdaZZWbCeGf9FX2w3M64dcjF6LSvaaau4pWGr+68RBvMu81wsx/
AWT8yqR5GhhuiRvx25UFFiX1D4xoMA+Cmbw/y8kVsmvbR/mf8+aoUQJqZULRW9oB
KEjRMr8aejVBOX4WvOEBmH6xs7G4B6hLn7Xi3+VjxzDtq+xQqQYDepTSmSuHEvCJ
5R0HRG0dSb5pwnjb1VVZ9C8CuGHE13HqIh7BZUWabTGO5se2uZ0CRFO46WTYw4u3
h1DzlBhTN8gIObvbdJigV2goAQPoK9AUB3obAhEJNb+cuItsF+Vyg2Z5Vu50TqqO
mue9Kb/wEYRBr0VHoYdONvWlvZK7s20sGLtMEVfQMtG508oAcKXvynQ1xTSW7eF8
1hJLLCaddyye3cyAc7MsclSsMRgqnb2UwnILx2ePEawfnDH4xvtiXScIPpBqplhP
t0ENqJ4ZUD3BUes3zTFMuYqaJGztQDiaoqkGZ37hNv2JzEZAUFsocpLIe/BfVzDt
E5oKYIG6kUJFq6HyUAUK/XNPOuTCPU368blRXW1/gVJuRxoOSXZ169JrB/TgAzOc
FAvEn2bJ+bfsgazueRAt
=k7v7
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
