From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/5] spi: dw-mmio: remove HAVE_CLK build dependecy
Date: Fri, 31 Jan 2014 16:46:09 +0000
Message-ID: <20140131164609.GP22609@sirena.org.uk>
References: <cover.1391162172.git.baruch@tkos.co.il>
 <207f4522cbabac73422b54006ead761f25380013.1391162172.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFzc/l08eq652zZ2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <207f4522cbabac73422b54006ead761f25380013.1391162172.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bFzc/l08eq652zZ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 12:07:48PM +0200, Baruch Siach wrote:
> Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
> like this platform driver needs not depend on HAVE_CLK.

Applied, thanks.

--bFzc/l08eq652zZ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS69NOAAoJELSic+t+oim9ybEP/38hyNe+toc/wG6ft3jB0bNM
gy0HOAEKoifs+KX5sK+S6jrHj8lNe6LGi9eA7pdXYzI1MbOhURIBR/ljaF3OxrZ6
P2ipmFMJalF49LgJB4MBge2isdwaMc7TMCALHoq0TLtzYCQ8MZlZIGGyILx6JnVh
80GmHC71y7XF3I2JE6x6qDThVwHTXQIxiKKur20z+I+FOXTe9tHmOFIxMXKr0ENN
57Wqdfm1Nyqz/ydKDZ0nT9sjI8mxUgwhj0R9De/lAKxS8Vw/gM9iecETJRggTFd1
pIS2ZVA6Zwl9ZNlNQtcRbl125oWTmELYA8Dxu6d3aQyyrBl9mRQlnu4zNjqnC55u
i3BTz5vBz5icdP4DArV4a/yroum1B60qtuPptoM1pINy9Ru+l8X7mbn+N2yFf/bu
FzEy6UPFh92lD/s0744dn53fanGNeABxVrQIThRx0C3ZicfTpD02Ck5dX+F3vbsE
t64EThUj4h7zBzm7q3nilH05wVagFN3sQCp1Vo+s2dVwe0vqWgKg+oqn+yi7n72/
RVdY3dj1Pqdz2WdZPPnmlG+J28NMed3pXxnr3B3GhKqKq/FSwH5KX9ELKX8aUICy
7D8IOY8OOWs0jNC5IHBEznN7x6qd8M7K29ZjlFq4xnQ0kMmswnkQMo6cQ1PwYOfx
5ptXDS6orG14LMDYH6X+
=5JX9
-----END PGP SIGNATURE-----

--bFzc/l08eq652zZ2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
