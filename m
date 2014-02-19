From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi-topcliff-pch: Fix DMA channel
Date: Wed, 19 Feb 2014 21:43:13 +0900
Message-ID: <20140219124313.GP2669@sirena.org.uk>
References: <1392802569-11148-1-git-send-email-alexander.stein@systec-electronic.com>
 <1392802569-11148-2-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yj5txDT0Ig3dqgrf"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392802569-11148-2-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yj5txDT0Ig3dqgrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 10:36:08AM +0100, Alexander Stein wrote:
> bus_num might be asigned dynamically to e.g. 32766. In this case the
> calculated DMA channel based on SPI bus number is bogus. Use SPI channel
> number instead for calculation.

Applied, thanks.

--yj5txDT0Ig3dqgrf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBKbeAAoJELSic+t+oim91cUP/iyk2mDiZOABxynksjvx3hQc
x+RSA5xY4fUzkViVdXxr/BgpxB6tDS8xl4l9Zt1fuAyVekqnhGu6Yzjtoe0ZNCpa
5bogSOvkPzYjOJHopgw9sxLvGFg65fc97+wh/7d5PlxuM86ErlbeHT0czag9xQXy
duk6UmrdttJoL399QvnMeN1ltzrb0e9aaFNbGWIg0H1U+D1a+QiGiE05WTihfagT
UFT7vYezwoy+jozw+IfbEKc7H62KjdCKFdoYe5NuBvDml8u78VLi2zUlZKpgaRPy
yrXA4fkfaP0yDs1oHkPPSMmP19AaX2aGUXyeLzNp3sihQWX8Kjrz9uD2gToRQ2T4
fFs8rFWXx/m/rMMipATSI9Os2FTMx4u7CQyZ0KPWQtgC6/SXuuJtdak3C2fW0ghM
dss9pMiCRyYsWd9uQPSsLQnllqwe6UsP9m70Ca41bSRi8gCu7YU/J6SCiy+LRkYc
0/0jn2eqsRf5bGgQW5GeocdbugDmSXiS71PvA6AFLltD27suCPJx8cejrnz19hVU
c7Piz4QaulLgdCzFnmcvW4RgIVlmBJ0KXneM6f4ds9MfOHV359nnyYB83b0vk4bM
nI5/QKYHItFp4/StvpV/gaisC9yk76MpRNBQeZtZI6c6dL1+VTA0HG9PZAgRbZn4
hh7yVXXR8wr4N3/V2wak
=DuVx
-----END PGP SIGNATURE-----

--yj5txDT0Ig3dqgrf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
