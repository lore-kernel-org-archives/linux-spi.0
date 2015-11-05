From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] spi: sunxi: remove redundant "depends on
 RESET_CONTROLLER"
Date: Thu, 5 Nov 2015 12:20:38 +0000
Message-ID: <20151105122038.GF18409@sirena.org.uk>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <1446722128-11961-3-git-send-email-yamada.masahiro@socionext.com>
 <20151105112847.GA18409@sirena.org.uk>
 <CAK7LNAQsFTKhnUCUVkZXudjKjPc9rbA8ERWeq4hw8RqPnbRihA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQsFTKhnUCUVkZXudjKjPc9rbA8ERWeq4hw8RqPnbRihA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 09:11:47PM +0900, Masahiro Yamada wrote:
> 2015-11-05 20:28 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> > The dependency is on ARCH_SUNXI || COMPILE_TEST which is not the same as
> > ARCH_SUNXI.

> The compile test of this driver should pass even if RESET_CONTROLLER
> is not defined.
> So, it does not matter for COMPILE_TEST.

If that is the case then the change here is that the dependency on
RESET_CONTROLLER is just redundant which isn't what the commit message
says.

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO0mVAAoJECTWi3JdVIfQVV4H/iD5pEg47Ci+GA6Fle6pxJvL
HQrZt+ShlDYm/jZHw+oJ/+uaVWmIMUr6Ccr0L3ZJvo6OX78/TY3BWIcWbI4J5yfb
EeVqr/Wzj5y6IFhh2PycAh8+pH9WRwQmYao8WD+gl2XhfMq4U95GMZCDdfdTXNNv
TyJ05sG7DCo71dhZQxEPFmTC79/zphtrOjKbCGrfwXQfi+dzAd8OX/3Sm1v6mWII
ImPXNodCnTiA3NQyn0jJejW4lbRGdMZnuHF/d1BasP56r/GdXhcxJ5uLG/OIudxL
aLsWFHUkf9k6dJXarXJgA3Rpiq/88nOYSUub0Rd90ribYNYDN+h6i+FwLeJS5K8=
=V8Qs
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
