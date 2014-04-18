From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Fix scheduling while atomic bug
Date: Fri, 18 Apr 2014 15:42:48 +0100
Message-ID: <20140418144248.GR12304@sirena.org.uk>
References: <20140411214815.GI28800@sirena.org.uk>
 <1397385910-28368-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sl8vrUT7HIMjHPiu"
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397385910-28368-1-git-send-email-alexanders83-S0/GAf8tV78@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Sl8vrUT7HIMjHPiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2014 at 12:45:10PM +0200, Alexander Stein wrote:
> atmel_spi_lock does a spin_lock_irqsave, so we need to renable the
> interrupts when we want to schedule.
>=20
> Signed-off-by: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
> ---
> I'm not sure what the lock is actually good for, so I kept it and release
> it when we are about to schedule, thus reenabling interrupts.

Applied, thanks - I don't fully understand the locking either and this
is definitely a conservative fix.

--Sl8vrUT7HIMjHPiu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUTnkAAoJELSic+t+oim9kHYP/imA0I4j8fbyKT/Qf/JPv0r8
iFvEG/+OxmB/2Dzo14q1T2nRT3z4/w9P1O0FlqryhKXHTV8ofBxNf2kgDZE/3dvg
onybqN2+PjtawXQACAdfrFh7YhDq14CJvobVtckHv0cVOVXdOZoEuJLSdqnJHmso
LhqOGOATZzQoJRjDfN9YJrEcNML2nMK/r4GJUY7r+IG7JpNt3FrmFP9QSdDl7XkI
wp+AFTvHKdfsMbtFZLFjMSJO++tXMlfdJ2vLozv6LJa6WR1zr9AcGLrAv9unNXpt
7BkCqLBPDE+MWgzXMusAMCgC5NIjdyUQJ9cMgBsIh0BXgSsueDrqQmHL9/AG0F5j
lt7a33AQ6PqeUlqgDsR4qWwDjn7iSC+SbUZatwrZgO+L64lQyfhak2Q9uCfAs223
NA0HsnsloC5E7mJ040mx17iG0EjVl7Ptm2/pwcTh3QSEd2Jo6gMi+3hwkWi63p2z
+0Je3qmJcoW+F1oMIH6g7r0IrUug7NhEbfnhFMx2Lz6DXEuHEbSUSh6LDAVZrJbQ
8RygseU8kH1iN44tb1C2A1i/5wiDZokgd7LeRQSfl3c4XJaH62QYZ26Pn8vAzYRw
1vh9wkvCA983eSSprez73h5MTmAocNOW84PiOcrSCnR267iGLFqhJdmL4g109Gmz
AuBXFqbIfPGfYdG5E2Nb
=e68o
-----END PGP SIGNATURE-----

--Sl8vrUT7HIMjHPiu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
