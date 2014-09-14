From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean up
 chip identification
Date: Sun, 14 Sep 2014 18:10:24 +0100
Message-ID: <1410714624.3040.38.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WyED6Tz+auDGCieAXHHx"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-WyED6Tz+auDGCieAXHHx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The first patch in the series restores the module aliases to m25p80, but
it does so by duplicating the list of names.  This should be suitable
for stable, but it isn't viable in the longer term.

The following patches change the spi-nor interface so that this
duplication is no longer necessary.  This includes removing
spi_nor::read_id, but it could be re-added after this with a different
interface, e.g. returning a flash_info structure (which would need to be
defined in spi_nor.h).

Ben.

Ben Hutchings (5):
  m25p80,spi-nor: Fix module aliases for m25p80
  spi-nor: Remove spi_nor::read_id operation
  spi-nor: Make spi_nor_scan() take a chip type name, not an
    spi_device_id
  spi-nor: Replace struct spi_device_id with struct flash_info
  m25p80,spi-nor: Share the list of supported chip type names again

 drivers/mtd/devices/m25p80.c      |  13 +-
 drivers/mtd/spi-nor/fsl-quadspi.c |   7 +-
 drivers/mtd/spi-nor/spi-nor.c     | 383 +++++++++++++++++++---------------=
----
 include/linux/mtd/spi-nor.h       |  87 +++++++--
 4 files changed, 279 insertions(+), 211 deletions(-)


--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-WyED6Tz+auDGCieAXHHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVBXMB+e/yOyVhhEJAQr8IBAAthtsIxne5LGnVF5d7wdXYL8GDsM4GuqS
0b5WQ/YK9zXm9mwPqu0kBi4cRTR2mglnTXzJ07GVR7bKkWlPTYq7r0NvS+chX0oO
GzKMHwz2KYBxGik7gQKRYiKdJkx1s83/c64TiY8YwJmi62xi2nrZvJRFML900SCU
0SQDF0KtIVQVJbjd0esgT/tf3peWiHDrZfW76selhbTMcNWILaut0HgJNfopKJrZ
ujN5ngWNwmOhN170TLP/gjGWVmtujyTN/groeEYr4htOeOAMzUmLIRjtPgO+OQda
w+6nJ9Dq16Q7gnFXsnsv3L3kC9vDe7rAi/ILxL8ys/cM6QCcFTLfoqEYK+iEfEO4
muVEa9WEURk1duQDq2PPhc1AL4ejoLxJgKBI00VWfEI4gbIS3LOdU6oQ+Ynl/WnK
M0Q5iXEdbypf6W/GiJ8M7cgx32ukVsnNI/RanKI2LnrKsq+NA03wiGBeg3cjpNEc
5WeYouI8S0r2nPvfK5qIEo3nff9eK8XLcsTmb2N79feRBDpEh0scF7atSewNm9t6
6+uX8+YIZEPZ4Dz9c0/r4uS1LpRCdj/jwPRHADPyfATfgaEomkNbouWGPEAkwA1+
DH/gqoccOSR4S/Y0ACGS859/+q/grM4QWlAFcQTae9nkvQw8fjmoBdJfh6gQ8rZm
9dR2fbU6438=
=SdVx
-----END PGP SIGNATURE-----

--=-WyED6Tz+auDGCieAXHHx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
