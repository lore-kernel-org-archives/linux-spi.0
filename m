From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: efm32: properly namespace location property
Date: Fri, 14 Mar 2014 16:10:29 +0000
Message-ID: <20140314161029.GV366@sirena.org.uk>
References: <1394812888-22697-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPvCt0eiAD9X+G9u"
Cc: kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394812888-22697-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UPvCt0eiAD9X+G9u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 05:01:28PM +0100, Uwe Kleine-K=F6nig wrote:
> While reviewing an i2c driver for efm32 that needs a similar property
> Wolfram Sang pointed out that "location" is a too generic name for someth=
ing
> that is efm32 specific. So add an appropriate namespace and fall back to =
the
> generic name in case of failure.

The binding needs an update too...

--UPvCt0eiAD9X+G9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIynyAAoJELSic+t+oim9qP8P/1qB091CtGxi8TZpVkwG69bT
i/Xj1f0FKjqDwJJJf7VBn2wgFByaED5lHFKaC1tbpvUZov7SrgM0noNAP29ydkuh
a1JlLmLYrfUHUzyRFUB35+VIYXdiKHjJeBs3eeFLtsnoBgncb2jXX73dxwimagei
HXjNHp53YbvvOk/DM87I3NaOYiwzxmmrwu24HDXljAcwvF9/rYd001VR9uOpv9Ba
h7B9u9rK9VJU1CFnZh9vqMABSPmTS5yI6qUMYeNe2Bxt5GFHE3ei4bPCDvhMUlSa
fjx40k0cmqKpbVfm1GMtHTTBcAAbq+JhsHCeJSqsVGMpUpqTzdu0VmrK+fcG6Pc3
644b7xBKebD7MhtfhifI9DyjZahV2rQl6m5DURmehl65mc+l/0W9LlMXNkJorxiq
crlGnRM4Hl88jYD1cdJs8QRfwmFOciwD0fooCiMDuHSYEBjeIYLe33iy4KuiTC2S
/1keyKwGhBeMyNvC17YQiTj7l82kSDwWpUQYC3YtFpwT80wr5wOHtFzU6TJL509H
cZBNhRfrZCF/NiBI0HO4AjSY5np9aZShFYOMBBmy1yzVXApRbPqMuad7FWHvfEBy
1F8L/gznH2SfWNz8j+Ujd+TcvHETRBBmFn0JZomouupnWPWaD52exTntB+UN7W0p
fVh8GZ6FeZeTIcG2UBXD
=3Vtp
-----END PGP SIGNATURE-----

--UPvCt0eiAD9X+G9u--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
