From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi/atmel: add support for runtime PM
Date: Thu, 16 Oct 2014 11:32:38 +0200
Message-ID: <20141016093237.GA2200@sirena.org.uk>
References: <1413451390-22859-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413451390-22859-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 05:23:10PM +0800, Wenyou Yang wrote:
> Drivers should put the device into low power states proactively whenever the
> device is not in use. Thus implement support for runtime PM and use the
> autosuspend feature to make sure that we can still perform well in case we see
> lots of SPI traffic within short period of time.

Applied, thanks.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP5CyAAoJECTWi3JdVIfQn80H/2bdx+dbNs7u2tee0XVBQjxy
L+lNkGTti2NG0RD4Qy7doUJisurwxZzwVA0/3kiq53W/q0i3ChSBvTpds9uxPjn1
i+/DFKwM1dPh3bHGwxVlCRPuEucvyR42WX6bVlxXa6MAyb+CY9MHC8fKteSoanP6
sLBhXJdrW7b7vCy6VU3mGQ/D/U/tkTaMjdnqtJBx88vOe20ul+GJc/DvzGtj/5zQ
2Vhs7sWYN4JPRkwxYUyIQo3oySmaIcSJHSDEnbVoTg9rutTZSuvYziocfn748w0n
J2olYSYkUbnN6ER1v6Nao1UQbGGAMg1aeAttoUzDE9DZBlSoUn4WWf+RyB3eClA=
=tLau
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
