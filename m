From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: fsl-(e)spi: migrate to generic master queueing
Date: Wed, 3 Dec 2014 13:06:02 +0000
Message-ID: <20141203130602.GZ7712@sirena.org.uk>
References: <547EB40A.7070909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bgLqsEYtovurQ8P/"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547EB40A.7070909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bgLqsEYtovurQ8P/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 07:56:10AM +0100, Heiner Kallweit wrote:
> Patch 1/2
>=20
> Migrates the fsl-(e)spi driver to use the generic master queuing.
> Avoids the "master is unqueued, this is deprecated" warning.

Applied both, thanks.

--bgLqsEYtovurQ8P/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfwq5AAoJECTWi3JdVIfQAbkH/1BVXUIv4T9DR5BBDioZzq0R
sCeWsTaEXFlvHGh7PreNJpzhxtaA1Adv6b+Q22tJeP/TN2Yj4uphhsbCxzjXotiN
rkw7kMfN8cFCT66cJt8bbXd7CLAahovJcDL9NMkCYt8JMgb6aJA3uDtVZrHNEzhq
KFWiJFUS6B68UHWVjXaCK+26WInX0H0R+Ml5KuiIZFsg2/8NmkEXUWnc+3WKceRQ
tgBgN9xOOPcVAk8b0CWPqqEBWs76xJfPSlh8aF4wa2oRQAMQiZHeXgukAaZO1lYH
7C3LTmCzdITsO2q8fcT8IQJGq1nRhizNOHSsZZL2SV8DI7hmgDqF+rtZOjKuUhQ=
=fvPm
-----END PGP SIGNATURE-----

--bgLqsEYtovurQ8P/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
