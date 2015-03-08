From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Use PM ops instead of legacy suspend/resume
Date: Sun, 8 Mar 2015 19:58:09 +0000
Message-ID: <20150308195809.GB28806@sirena.org.uk>
References: <1425822998-30487-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AdjLlRqdF7kYRNze"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425822998-30487-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AdjLlRqdF7kYRNze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2015 at 02:56:37PM +0100, Lars-Peter Clausen wrote:
> New drivers should use PM ops instead of the legacy suspend/resume
> callbacks. Update the SPI device driver guide to reflect this.

Applied both, thanks.

--AdjLlRqdF7kYRNze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/KnQAAoJECTWi3JdVIfQ1hwH/0gADlRQdF+uFwiLWr1kiEvk
j46RF/lsOoyNd50xTN/fgfzFiCXIcGvfDRopJ57ChaKPdQONNmAOhJqWpAEV71Cm
COK0gdJ/6N64wNXff5ZoSlvoSaJj1POXk5MXIsrpYd7dJ0w8MaLrvuuYiVxdnbvC
jJV89IxqOC1zCccKk4Prj5yBh5SLj2FE5MvD2v/8CYjP2FewcqFk6iulxATEF9Qf
1PUKW3tuFW7D1/+ErVOvPeEKZOuaESacDvgOlWPTuS+mjfANsTtyCbOJFrnwWOJ7
8mWKAyG7nu+xuT6NUWMMdnu1MjoveZRBXvQdVHSQdcvApANFh+HkHbE+SeYOF34=
=8sgj
-----END PGP SIGNATURE-----

--AdjLlRqdF7kYRNze--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
