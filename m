From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-atmel.c: fix DMA for bits_per_word > 8
Date: Mon, 19 Oct 2015 17:07:16 +0100
Message-ID: <20151019160716.GE32054@sirena.org.uk>
References: <CALnQHM3WxNDV3xzJwRfGRVTMYL1mo44VbBb2YawZVUzn0CzFfA@mail.gmail.com>
 <562513E2.4090303@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Cc: David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	SPI SUBSYSTEM <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <562513E2.4090303-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2015 at 06:01:38PM +0200, Nicolas Ferre wrote:

> > - xfer, &len);
> > + ret = atmel_spi_next_xfer_dma_submit(master, msg,
> > +     xfer, &len);
> >   if (ret) {
> >   dev_err(&spi->dev,
> >   "unable to use DMA, fallback to PIO\n");

> Ok, the patch seems reasonable. So, can you please answer my main
> question and give me the permission to add your "Signed-off-by:" tag or
> re-send me a more standard patch...

> Thanks a lot for your work on this driver David.

Please also remember to CC subsysetm maintainers on patches...

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJRU0AAoJECTWi3JdVIfQGTUH/0vbQILE2K95u9/lB/7eJTrA
0LXBvyR14GL0MRxeeYqYskpqhTIRpAVBdimGj/NB4KxNVqlfqbXcX53CSmpC4OfH
LG93aZ+6JEMd5LhNGi1PrVg0pu0zkwWhZeSKiniZ06+iAGWpOjyZI8DKG7XZtqFk
siv66bqsXKAbInunslZP7F3EFrQ83VevxOCaAXnkE9ZprG/fInsUx/xJiqBSGOGm
ks8TzYF8thc2dxaQbH7VnBebCicuCS/fW5Vf31f1dTu0Jlvi0gOEVQocyYC0PZop
PdN7NzkYRIfcD4aJH3fqquMdFiXw2y9ikcVETV5NBDfOLIosBOUs53YSrKRID9I=
=u8Lq
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
