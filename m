From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Add addr_width field to struct spi_message
Date: Mon, 11 May 2015 17:17:40 +0100
Message-ID: <20150511161740.GO3458@sirena.org.uk>
References: <1431269253-22890-1-git-send-email-B48286@freescale.com>
 <CAMuHMdUakeDgLZ4hXe0DBu97Xx4eiC9K_Qfc-imkDBrDBXNs6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MdEjg5WkSuUg8x46"
Cc: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUakeDgLZ4hXe0DBu97Xx4eiC9K_Qfc-imkDBrDBXNs6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 09:43:21AM +0200, Geert Uytterhoeven wrote:
> On Sun, May 10, 2015 at 4:47 PM, Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:

> > Make SPI controller can get address width of the SPI device.

> What does "address wdith" mean? From your other patches, I infer it's either
> 24 or 32 bit addressing as used by nor-jedec ("m25p80").
> Why does the generic spi_message needs to have nor-jedec-specific fields?

Indeed, if this is flash specific then it's questionable if the SPI
framework should be involved at all - it's sounding like a controller
that's flash specific and ought to be in the MTD subsystem.

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUNYjAAoJECTWi3JdVIfQL2sH/2/2+vYbiHdxeM7iFTQGfvu/
202yI7tL8qv9R1hfOD1Vtdkbh0Y9YbuT5L/mmQflMnztX0wV2/ZN1Kalo7+taX+R
jm6PiwvqPOgVqaZr/7gCh+TRZFsm6zHMsufzHLpbzWLmqitD2bsNDvFKbA5E16Sk
mJ+fC/ui9IdS4klO55XpNO+la4L0Gyc3pqwdXMrwQBmsBoXpUuMmCzObH66IP1vK
PNhzL4Tq2VU9t2LJftsNWy28a6pMo93/4b7edoo+cXLtCaSY99itXcvfFvUe9neK
R5IWgkbr3W00lvQ44JFkBFZiOMqGbjUEQFQTcVd+csOJhIGjjB7ronfBd3VGq+c=
=7TKF
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
