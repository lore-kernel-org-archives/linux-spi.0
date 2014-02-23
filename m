From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Use list_last_entry at appropriate places
Date: Sun, 23 Feb 2014 12:47:36 +0900
Message-ID: <20140223034736.GB25940@sirena.org.uk>
References: <1392214407.11101.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tYqdTR6Mwu/xEI6p"
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392214407.11101.6.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tYqdTR6Mwu/xEI6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2014 at 10:13:27PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Applied, thanks.  Coccinelle ought to be able to figure this one out -
might be worth teaching it.

--tYqdTR6Mwu/xEI6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCW9VAAoJELSic+t+oim9hZ8P/jA2J5/x2HBNZM0Vt84u6GaE
xSq1q/2+isuJEmZ0XvtMhrsW5VyyrKqmjBgSIqQrVwwlVf9EppuKsspkSm1oS/D3
5M9JHz0MhwQA57gtrCEru+tCgF9GlhsUugYoRwhYMuRNmoFcdnS+3g8SxAtc9ECN
S1vfQYu1XiH43AGXVGXEUX5uRK/1CeLCmSFHBNgKMQqIZrViPh9A483iqX4+6gPn
VllbdNBAIRe68REuso52pOTF8FGmGl//wy/Uc8NKojtrgc/chKEIrLC469Wvtpx6
tWE6T1dJR8508cVFnJIWnzVLZ+oflN5/nXffrkUF5sMXq76LaMf86wX1l9lqRWDl
sTS7e78rHoLX5sTBOboB7RiRXUwvnpxnRSiRp2+cLyXyf3TvtOqRNbRL28gFbNNp
cYfyI7vIt/EqA8v9D5M2kWudT6ra1OG3MSmdQkYk8Jkuy4ceb8kB45vBbMZ0cmsT
2P5xN+Bf8UZL53wHwSRR97puKVeLrhSlQgjfFYYQITmVUYO/Ky7CZoFADrUHrJxF
epLbnsAVl3qqoRYdt3nXGKRUiZyGtqBEWzcSKIiy+cmdAlNZ/xvLc3LR55m/WXVg
Az1EMxGVQtqY7k1NtXSjdcH5lQJJVwh94j0cfGfkpvVQ7ONZYhbExgS6wlWYNA17
vf1O6q3Hr49oNrpXdQrD
=MuPu
-----END PGP SIGNATURE-----

--tYqdTR6Mwu/xEI6p--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
