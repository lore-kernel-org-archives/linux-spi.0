From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 10:19:02 -0700
Message-ID: <20131030171902.GL2493@sirena.org.uk>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
 <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
 <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
 <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
 <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <02BFF0F6-3836-4DEC-AA53-FF100E037DE9-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 09:40:21AM +0100, Martin Sperl wrote:

> Maybe one more argument for the spi_prepare_message interface:

Did you see my replies yesterday - I mentioned that we already have this
interface in mainline?

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScT99AAoJELSic+t+oim9jxcP/2H4SawVBkTxDaUA57+wkbkL
JXu5CXxgb3ob016rj91eAdKTNE2OSrfYH87qb02hclupHslvYs/1AULw6N4SBJYE
hLJ9PBU+PCjSlI2KUNv50mxv5soyqXAXLzErbkNPyAqlv4uCJi2gDjW/dcB9ezfa
+/fl0fra3ZllOjPAziiqTvNGuUYZXT1A+RhkedmZnueV81295yAug6h5VAeUy6tj
MOQGnEJ3se4vRXRrNY+mqrtN4C1LE0TjXGPtjNq+YdOu3y+m8j9QrBb+IT4RDVYL
7sYNJMP22EM84w9Qs1X3e4FUhVKvzIXIwh9nghYYq9hEfqqpM91dJiWwET2r7jZs
tGbgyLIxCBupJLWnGdqcdn/4tNGCEdEMIG4/HZJVV6/x/rz5Pn0BFS6iXBWhhkRh
Ex3LdTCSnxguPrd8whONeej9orgX0E/QDuKSRcVuavKl9SLktcfG0b1mWWrl8nQr
CccDv4xvVt2y9mLFbxMsvnXusUtRjwMMPCwR4gP/dJRRbdQ06+Qa+TsAGf9Xlv0/
G+1pFgI5uAp8XZ2iE4Z7ND4HRQDBsk6utSSFT0jlNmkmUDSqS/JvIkOSDEIPw/Ep
sDl8xdzOL1Tf9JulYjjAZUnnj6D5ILb1aIxrHajvpB1CoVfnYe8SZAdiMFs6fUlk
u9TV0fYPzvxso5T6b3Rh
=XiOW
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
