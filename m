From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: orion: Let spi core handle checking transfer
 speed
Date: Fri, 7 Feb 2014 12:20:12 +0000
Message-ID: <20140207122012.GE32298@sirena.org.uk>
References: <1391483150.4695.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SbbROFN+SMqu6LKU"
Cc: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391483150.4695.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SbbROFN+SMqu6LKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 11:05:50AM +0800, Axel Lin wrote:
> Since commit a2fd4f9fa3b9 'spi: Support transfer speed checking in the core',
> the SPI core validates the desired speed of a given transfer against the
> minimum and maximum speeds supported by the controller.
> So we can remove the same code in this driver and let spi core handle checking
> the desired speed of a given transfer.

Applied, thanks.

--SbbROFN+SMqu6LKU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9M95AAoJELSic+t+oim9re0QAJPr2ckIs9O+CUX7qUBu21wC
kVv0tZ6Ryiz6oM9jU7oVE0wG+hxZKFnqY9ZBUG0MJQnZ4wiCvdYILMH5dshQ8azn
Qek6QfWBFDRfyFPsZ6NMG6dw+ItcahetzJQdAqkEVa68th/UBtsKOOu0dmzlyN8x
dXigPtLhCTob4krccAdzRs+JBaGBbzwjRsZ/yjIXFWN/P6KumLIqs91tMOv1lvXJ
AyJPvz7RcrXtc0GqobWvKZePDiOkRTQWtE1+3l+AFqn1jQHR9/Trxazw10QAfYj1
iqtLQpgHy74OUFp1rVS+rntoDkHhTuphTir9B+O5z2KbGHP1FBSYtDfoOOifWmzp
XMlI0ArvzahQrcdXUuVNI/+ywqamxe5n4WzIz5nWYU/U0huTO5+hhoQbNSy32NlP
XBTnY6vqnyXXHNjukrgJTXDlEzwvS0ubFQHxQlnX5lKZ8KMIDszNtNrcFDN4mvmg
y31UUKul0RWoY6B1l8iXOnSbW+wId328i0gGjYaOcUBOyGHn3YpYPT2gM0R/pOym
WTQjWIf1deqvqXJIxzyowKv16HEA565MCeyd9cO0K31tB1mSZVbVs6ePJM7HjSPe
QNUCkTWuw3JkmcrdWVEjxNaxFySg6FuFaDjBFl3u+zrjHksMd7c8rt3RWHObMZs9
OIfEJB+1QhWQ++euieOP
=NfzR
-----END PGP SIGNATURE-----

--SbbROFN+SMqu6LKU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
