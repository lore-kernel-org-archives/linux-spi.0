From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Mon, 30 May 2016 17:13:50 +0100
Message-ID: <20160530161350.GR29837@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej>
 <5745C5A3.6060202@gmail.com>
 <20160525174809.GA8206@sirena.org.uk>
 <5745F30B.2040605@gmail.com>
 <20160527183629.GO16172@sirena.org.uk>
 <574A063D.5030700@weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XAEV7zm15O60d1Zf"
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <574A063D.5030700-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--XAEV7zm15O60d1Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 28, 2016 at 10:57:33PM +0200, Christer Weinigel wrote:
> On 05/27/2016 08:36 PM, Mark Brown wrote:

> > It is reasonable to provide and document something here but when there's
> > some fairly simple and obvious better things we could be doing it should
> > be those rather than the legacy stuff.

> So what are the "simple and obvious better things" that one can use instead?

To repeat what Rob said adding a label property on the leaf device
nodes seems like a more sensible option.

--XAEV7zm15O60d1Zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTGa9AAoJECTWi3JdVIfQWEIH/ikj28e4OS0RlFRM6k/mtZ/W
YdEXx9EWxJjtFamqqOujurgctktvEtTOLSd8PuUcQZ6qD7bsjxYLyiU8LD6TLfOC
ErxLKC55TH1XnMFmnBb8zktvJMtt4Rcbi6uy/dBydmuJGLw+LG0nL/RYzw5ZTngr
nFGMI2Fmsg73Pq44asWRzW6lSpYMZ9piKrrBnWnOdLNUqXB8tWZt5NVMrsz3m9B4
ybWg/4xu2WtuPBAxL6yPDTayOQGhWlNc3pQS/IYJUIgrCRfE503hfh7OpMKl3sIQ
Xo+ycLIVCo8RS1DRtrqn3GuNNjshzcVCHtjTlj43Zs13SVhz1NIVutKkg77G5fw=
=BfZp
-----END PGP SIGNATURE-----

--XAEV7zm15O60d1Zf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
