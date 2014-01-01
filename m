From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: dw: drop unused struct dw_spi field
Date: Wed, 1 Jan 2014 17:32:49 +0000
Message-ID: <20140101173249.GS31886@sirena.org.uk>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <134cfa84519ca84268fc0ef502fba12773224133.1388040447.git.baruch@tkos.co.il>
 <20131226114258.GH8064@book.gsilab.sittig.org>
 <20131226115826.GY11794@sapphire.tkos.co.il>
 <20131226153346.GN8064@book.gsilab.sittig.org>
 <20140102002133.46eef5d3@feng-snb>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JKqnEsEWyvhRy1Sr"
Cc: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140102002133.46eef5d3@feng-snb>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JKqnEsEWyvhRy1Sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2014 at 12:21:33AM +0800, Feng Tang wrote:

> But if you do see problem with this behavior, we can change it and
> also notify the other spi controllers who use the same method.=20

All the drivers should be being converted to use transfer_one() (and the
forthcoming stuff extending that) which will handle delay_usecs for them
anyway.

--JKqnEsEWyvhRy1Sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxFE+AAoJELSic+t+oim9s+gQAIHpGl/VVBUeiAmlooUhzWDe
fcneriv2lRukMKI7Q7HoO06Em4FV4uFHfKvpPBvpXKmxW6M/xQyYUIO8swyT5bPw
Dap5fAUvgczWO1Eb1pW3ca3Sg3+BQ6PeI9JzAxuWV4Hb7Si13jklRX0m+nu25P9V
p8OoVxOi+T/CF7dAsK4jrssZViq82E7RpEvd+S/okZtitJEmIelxWTSJZhNOjEb2
OUnUCRTQSgOgxAdVc0mCnrGdBEcR6RTSU5GF7lI2bH2fRfmqFqO7DtVoL2VRFUYi
HvM7wXIx3PbtBSFfaHpRYAOVi9OOwFjmOtcIup78o/5j8xWIXHtINorwND74IJZM
Y3AqulGazZ8IEzSdc7wufUo9VpSotoSYbX3EsjzvSkUhLH1v1IesOJ/F4uWbI/uT
TJ+FO8Pr7oG4hVyzRQReYqV2laBZI4DfswQLsofhe7pikzFbtF1RnXcVWWDRJEIi
pjw1O1d4L1msEYCTEWM9mOKmyJbrR2ymilcCa0CUKfo/m4u0sNY1ho1lvh3E2Wqh
xSmoQz+MyqGdmUhnSQO6U+V7NnipEALRHK+rMABwIpvCraS6QBY4tjkgqOKA5KpE
ne4UsEcIqtYk8EkcyihJrSnTudLfvIyo1FLT2461NxkXSmLQSbpFkrIvsB7eRYty
Dw/UghgyU/NdFAFCLpOz
=m5t8
-----END PGP SIGNATURE-----

--JKqnEsEWyvhRy1Sr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
