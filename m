From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: fix reference leak to master in
 bcm2835_spi_remove()
Date: Fri, 15 Nov 2013 10:23:51 +0000
Message-ID: <20131115102351.GX26614@sirena.org.uk>
References: <CAPgLHd9d9_eft2VYh5w8sesEuswA5dom_mNQnbExsKm+tZQbfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+rRWuC8ZLvVekNoN"
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9d9_eft2VYh5w8sesEuswA5dom_mNQnbExsKm+tZQbfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+rRWuC8ZLvVekNoN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:43:27PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will
> leak a reference to master. Fix by removing the unnecessary
> spi_master_get() call.

Applied, thanks.

--+rRWuC8ZLvVekNoN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShfY0AAoJELSic+t+oim9oHkQAJDGumoGAz3mZjs1yTSVXs+i
Kmc74L/8SM3UlXcOg1Qa3rc2s+cQ3iSuQS1BWTymGFqsofPZJKCk3NAtZ5qnObrW
S55ioRFtFDD8qA+YYxlu93ZI9LFx3z+NuzGR5u/jTB7KkmSLL1U4LD5CbLcxUd4V
goSrtfeNmubP1xhpZGHeCGcEOMZ5VUtPEabWkBfcyZnYT2AbGwHEhvXBchBe78/W
xPXU46EhXUncrN0nuUUk7bGro8crP0/NmgILWO/ktBG0FIwvjDbQ/2gMa3PSjg9h
5F2wJl5EnVzecs8q2egB7dFF5F7gHaJrVbRBX5LzsWqz7WErRN3NlJCHLQo+0BX9
C7kFmuU4D642+mA/QSvIr2CS7JdLjxWlJ6opa+4RY9MJJsgz9aE87srRb7gg9wb1
Of4XtjJwJe94Xi8/YX4dmnlUFTwmZ8FeaKzwFCmUYgfosQ+c3ztzCU2IpTkt9bAI
LQzXOdLmMRdHdV426Iuz7elWGstQoDgILMlsaMaZ0jrx3YXbwa+XKPaQRAT2ljWE
8a/xKJb74qv+Wvd/Uwn5UwYl1JNAcSv3Te3OeuG3gy31dBohiYj3mdVOf272sg6g
UUgdRtnOibQGtZ5of4Ozk0JS8sYkjEdcHo6J/NDxad4/lXuJSnOF1Art+qaqoKTQ
Z+c++ihrotMRU7jLtDhP
=FHoW
-----END PGP SIGNATURE-----

--+rRWuC8ZLvVekNoN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
