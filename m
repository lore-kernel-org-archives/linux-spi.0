From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/7] spi: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 12:03:41 -0700
Message-ID: <20140429190341.GK15125@sirena.org.uk>
References: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aziWXe2aaRGlkyg3"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002401cf6383$7e9ce1f0$7bd6a5d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aziWXe2aaRGlkyg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2014 at 05:17:43PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().

Applied all, thanks.

--aziWXe2aaRGlkyg3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX/eKAAoJELSic+t+oim9b6oP/1V+r7ESg+jVTcqgoZb+gyiv
EoS2mPC5RTpu0s8CtR+14kb4aP9kqWisPefJtCFsP5V+cu8BB5rhBpPLp5ChKhxc
TdxDjZbGWN814bJ/sQfKkXjq9xZ2qSIJizeQHIBTjSUQuEze8KKB13y8g3AnqIkJ
teDwX3GPtdFSF7as8fgfl2dm+BxbEFUE0nedzVhvTFLs4Ek6+X8T+EG42UXb75GI
ALQFYZ53zwquewX+/8ASDYmDN9eQtNMUUeIwzVmFsWsar8x8k7vVB/zWmc0uFaDG
LpI0RY2RCKOwuq1LgHRnx39FQZ90w3w4Dg2L5ygh16u78kYyUY9jr8GYkBVS2nmG
BcyXuvfDjgkTu5i/pbQkdZwthicPASj12dpFOjJX1WSoM2+foCNUfimnT/YZd+7p
Xdu9rzFtX8Ycbz5dnqLX6BT8rhK1N5X1/Kg3+ZaKTgXUAL7ywShR2Ea918RzMwxd
qJh5bDtxFNFWddgcjf35FZs+wzcUc3U0FB42qxg5dBNyPlhraiZ4fFy/Pe4JsKqb
TmIZdfq5W4sfBwtQrXnaLZS5bkDW+FZOOaxRaes0UrdoaF5fdqTL3Kgpq9Y8/jUb
Q/waIvlDsZqAWQsI46d4HSro+WjbKoiBzJ2aCiVDQgxJ3N0i8cqBB79iNZa+xR1y
r6eXcOxZ9RMvOkWplezA
=YmSf
-----END PGP SIGNATURE-----

--aziWXe2aaRGlkyg3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
