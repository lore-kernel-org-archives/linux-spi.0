From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] regmap: Add eplicit dependencies to catch "select"
 misuse
Date: Sun, 17 Aug 2014 08:54:56 -0500
Message-ID: <20140817135456.GE14537@sirena.org.uk>
References: <1408270138-29811-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408270138-29811-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 12:08:57PM +0200, Geert Uytterhoeven wrote:
> Add explicit dependencies for the various regmap modules, so Kconfig
> will print a warning message when another module selects a regmap module
> without fulfilling its dependencies.

Applied, thanks.  The second patch is a bug fix independent of this one.

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8LQtAAoJELSic+t+oim9bJ4QAJaNclTIyDOb68BMYHWZiKh9
rSnzGUaW9BYOct91EkWaFTSdvDXDpv8zNiVHFW5EfYAYe0cjN56WA7Fh6cs0Zegj
dgW6kPq+R1CAShnAuDYx4fur3liH8GiNGJtUbhu9nxFRuNxU/HklHnrOjM2uytxo
AMnx0CrpzV+/uymqt4OVsZIhrMqAWVU5QRSBIeWz2QALYYusVWdSL4xnrJeA4KSs
YnZIgrnuh/4dFnjsjTzFoNjr7mQr4IGNXbRqrrj9nvHLgHLTc+Wi8726TnVFbGGI
x0eUEYRxx/SUBXmrPU3HPVTW4OXl953lk6DxD1HV+b4ZWwIfeWFbjcmvHxv+7Dj4
YCYVlKD89bUZSpygXfENvey1EiyXwrLc46ujejJIAEQmXVFXkbh7auUYKkI+0P81
Xsm689WtlnUDzMtEO/WK4z4p0hNZ0M9GriEjpQ+4tGZg9wDOYNrfJY8Y35E7CHPt
/6DXxAongKar0n+nwPvF0oiA770RUuD+KC3V8ADk2mniy7Uc6Iy7kNpg7vQbU0CF
NfSFTrOdKP85CwXwV78Nhz9A/n7Piof2rL5G59OIxVsImzObwF1Uzm5cwfRdBJtQ
tbZ/aNui71K5LA6NOnyZAk91tWXRh3aMRDMpXpJirjT8GJiK8IaQIoLxHj4C3zoF
TJwO6iEO+vSZ0DaNW7/n
=XqZ4
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
