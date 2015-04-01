From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: read back the RX/TX watermark levels earlier
Date: Wed, 1 Apr 2015 21:32:51 +0100
Message-ID: <20150401203251.GG6023@sirena.org.uk>
References: <1427877975-816-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427877975-816-1-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 01, 2015 at 10:46:15AM +0200, Lucas Stach wrote:
> They are used to decide if the controller can do DMA on a buffer
> of a specific length and thus are needed before any transfer is attempted.

Applied, thanks.

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFXyAAoJECTWi3JdVIfQd1EH/1SfWZsALmyiADwyr7hWD37L
6ytsXLYOOERfMZdj8hdDBEO4yRnZBnoXP2CmbYrR8k9tRV44s+C1QHgCnP9YgAJC
uxf6jo2V66peKj0xgF7LWMeo3XOhtDtROajXXlrLHcLu7WkLWPFGL4onLFlBwfN0
TO8FKEkS+CLiegJ1AFtLHmZFb8wDtTqW//eItL1iQXFXgdCPrFkcIrF0Zs3uqYt/
pGiHZOsfAwUhNPXvhtbXs0HbbWRw8jYWTL59T/syDSdJH48vlG6M9vt2UWa9nfCK
4LZnAn5xy768i+QTcAI4pHKYlx2PAfHST0eisNlNJrlqvYd8cakoSBmWNQuHqW8=
=IY0X
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
