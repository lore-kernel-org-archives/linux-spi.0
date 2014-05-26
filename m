From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: Round up division to avoid slave overclocking
Date: Mon, 26 May 2014 14:30:49 +0100
Message-ID: <20140526133049.GZ22111@sirena.org.uk>
References: <1400782055-19609-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y+bLae2mFylWGq1m"
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400782055-19609-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y+bLae2mFylWGq1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2014 at 08:07:35PM +0200, Geert Uytterhoeven wrote:
> The calculation of the bit rate divider used a standard C division, which
> rounds down the quotient. This may lead to a higher bitrate than requested.
> Round up to avoid this.

Applied, thanks.

--y+bLae2mFylWGq1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg0IGAAoJELSic+t+oim9GiIP/RKxYEXXCk49kjMxe+WDHZ9i
TXHPCkwdfPJJUWkcXNxlOt/+HTYLUfG/DjVCGSfzarZV3FXVvlsHAzBtpkEwsg8T
dgcI1Z9FOY0N19+iHSwrgMBqzdSxKan3AfadEDKmIXDmlwvZaa6hmnyheYAvRkmn
EEl7XoqmKoC+xq6gw+3H4TFYZcBN/eWoAfZg55k/yy8jKeSQZDARuTeOBTJAMZ7t
euOioG3NKjDBBVAyUOqxnycBe2hhILfYW8llaPoRBHX33XEs+FbUW4GhI6/8X7kC
lSgCVq75PW7xRO40epkUyLK65BUNFgpVVksfI7NSzfjtQpmMJD9SR70YuKjCkz73
30wHJv1hhcu/D6j5m94kp+cuwt3fVRvSh+aHmbyiRn2AKXMcoOkoah0nDA2IC0GL
YonJiO5Rgbo0a94+7ikTTAFdVwr8iWDkPkXXUYJz5k/QHAWpf+08Lj3hmIe3nyRL
n8CBK54VNeTrUe90dWdYDcX8w1lcUuEOD9BQgaoHXpH46PeImLBtaxqBydANHavT
2GJ7tFLwyA/k1c/fcOUhzrpFJXrMNcI66me51GDe7xHjv9ewuBJu18fkcwrqlgoq
N264IFfYhPyGHUfCmDdYQ1WJkTdT1GH8yMrpqGNYniUoBL66r1HoJeZvhf7zm50Z
sfJRVAo29AovaqrTIS0t
=iysl
-----END PGP SIGNATURE-----

--y+bLae2mFylWGq1m--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
