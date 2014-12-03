From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/of: fix warning due to missing CONFIG_OF_DYNAMIC
 dependency
Date: Wed, 3 Dec 2014 11:22:13 +0000
Message-ID: <20141203112213.GV7712@sirena.org.uk>
References: <alpine.DEB.2.02.1412022041580.16734@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PRH0fqouaz6lm1TV"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1412022041580.16734-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PRH0fqouaz6lm1TV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 08:46:28PM +0000, Paul Walmsley wrote:
>=20
> linux-next commit ce79d54ae447d65117303ca9f61ffe9dcbc2465d ("spi/of: Add =
OF
> notifier handler") is causing the following warning during boot:

Someone already sent a patch for this (think it might have been
Fengguang).  I'm hoping Grant's going to apply it, I can't since the
code is in the DT tree.

--PRH0fqouaz6lm1TV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfvJkAAoJECTWi3JdVIfQ31gH/0SM17cqZHq3nR+UFwO3a6jh
xXyPOMCM9igiz8aWSwqET1AmChwGD7a+K2MNF3GD5p9kVnQ+TwNIZtQF/qBycxiY
bsFUB5M+mv5o8VRERB/v/10gK/vYS4XtOnU0L2TrtabIAal2FswKd61mq6GGP1Je
S8b08by7DlnFES+713nx4+4WA7j6SuQBf2MsREJ9q5KZSpkLltUXKaSN26elopyR
4dui63o+0/3IFkSUv0tfQaAvXkGJ/l+PweHMsTKcaMvIgm9OH+Onsi9pHaX+++RO
cfIpyFXOvZ6Qxyb5MFz/4vdwm7/9CADD01CWU4f6u3tKl5Yp7Em+m/5oSAdJPts=
=GnU2
-----END PGP SIGNATURE-----

--PRH0fqouaz6lm1TV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
