From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/11] spi: bcm63xx: Use devm_clk_get()
Date: Tue, 17 Dec 2013 22:36:08 +0000
Message-ID: <20131217223608.GN28455@sirena.org.uk>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <001301cef4c8$40d2b3b0$c2781b10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SqfawxHnX56H7Ukl"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jonas Gorski' <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	'Florian Fainelli' <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001301cef4c8$40d2b3b0$c2781b10$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SqfawxHnX56H7Ukl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2013 at 07:20:15PM +0900, Jingoo Han wrote:
> Use devm_clk_get() to make cleanup paths simpler.

Applied, thanks.

--SqfawxHnX56H7Ukl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsNHVAAoJELSic+t+oim9C4EP/0u9N3MJ+uY7YZ+4C+ZbEj8u
xJbTNsBp6GqriGYP452t2Yx477l8tnXC2T+wGdKj3pxy2Ng+IYuhGyC8Fo3gjgTt
zUKny94z/NiOKKZArpsXKhhSJ0A/HW9zYIP3fovjXvGgLfAv05V0IclimSrFQhO6
goBQlJmHrKhdOD6cyMMhztMnvypwlW9fBceTCrY6gOgGamtRsJfbpeGJ5jLj1upG
tYfAat1lTQOyhp/FYDgJCYONsX62V/xEpT7aA1sfpBhAdGBkLIbXPhW3ehJ/mLJ+
czddqcF3bW6UehcEvukdRJ2TZmg3fQtNH1EaZQOOCGPjlpsBmp//R8Zilovzqcis
7TsZ2ieCpetIqW0rhbWX1RfpyA7bdfWhIMyRAKk2xXl4CR/pQqfhrkkmLfSjpb0S
VwxCwl/ncUOyKiMmcKtKZ7P7tPn4Jjrd2YHbDD5yG07dsenFA1Q8+gMiMIfCaEkg
8aY6LvHeSyJBfcVRq4TtKKXoh09ruiUr1sYRxUS9F4SNjH7Ks59/8MJBcI0hKftU
a9N40sNb8KbmdwyC7YjhaSxKaLVgZ9RcTuv0jNYz7AH/337yCGEcbm9k7n2ecY7m
AR+bnPo3xygHcBID84PRXugfO3gYS200kiLVla7h2FrCAW9uNc/O/jt6gKUbfRXI
WHzCRomS9inROnbpC1PF
=5zio
-----END PGP SIGNATURE-----

--SqfawxHnX56H7Ukl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
