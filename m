From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: sh-msiof: Add runtime PM lock in initializing
Date: Mon, 15 Dec 2014 17:39:05 +0000
Message-ID: <20141215173905.GJ11764@sirena.org.uk>
References: <1418652071-6396-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8PmjN3crGoJ4VbbS"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418652071-6396-1-git-send-email-ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8PmjN3crGoJ4VbbS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2014 at 11:01:11PM +0900, Yoshihiro Kaneko wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>=20
> SH-MSIOF driver is enabled autosuspend API of spi framework.
> But autosuspend framework doesn't work during initializing.
> So runtime PM lock is added in SH-MSIOF driver initializing.

Applied, thanks.

--8PmjN3crGoJ4VbbS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUjxy4AAoJECTWi3JdVIfQ4SkH/R04TeN+1x2Z7Or82bFfDq8+
eTX+Xhsf0+Czh7Z8pFnAuYiI9PtwJUiC6pMxzsxMwQL4ZpdeXUyh04XSRcDtTrsW
naG+amW9vN8FjTqzu+MCUtkgXdy+nR4mMHYEjIA9K6SHhnJKh6eKvJ36hGUrAXua
9qeZQsYwVG2Sh0/K7Tl0p9FAMEsOI7tESf40c1hy9JDW/vDZwOw1fFWv6HnBYcuL
APhVw0Kt/+e+VktfvNQe8Y1sUivs2nO7gVZlbJWGtmzqlrxAqhkhiZIOP+9xeYXV
3pcessZy1YPWvEayKsZl8nAG8Y+8ez7O1dKX7aU+IFn1/yibFAQKouynzStuolE=
=xh7h
-----END PGP SIGNATURE-----

--8PmjN3crGoJ4VbbS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
