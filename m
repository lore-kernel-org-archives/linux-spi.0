From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: fsl-spi: use devm_ioremap_resource() to map
 parameter ram on CPM1
Date: Wed, 22 Apr 2015 20:46:55 +0100
Message-ID: <20150422194655.GJ22845@sirena.org.uk>
References: <20150422142820.4267B1A242E@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LkBseQZEL/3d2JPd"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150422142820.4267B1A242E-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LkBseQZEL/3d2JPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 04:28:20PM +0200, Christophe Leroy wrote:
> On CPM2, the SPI parameter RAM is dynamically allocated in the
> dualport RAM whereas in CPM1, it is statically allocated to a default
> address with capability to relocate it somewhere else via the use of
> CPM micropatch. The address of the parameter RAM is given by the boot
> loader and expected to be mapped via devm_ioremap_resource()

Applied, thanks.

--LkBseQZEL/3d2JPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/quAAoJECTWi3JdVIfQ0yQH/2DJ9S8GfJwPwo8ruC+0YONd
SroWJBoDjaXQs8IdvGag/sge4We8f4OAC8gSef3wS/IVp45IHiEH5wzRKiO52Mey
GObMbcLhwX3ASMF5h4wIIV7C4G5sSkam/9awUZghlUNV8m+3dhc1gBmpgYAIwldp
mDv53gkJLt7bC+0vYmIU2Iuyf7z0bEODVuICsuPEes5GRsWCwELnIQ0aOIOq5GAc
kAaV56UV69E2/eXeGpq7O4fcwENe0uDFgt7dzzQK8lXO0GYbTk/c8+nY1oCA2Hsk
pj18A+AsFnKbaNpSMvNB4B05mi9gAyZqaMR7KQfty9BJX0oM1f4iKW+g+wj8RwE=
=Yt/f
-----END PGP SIGNATURE-----

--LkBseQZEL/3d2JPd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
