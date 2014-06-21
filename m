From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-uwire: use devm_ functions
Date: Sat, 21 Jun 2014 21:54:35 +0100
Message-ID: <20140621205435.GE24291@sirena.org.uk>
References: <20140620203858.GA14718@himangi-Dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	julia.lawall-L2FTfq7BK8M@public.gmane.org
To: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140620203858.GA14718@himangi-Dell>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 21, 2014 at 02:08:58AM +0530, Himangi Saraogi wrote:
> This patch introduces the use of devm_clk_get and devm_ioremap instead
> of the unmanaged interfaces and removes the corresponding free function
> calls.

Applied, thanks.

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpfEIAAoJELSic+t+oim9tWcP/3ks25sQZDaskKbXtGfrrbc+
2juowYOME824rs6dx+tXKs1fY8iA9VZSAHEtLkgXQgoaC0Q8MPcgRGmZeJDxyQKb
8Xt7Qy6AHbWwbWP0kNu6SG63AgI0l6ggsxQY/FSztFmHHKURcPlJjW5qQNmWcHI5
CdXHsrpCpJt+TVp4mwqUZ7dAwppMxw2On0V7D0c9Hu5G9ROMX7FN/vABYjDBQ8Cj
MOk8NLe2FG7snCtVKeXj7aN/eO5kR/SSoiIaidQdW+xGPF3qSV+aOGpPfSEQ60N7
XlutpZWOF1H6KA9CENdz49yqForeSin1yQfuyxaWs3riYgzsZbVrFEV40Ka4uukE
FrAE0TTAlSrdVs6rgk2kjOmnPWo6vct3QfWBlint95/J/ATJeNAPljXbAcZiabSm
WvCTQ23GBuMTKqMghIbqZ8tYFo5wrkEvZOkWrCtuzGboHS73V8mBcZe+JecOTzfz
/a3grLPNPw2eE8714KjfKaRN1TgEhrZkKnf1jUBya/F3Ol0j5bySuot4Dasmhxmi
2SFXEiIJtzUU/6d8GoDc7sUKzUl2G+fB3MkCqdCKSJH6Zb6hjhhJHTwIBVFhuaVK
IkskFoi9jhK6iAdJOaL4UL/8Ehdgi+hsUmsEMFlzjGgfZdk9czoNkYIkeAJQgxFO
nZVysLYUH73qCFJKdCUs
=x9v5
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
