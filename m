From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: omap-uwire: Fix build error
Date: Tue, 24 Jun 2014 16:26:14 +0100
Message-ID: <20140624152614.GR23300@sirena.org.uk>
References: <1403590699-9625-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYG5ZC/RuVsIq1ir"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403590699-9625-1-git-send-email-sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cYG5ZC/RuVsIq1ir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2014 at 11:48:19AM +0530, Sachin Kamat wrote:
> Fixes the following build error introduced by commit b3f6a57506
> ("spi: omap-uwire: use devm_ functions"):
> drivers/spi/spi-omap-uwire.c:465:2: error: implicit declaration of functi=
on =E2=80=98devm_ioremap=E2=80=99

That warning is already fixed but swithcign to linux/io.h is an
improvement anyway so applied, thanks.

--cYG5ZC/RuVsIq1ir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqZiTAAoJELSic+t+oim9ezIP/jrM9rhQEYeSLiIaWZVygy+z
l5dN+QXqBtQpU+cCHBrm0r05iCcuodyEAvPy15qWbcBSj5TjkFPBzkhQywOAyazr
R0VWTAmc0KsmPcNzaicahwcO7UlPk+8fAvdUN3cT+ntlj5hVV/D1u4cH1KBBTM+Q
9+enUF+rclCBfWb/yOG1TJVbixx3qbyEVJ/zdusevlyR28N0w8h6XyQc1RXVqi2D
TyCDfSwZKOxpdGOseVU15y2/nd0wSXKq8NCVgxgTQf94mDuu6/Yr9K3LI3xqjJQ/
40o/o5jdcSis2UuO3p+2fR+9TkQmfvfxFXHktvPQhxmNB4jZ+N1m0re37W9+04Ro
AJG7Y/rybxxC1ba3wR4ARICdD654uyTJjtTLfL36CvFZskfiEsBZh/3xPp2x4I6s
lpUw3stXz+jrHCp8WtZv/E0X7VjaAmQ0ye0+0IUbUEKz2BCI2DYi1Fd4F2EcjGst
CXS1f80yIBg+rHUbf/3StyswTXsp62sR6TwE/Cdj45l4Eosla9MZ+e+HR/HtHrHe
AP5weTjtzbqfqjpuoZLT11xrkD737Nf7/NddXuB575YPcIJzWzR6BnoXa7AXjv9g
nTR7gBnT7BhBbq0hgT/mrL/tSlZF2+zUXmy2C7xQetZEJy3bKrVfoHhhIQGyACO/
VpIo227iHnjIeGo0f3no
=IRVW
-----END PGP SIGNATURE-----

--cYG5ZC/RuVsIq1ir--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
