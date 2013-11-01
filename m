From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 0/3] I2C and SPI dev_name change for ACPI enumerated
 slaves
Date: Fri, 1 Nov 2013 14:20:48 +0100
Message-ID: <20131101132048.GD6734@katana>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1601125.4tFOPicoTX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1601125.4tFOPicoTX-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2013 at 02:18:06PM +0100, Rafael J. Wysocki wrote:
> On Friday, November 01, 2013 02:35:53 PM Jarkko Nikula wrote:
> > Hi
> >=20
> > Second version of the set that changes I2C and SPI slave device names
> > to be generated from stable ACPI device names on ACPI 5 based systems
> > instead of using bus numbers which could change.
> >=20
> > Slave device name change goes as
> >=20
> > 	"x-00yz" -> "i2c-INTABCD:ij"
> > 	"spix.y" -> "spi-INTABCD:ij"
> >=20
> > This version adds patch to include/acpi/acpi_bus.h that allow us to
> > remove #if IS_ENABLED(CONFIG_ACPI) checks that were added in the
> > first version.
> >=20
> > Set goes on top linux-pm/linux-next commit e56b4d2.
> >=20
> > First version here:
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/06773=
7.html
> >=20
> > Jarkko Nikula (3):
> >   ACPI: Expose struct acpi_device and acpi_bus_get_device() to non-ACPI
> >     builds
> >   i2c: Use stable dev_name for ACPI enumerated I2C slaves
> >   spi: Use stable dev_name for ACPI enumerated SPI slaves
> >=20
> >  drivers/i2c/i2c-core.c  | 24 ++++++++++++++++++++----
> >  drivers/spi/spi.c       | 20 +++++++++++++++++---
> >  include/acpi/acpi_bus.h |  9 +++++++--
> >  3 files changed, 44 insertions(+), 9 deletions(-)
>=20
> Looks good to me.  If there are no objections, I can merge these through =
my tree.

Which is basically fine with me. Do you want to have it in 3.13 already?
I mean renaming the devices could lead to regressions, so I'd rather be
conservative and aim for 3.14.


--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSc6qvAAoJEBQN5MwUoCm2HFQP/0uLnvgKp9uYEBWNhNOh9FvQ
DBvMlyIgbspPgZIax+P3DR3+qPwR8F3OjeCEYnMH1Gjd+6bc/RG91tmzgU4bO323
6Ylkn9NoSfHRjlzw/+LxQ7doe9MB1kLmypPBLyBsRpgcmPlDdtob13SbGYe7Iv8/
XPCdpyTSkQjWgQyQwmgAvJjigMBFdMNcoWnGZzD/zR8D93hRrlFJBC2OGuTRfWT3
c8BdOy0ZDnR/yKHT9qsteZU+x0wQsPqQcUJ86NRc1qJa94sQiPthEgRY87LFITpT
WbYYuyhpMlo8z3vQ9Dtp0SI7E1DKAZgHQ0pOAl79WNY0LAN0lSsbb/yzkNTuxJEn
bkpOmnc6d0NIptlu53+pqw24PZG5PQmxhrCzuCotdvPqNlwyWKL/mVkm4plMlxyx
XKSyY8N8L4Snt1mzmiJd3o7NSTHw2EZ9pNYhEEF3xQP2j3Tn2ISrXfyKXi/F1IXF
+mqM+8Nwzqv68QboWARiJl8BU+c+0HI/Dr2e10p+b6R1nejzjaz659LzRFaEX9eb
DIIW0TL6PyFRT+ysXWWYr/4EYQF+TI3esXdVzPxN5TbZALhbOPw3FASaXsn9uAMD
7VSYNk51waOMtqIXVahBYHbWSNNPS/tFVERmo1G+d2VRlTp/27PYcXNc18umXTdk
6fZQL7Qj+cBPTm7tMkhf
=+71p
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
