From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
Date: Tue, 3 Mar 2015 18:44:03 +0000
Message-ID: <20150303184403.GE21293@sirena.org.uk>
References: <20150226161142.D08681A2360@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BPgJ2GbR8X7BKSc9"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150226161142.D08681A2360-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BPgJ2GbR8X7BKSc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2015 at 05:11:42PM +0100, Christophe Leroy wrote:
> On CPM2, the SPI parameter RAM is dynamically allocated in the dualport RAM
> whereas in CPM1, it is statically allocated to a default address with
> capability to relocate it somewhere else via the use of CPM micropatch.
> The address of the parameter RAM is given by the boot loader and expected
> to be mapped via of_iomap()

Why are we using of_iomap() rather than a generic I/O mapping function
here?

--BPgJ2GbR8X7BKSc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9gDyAAoJECTWi3JdVIfQZeYH/0iTYbCGDUqESLRuSfhDbpdi
mPGeWIAHENbJODx9JOsTepCbk3sQ2fdmWq7LCmlv/j412/9LPSk8Y0X7GsC73tE0
vueM2sEm4ZAlo+FbfUg2dx4xqtc9aTj8sX75CkTNL/U4ZAhvc60Q/DK56qmE+JEQ
8D95NxXQxJER2AqSAA/GUOwXpLAM01eRDKFEI6Ap+TOM3pNGeTjCJUxmlf4EJuHR
8Xy9nOUpE8QaMPDFx1hprNZdSXz0xZ5AjrLqgS3tQVE5WxHcc7VdOUQBbQ0L9pLO
idvttOchxPldNxLhuBAQki7tyOETNUSOFhPf74x9FrOwGWSeV9cN4jdI9vzzMJ8=
=1Xz7
-----END PGP SIGNATURE-----

--BPgJ2GbR8X7BKSc9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
