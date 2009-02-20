From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Fri, 20 Feb 2009 15:58:03 +0100
Message-ID: <20090220145803.GB9203@pengutronix.de>
References: <20090220144126.GA9203@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7534066232567038081=="
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090220144126.GA9203-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============7534066232567038081==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Me again,

here is an example patch what I needed to do in order to switch from the
old FSL-driver to this one. Hope it helps.

---
 arch/arm/mach-mx2/devices.c     |    6 +++---
 arch/arm/mach-mx2/pcm038.c      |    7 ++++---
 drivers/mxc/pmic/Kconfig        |    2 +-
 drivers/mxc/pmic/core/mc13783.c |    2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

Index: arch/arm/mach-mx2/devices.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-mx2/devices.c.orig
+++ arch/arm/mach-mx2/devices.c
@@ -143,14 +143,14 @@ static struct resource mxc_spi_resources
 #endif
=20
 struct platform_device mxc_spi_device0 =3D {
-	.name =3D "mxc_spi",
+	.name =3D "spi_imx",
 	.id =3D 0,
 	.num_resources =3D ARRAY_SIZE(mxc_spi_resources0),
 	.resource =3D mxc_spi_resources0,
 };
=20
 struct platform_device mxc_spi_device1 =3D {
-	.name =3D "mxc_spi",
+	.name =3D "spi_imx",
 	.id =3D 1,
 	.num_resources =3D ARRAY_SIZE(mxc_spi_resources1),
 	.resource =3D mxc_spi_resources1,
@@ -158,7 +158,7 @@ struct platform_device mxc_spi_device1 =3D
=20
 #ifdef CONFIG_MACH_MX27
 struct platform_device mxc_spi_device2 =3D {
-	.name =3D "mxc_spi",
+	.name =3D "spi_imx",
 	.id =3D 2,
 	.num_resources =3D ARRAY_SIZE(mxc_spi_resources2),
 	.resource =3D mxc_spi_resources2,
Index: arch/arm/mach-mx2/pcm038.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/arm/mach-mx2/pcm038.c.orig
+++ arch/arm/mach-mx2/pcm038.c
@@ -37,7 +37,8 @@
 #include <mach/iomux-mx1-mx2.h>
 #include <mach/gpio.h>
 #include <mach/i2c.h>
-#include <mach/imx_spi.h>
+//#include <mach/imx_spi.h>
+#include <mach/spi_imx.h>
 #include <mach/imx-uart.h>
 #include <mach/imx_ssi.h>
 #include <mach/pmic/platform.h>
@@ -178,8 +179,8 @@ static int gpio_spi_inactive_0(struct pl
 	return 0;
 }
=20
-static struct mxc_spi_master pcm038_spi_0_data =3D {
-	.maxchipselect =3D 4,	/* FIXME */
+static struct spi_imx_master pcm038_spi_0_data =3D {
+	.num_chipselect =3D 4,	/* FIXME */
 	.init =3D gpio_spi_active_0,
 	.exit =3D gpio_spi_inactive_0,
 };
Index: drivers/mxc/pmic/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/mxc/pmic/Kconfig.orig
+++ drivers/mxc/pmic/Kconfig
@@ -6,7 +6,7 @@ menu "MXC PMIC support"
=20
 config MXC_SPI_PMIC_CORE
 	tristate "PMIC Protocol support (SPI interface)"
-	depends on ARCH_MX2 && SPI_MXC
+	depends on ARCH_MX2 && (SPI_MXC || SPI_IMX)
 	default n
 	help
       	  This is the PMIC core/protocol driver for the Freescale MXC appli=
cation.
Index: drivers/mxc/pmic/core/mc13783.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/mxc/pmic/core/mc13783.c.orig
+++ drivers/mxc/pmic/core/mc13783.c
@@ -117,7 +117,7 @@ int pmic_spi_setup(struct spi_device *sp
 	/* Setup the SPI slave i.e.PMIC */
 	pmic_drv_data.spi =3D spi;
=20
-	spi->mode =3D SPI_MODE_2 | SPI_CS_HIGH;
+	spi->mode =3D SPI_MODE_0 | SPI_CS_HIGH;
 	spi->bits_per_word =3D 32;
=20
 	return spi_setup(spi);

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmexPsACgkQD27XaX1/VRugKACgyOU1Q3d7VYcsCj1w2MzntSl5
zP4AnimNtsXe7s1pLKDVVawWd9zVHaGb
=nFo3
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--


--===============7534066232567038081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
--===============7534066232567038081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============7534066232567038081==--
