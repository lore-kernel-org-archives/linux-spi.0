From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/5] spi: bcm53xx: Refactor driver to make nonspecific
 to 53xx SoCs
Date: Wed, 8 Apr 2015 20:49:15 +0100
Message-ID: <20150408194915.GK6023@sirena.org.uk>
References: <1428516275-12819-1-git-send-email-jonathar@broadcom.com>
 <1428516275-12819-3-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KOeZZ+6t3JCr/UYt"
Cc: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428516275-12819-3-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KOeZZ+6t3JCr/UYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2015 at 11:04:32AM -0700, Jonathan Richardson wrote:

> ---
>  drivers/spi/Kconfig        |    7 +-
>  drivers/spi/Makefile       |    2 +-
>  drivers/spi/spi-bcm-mspi.c |  301 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-bcm-mspi.h |   72 +++++++++++
>  drivers/spi/spi-bcm53xx.c  |  299 -------------------------------------------
>  drivers/spi/spi-bcm53xx.h  |   72 -----------
>  6 files changed, 377 insertions(+), 376 deletions(-)

Please use git format-patch -M and split the moves from the renames,
this is basically unreviewable as is since it's just a remove/add.

--KOeZZ+6t3JCr/UYt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJYY6AAoJECTWi3JdVIfQZ7IH/0hAlehA4FKwPMLgflObJXg7
h2Nqzsezn36NKLc7zW1wIRGgGF1jR1+9vXVZM1F/t7L8ai6gu28zLXcn7kUddk9E
sAIPFanGtFjbF8RWzKWPazN0mFDSZOsKN5ectfXo/tB+Xf9lGlnocH0sW33uwM9h
S8M7TX+wHyMqsLVxP9R48mLkA9MecS/K0bvrTWbI33SeCx3Ja4prCcM3Tuk/l0Uf
AbjHx8x/sAumvAS01vu7OpeuwEYNzSGlDpcyeWwL3Vb6qVYBh//Hh/NvjH1XRDde
aD/ELjPo+lpA6mqTzYM0TncJd1t5FOJiBUzkjBN/eb0hnBBLwtxPQOjpR42ekTI=
=E0TY
-----END PGP SIGNATURE-----

--KOeZZ+6t3JCr/UYt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
