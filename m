From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: Return an error code in
 fsl_spi_do_one_msg()
Date: Thu, 4 Dec 2014 22:44:23 +0000
Message-ID: <20141204224422.GE11764@sirena.org.uk>
References: <1417698947-4273-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417698947-4273-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2014 at 11:15:47AM -0200, Fabio Estevam wrote:
> Since commit c592becbe704127 ("spi: fsl-(e)spi: migrate to generic master
> queueing") the function fsl_spi_do_one_msg() is not void anymore, so return
> an error code to avoid the following buid warning:

Applied, thanks.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgOPGAAoJECTWi3JdVIfQUWIH+wSqeFIwNV1CQChSIuohH38U
geM9z6FY84kuylK+cOlYoPnOdyPi+5WZaIcNrlNBWRFWjIwiHThqEyw2oKKjAiD+
HWN7QjdvQYtI3lWhEvk1IqA1CLcC4SbUy+fXwHXrD0ELnmTyQtN5xE7zn7xPHKmM
5qhG6fxc2jjZyv5e33x9qzd7bTovXzigMmzgPCvlu0SapXmAa7fPKQDSgF0BxNO2
aTEr077+Sjkxtd40pGW+JxJVVBhdLKHWrCJdSuZF3sp1ESzYFsYAkCwlpSWHpI9n
/y5Tbtfi1lKroheJaHnnr0G48Ifz3kHAIbxI5cEsJZ3AOna2wuwsSJRZ4Wps0Rg=
=0kNl
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
