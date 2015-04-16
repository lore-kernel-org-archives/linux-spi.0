From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: check tx_buf and rx_buf in spi_unmap_msg
Date: Thu, 16 Apr 2015 18:58:53 +0100
Message-ID: <20150416175853.GD6023@sirena.org.uk>
References: <1429152858-1141-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="awp016Y6gRfRyKnU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429152858-1141-1-git-send-email-b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--awp016Y6gRfRyKnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2015 at 10:54:18AM +0800, Robin Gong wrote:
> Some spi device drivers use the same tx_buf and rx_buf repeatly for better
> performance such as driver/input/touchsreen/ads7846.c, but spi core grab tx_buf
> /rx_buf of transfer and set them as dummy_tx/dummy_rx once they are NULL. Thus,

Applied, thanks - good spot.

--awp016Y6gRfRyKnU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVL/hdAAoJECTWi3JdVIfQHnMH/1MVV/SBBxmye6Pc67fZ7n1P
nNgaUYvo+gN8+DYJyQr1e4rL+mInryBdxDLPujpg6BC01xlCrB8yO9gGRfC2aryO
SrGneZyuM7NKoI7tx7H3S3mCDASPvwIvH/Z+Vlnwlw8vUJ4vS5216ezrCxSyM8QX
wXXEbusV1UOJorXdbdDaHQB+BlJ9/szpWWHu1Jf5F7RWcIB0PkVyIlXNJjZ0pm6o
c3ZIWlGa+AIqyXHp6bdKga2G4IGHvP8uDI8bYUMczWL/7KSSOo6kAGQ0q9FurtFO
qc4eO62TLEH8F5ZMojjJDba/rSUWpdGgxxwFKbC7aTFezMFTySU20W00XzGBgEk=
=gvU9
-----END PGP SIGNATURE-----

--awp016Y6gRfRyKnU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
