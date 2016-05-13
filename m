From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix __spi_pump_messages deadlock
Date: Fri, 13 May 2016 11:33:27 +0100
Message-ID: <20160513103327.GE10264@sirena.org.uk>
References: <1463131892-5392-1-git-send-email-thomas.perrot@tupi.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Perrot <thomas.perrot-cVvwS2TCF4I@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463131892-5392-1-git-send-email-thomas.perrot-cVvwS2TCF4I@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 11:31:32AM +0200, Thomas Perrot wrote:
> Signed-off-by: Thomas Perrot <thomas.perrot-cVvwS2TCF4I@public.gmane.org>

This really isn't adequate, you need to provide a changelog.  Simply
saying that there is a deadlock is not enough, you need to say what the
deadlock is and why your change fixes it.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNa1zAAoJECTWi3JdVIfQvAYH/2TIQXLdWZ2SabX6K36reUMd
+G6o+n4xPtBYOWXqvW46CFSoAwBc34utSNdbB4FJVFCnHvCy/6B8wwnppFJMU8XX
2ESDNcIs3L+iHUtWN7GO4VjO3sdmd8Zu8wTux7PRBEkj7XZmdByBFV4sUScRn5TE
j0821I4i5J6ihLO3m2nw1GRkZbAjTqfSKYk0hgklrnmK99ZhDm8ixCMOu8noKJJl
Yh3MovQG8dVy714MQSvFVIQJqUmUikwAI5bQM08UAMcebMec7nRN3GsuU9dTBhh3
A6GbKBVmKbGrpH4KJ8pgnS2ciwAT/uFUqabOSyXPFMuvfJ3vHSLn7agf7mVoWMU=
=tH1n
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
