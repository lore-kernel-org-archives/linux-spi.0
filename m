From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND 1/1] Revert "spi/doc: spi_master_put must be
 followed up by kfree"
Date: Sun, 6 Sep 2015 01:04:33 +0100
Message-ID: <20150906000433.GQ5313@sirena.org.uk>
References: <1441493214-12994-1-git-send-email-alexey.klimov@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FntOJnOOIM0rA1zI"
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Alexey Klimov <alexey.klimov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441493214-12994-1-git-send-email-alexey.klimov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FntOJnOOIM0rA1zI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2015 at 01:46:54AM +0300, Alexey Klimov wrote:
> From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>=20
> Actually, spi_master_put() after spi_alloc_master() must _not_ be followed

Please use subject lines matching the style for the subsystem and please
don't put noise like RESEND in the subject line, especially if the patch
isn't actually being resent.  Both these things make it easier to scan
incoming mail for relevant and important patches.

--FntOJnOOIM0rA1zI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV64MQAAoJECTWi3JdVIfQ1YIH/1I4hmIj6rg/2SoSPhvd4yi2
k5qesVMMr4QEuj74jfYDPhXicpKD0CJD6f8t0YlD87c9/66BnlUKbEqtJgiyCvXM
IkHm08IyfJGb0qPLk4OWmmT1sqCp7GB/I4npPLjbChB1I9M1GHmi2FgdTgJP4WOF
K1f58Yc2zMhWBf5RjqaC0m0f6PVtGKBz0ZhDDitTCFo6RQsg2p1m5pWLJX46Umb9
Mx7qtCt+FojfG+DYrNvFoAS52tagjHJfMnD6WBYLYEerABCHMXX9/oOAbujqm6hS
cFuUe7H0dOJAlP+sXZSEfYU7IPRBht1JNcDb2khVantT2eLZppsXKM1SHzzmIr0=
=z3Np
-----END PGP SIGNATURE-----

--FntOJnOOIM0rA1zI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
