From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bitbang: Make spi_bitbang_stop() return void
Date: Sat, 29 Mar 2014 10:02:21 +0000
Message-ID: <20140329100221.GC21628@sirena.org.uk>
References: <1396051333.18624.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396051333.18624.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 29, 2014 at 08:02:13AM +0800, Axel Lin wrote:
> spi_bitbang_stop() never fails, so make it return void.

Applied, thanks.

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNpopAAoJELSic+t+oim95loP/3LoAR+EsdtneLOUEgQFO7oK
mgSMU6D47a4qqe/Udrlcu67Zkl7vMh4NXVl1ynwNuhrRbCV78u0hjDGZOKUF2OON
xlj/iIUbKdLB1gCOzgtirJe8y5GCpvxKdf9+/wdAY7o4UcWMZoPGi3qprWlm1tjA
TYv5IhbFN3sNpFqtxb3xdQdnTt0Ae4jRhxkDoqaVwR7dpDtAJ3BNisl4Adpl0I7/
28Pqyq7BW2uwE964akpOtZ2TaToJwLowaj8wfqj1DSMJD1wtStLn8US+Uh4EWriV
s5V7w+rMqE8P1k/zDzK/RThA8BieqQH5uyCjGeMNoMx5gWaDQLkN2pcN+8x4QNQn
fF+n33goZxJvcuxxR7klB3CM3KiUkg9LohF2nKNTKNfOc39t40OZd+iX7YLUbISw
ce7ol5p+tYun1jWcvyiVv9xfPmMud5Ewb0upcWMyjJmcon3LiTUklH4FkWs+Mkqu
3vVv3+iHcdM+rTYl7yx/Fa6CX/oNjlWFjqamr3SD6uMetcuZiaO7frDsvTk9gjD9
qzL2SWK4AhxWEUEkHRHQvULHsr0BPSGfTTkn35HhzxglZukMiQ4MU1TbebUtXWiJ
E1UX10042s66kD/jm2e/Sg6QeZ/zt+KW2NLQBxxmDKRMbMVT6n1KoDG0wz9VRPUF
5Mvsg8tcsKMUXXNfRpa1
=I/RK
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
