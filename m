From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Support of Micron SPI flash (size > 16MB)
Date: Fri, 9 May 2014 11:44:04 +0100
Message-ID: <20140509104404.GK12304@sirena.org.uk>
References: <92977332ffca4669b5c1987b42b0d0c5@BY2PR03MB508.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y7PtvmZky+k3cq9Z"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org"
	<vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
To: "Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <92977332ffca4669b5c1987b42b0d0c5-+7O3WWA3DPtW9KZzDT5qz+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y7PtvmZky+k3cq9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 10:25:04AM +0000, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:

> 2.       What are the changes needed for SPI controller to support 4 byte addressing?

If the SPI controller is a genuine SPI controller and not something
specially optimised for flash it shouldn't need any changes, it doesn't
know anything about the data it's sending.  The SPI flash code might
need updating though, I don't know about that.

--y7PtvmZky+k3cq9Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbLFxAAoJELSic+t+oim91JEQAJLsYx7L71POM4gLDr/LkbOP
hoERv6U3jlHjP+zmDim38ZBvy50XKxce+Lp8l5WmJkfKI9pfcnvmiIVx+eXiR4ri
UZIfvh3zllzudrBck82FrBdtxKscTa3j9WMWgXRWkEXAVZyLzkd4rkWfEl7JDfQi
qxSURxYdN83xn8bE48ExPps+LNCy84scid6l3GlghalNDWwLwx15t1CAbMoSEX7S
/KxdUBs8uBOV69Zy3xSdSxesj+uF9ifv1bD1Y9VKJ3Fhmh8IwUNEb1q1/Inq4DF4
VaDtUMZwDFxcyU3/D6cor1eIYfj7Jrz/jtTceSf7/vABOqgu/a6Nxyfn3ekeFKWE
qtQDHR3okhTxY3KSdrkOcBO2/KKcMFN8edcibf/7jlMuTAkJ0FdYX61d9gOKA7G5
NWWlfxOBT3gEJCnY8ui/M8KUD6FkZdZUU2iVZSGHhug0YkNfh4gy0Lh+cUk7/sff
D2MCbBZblXAJkGdjQf/3Rdi2qyzKveQdBCkwiOhZ3z2xS+P71y5LPAFfWYoZltYS
2IODuTZb38gBSUKaY/1nSKgqICXi04J4AYvSnoPAspzN6lPkqRAcYYxzf1iYNMTo
3lfIbIOwZ2nQ86yIsdVwp3gv0g5+2CLE5uT3Xm1w6bxi4MXOiQnSE0qdLAK7DSnE
HOr6kczm+xOD/aLg2ZTT
=tt1j
-----END PGP SIGNATURE-----

--y7PtvmZky+k3cq9Z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
