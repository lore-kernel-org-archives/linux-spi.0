From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: read back the RX/TX watermark levels earlier
Date: Wed, 1 Apr 2015 21:31:21 +0100
Message-ID: <20150401203121.GF6023@sirena.org.uk>
References: <1427877975-816-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427877975-816-1-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 01, 2015 at 10:46:15AM +0200, Lucas Stach wrote:
> They are used to decide if the controller can do DMA on a buffer
> of a specific length and thus are needed before any transfer is attempted.

Applied, thanks.

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFWYAAoJECTWi3JdVIfQykUH/1a2kS/Umi1tHIsOZG8qkeHh
fDsUZp1ix6YMbx1zpQ6ByEyXMrP6rUCr17jFOYfAmgF7ik79aSMtNnggBaGAlchN
pXPmTcEyjjG8UADxkyHCmMiWxy3Jw+xSKpB6x70yq2C1PkOg5hxS0XF+Jr7FHsTp
v9JQkW+u8UDXYinjdDw0pBRA9bNXpbtvx0ysvcOMwzzKm2NfTTk+9lra13GU6Khq
PjwvdHI7PaObxMUake0v8QGcbRAsuG5VW6KwqbksfAUXfNJk1jzAGArUN4s6oRve
jJwG3yvpwS45Sd+cQQmLI9EmGCBPyd4sJaL5wScvP9OEfC+F9vAydZPgv1q5Pik=
=DkD9
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
