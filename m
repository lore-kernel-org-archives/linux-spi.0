From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Warn loudly if instantiated from DT as
 "spidev"
Date: Thu, 23 Apr 2015 11:36:52 +0100
Message-ID: <20150423103652.GT22845@sirena.org.uk>
References: <1427499742-26916-1-git-send-email-broonie@kernel.org>
 <7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70@martin.sperl.org>
 <CAMuHMdUv0z=VOec+JbbRBeM9fg2TvQgRX4GefVbOZDoQoOECQQ@mail.gmail.com>
 <CAMuHMdW5hgB7vFmMc6TRqJ2wwWZ0=S+OKdQQoucXakoSnVixtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EEDXPAtTg2mD7Iri"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW5hgB7vFmMc6TRqJ2wwWZ0=S+OKdQQoucXakoSnVixtw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EEDXPAtTg2mD7Iri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 09:45:16AM +0200, Geert Uytterhoeven wrote:

> I guess this has been suggested before: the spi core could provide spidev
> access to all spi client devices which are not bound by a driver?

I don't know if it's been suggested before, certainly nobody did the
work to make it happen.  I don't think I have a massive objection in
principal.

--EEDXPAtTg2mD7Iri
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOMtDAAoJECTWi3JdVIfQvbUH/i+2oZwHdw5omLfxG+zR4J3/
IcJ38M2Shxr/Ro8M9b6emFLnNHm6SPdu1OjewyTEPlAyrcFBkfQ7ygekNB38lv8E
FsZiOd4qMjz/+8yyESEOIZrIHSuoVdmibL+wG8XnzyIg7uiVHwVuH9WoFCWLsJBZ
wrfzN/42s4o68I7q1nkJzP0JiTpyWZ4O9hgcIpKez8wAjr+mfNW/nL4BfFIfQpIM
2PlCcwFDZvznyUvuUUMsBKXMqL3y9vE1B29dNRL/Oiz7GUnUdBkyPFb67XkcgBjQ
ddR0upRkjZgDO4GY7FQcoPOhY8rMPQ8K7Nw/USZBnyU8JAWcdJuMrjHc34lmrGA=
=LZNm
-----END PGP SIGNATURE-----

--EEDXPAtTg2mD7Iri--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
