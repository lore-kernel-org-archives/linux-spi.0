From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v5 4/6] spi: bcm2835: new driver implementing auxiliar spi1/spi2 on the bcm2835 soc
Date: Tue, 08 Sep 2015 19:20:15 -0700
Message-ID: <87fv2o1ggw.fsf@eliezer.anholt.net>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org> <1441359711-2800-5-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Martin Sperl <kernel@martin.sperl.org>
To: kernel@martin.sperl.org, Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441359711-2800-5-git-send-email-kernel@martin.sperl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

kernel@martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Implements spi master driver for the 2 auxiliar spi devices
> supported by the bcm2835 SOC.
>
> The driver does not implement native chip-selects but uses
> framework provided aribtrary GPIO-chip-selects.
>
> Requires soc-bcm2835-aux enable api to enable/disable HW blocks.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/spi/Kconfig          |   12 +
>  drivers/spi/Makefile         |    1 +
>  drivers/spi/spi-bcm2835aux.c |  514 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 527 insertions(+)
>  create mode 100644 drivers/spi/spi-bcm2835aux.c
>
> Changelog:
> 	v4->v5: added error-handling and deferred probing support
> 		moved change to default-config to a separate patch
> 		fixed Kconfig to add the correct dependency

Review comments as a diff, so you can git-am and squash them in if you
like.  If you take them all, you can add "Acked-by: Eric Anholt
<eric@anholt.net>".

I didn't know anything about SPI before tonight, but I've looked through
what you did and it looks solid when compared to the hardware docs I've
got.  The only functional comment I had that's not in my diff is that
you could probably reduce the transfer overhead by knowing that there
are 4 dwords in the transfer and receive FIFOs, so I think you could
write more before checking if you had to stop.

From=20e082c3b5ea32d3eb1a40b7f9b5a822ba307cf886 Mon Sep 17 00:00:00 2001
From: Eric Anholt <eric@anholt.net>
Date: Tue, 8 Sep 2015 17:51:08 -0700
Subject: [PATCH] spi: Changes for Martin's aux spi driver.

The intention is for these to be review fixes squashed into his commit of t=
he driver.

=2D Reset has to happen before the clock gate is disabled, since
  register writes wouldn't take effect.

=2D Typo fixes.

=2D Dropped unnecessary regs/defines.

=2D Dropped custom clock enable/disable, assuming we use the aux clock
  driver instead.

Signed-off-by: Eric Anholt <eric@anholt.net>
=2D--
 drivers/spi/Kconfig          |  5 ++---
 drivers/spi/spi-bcm2835aux.c | 45 ++++++----------------------------------=
----
 2 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cdb3dba..20854d4 100644
=2D-- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -89,16 +89,15 @@ config SPI_BCM2835
 	  not supported.
=20
 config SPI_BCM2835AUX
=2D	tristate "BCM2835 SPI auxiliar controller"
+	tristate "BCM2835 SPI auxiliary controller"
 	depends on ARCH_BCM2835 || COMPILE_TEST
 	depends on GPIOLIB
=2D	select SOC_BCM2835_AUX
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI aux master.
=20
 	  The BCM2835 contains two types of SPI master controller; the
 	  "universal SPI master", and the regular SPI controller.
=2D	  This driver is for the universal/auxiliar SPI controller.
+	  This driver is for the universal/auxiliary SPI controller.
=20
 config SPI_BFIN5XX
 	tristate "SPI controller driver for ADI Blackfin5xx"
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index d968647..3451ecb 100644
=2D-- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -1,5 +1,5 @@
 /*
=2D * Driver for Broadcom BCM2835 SPI Controllers
+ * Driver for Broadcom BCM2835 auxiliary SPI Controllers
  *
  * the driver does not rely on the native chipselects at all
  * but only uses the gpio type chipselects
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
=2D#include <linux/soc/bcm/bcm2835-aux.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -38,27 +37,10 @@
 #include <linux/spinlock.h>
=20
 /*
=2D * shared aux registers between spi1/spi2 and uart1
=2D *
=2D * these defines could go to a separate module if needed
=2D * so that it can also get used with the uart1 implementation
=2D * when it materializes.
=2D */
=2D
=2D/* the AUX register offsets */
=2D#define BCM2835_AUX_IRQ		0x00
=2D#define BCM2835_AUX_ENABLE	0x04
=2D
=2D/* the AUX Bitfield identical for both register */
=2D#define BCM2835_AUX_BIT_UART	0x00000001
=2D#define BCM2835_AUX_BIT_SPI1	0x00000002
=2D#define BCM2835_AUX_BIT_SPI2	0x00000004
=2D
=2D/*
  * spi register defines
  *
  * note there is garbage in the "official" documentation,
=2D * so somedata taken from the file:
+ * so some data is taken from the file:
  *   brcm_usrlib/dag/vmcsx/vcinclude/bcm2708_chip/aux_io.h
  * inside of:
  *   http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graph=
ics_Stack.tar.gz
@@ -113,9 +95,6 @@
 #define BCM2835_AUX_SPI_MODE_BITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				  | SPI_NO_CS)
=20
=2D#define DRV_NAME	"spi-bcm2835aux"
=2D#define ENABLE_PROPERTY "brcm,aux-enable"
=2D
 struct bcm2835aux_spi {
 	void __iomem *regs;
 	struct clk *clk;
@@ -450,26 +429,17 @@ static int bcm2835aux_spi_probe(struct platform_devic=
e *pdev)
 		goto out_clk_disable;
 	}
=20
=2D	/* enable HW block */
=2D	err =3D bcm2835aux_enable(&pdev->dev, ENABLE_PROPERTY);
=2D	if (err) {
=2D		dev_err(&pdev->dev, "could not enable aux: %d\n", err);
=2D		goto out_clk_disable;
=2D	}
=2D
 	/* reset SPI-HW block */
 	bcm2835aux_spi_reset_hw(bs);
=20
 	err =3D devm_spi_register_master(&pdev->dev, master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
=2D		goto out_hw_disable;
+		goto out_clk_disable;
 	}
=20
 	return 0;
=20
=2Dout_hw_disable:
=2D	bcm2835aux_disable(&pdev->dev, ENABLE_PROPERTY);
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
 out_master_put:
@@ -482,13 +452,10 @@ static int bcm2835aux_spi_remove(struct platform_devi=
ce *pdev)
 	struct spi_master *master =3D platform_get_drvdata(pdev);
 	struct bcm2835aux_spi *bs =3D spi_master_get_devdata(master);
=20
=2D	/* Clear FIFOs, and disable the HW block */
=2D	clk_disable_unprepare(bs->clk);
=2D
 	bcm2835aux_spi_reset_hw(bs);
=20
=2D	/* disable HW block */
=2D	bcm2835aux_disable(&pdev->dev, ENABLE_PROPERTY);
+	/* Clear FIFOs, and disable the HW block */
+	clk_disable_unprepare(bs->clk);
=20
 	return 0;
 }
@@ -501,7 +468,7 @@ MODULE_DEVICE_TABLE(of, bcm2835aux_spi_match);
=20
 static struct platform_driver bcm2835aux_spi_driver =3D {
 	.driver		=3D {
=2D		.name		=3D DRV_NAME,
+		.name		=3D "spi-bcm2835aux",
 		.of_match_table	=3D bcm2835aux_spi_match,
 	},
 	.probe		=3D bcm2835aux_spi_probe,
=2D-=20
2.1.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV75dfAAoJELXWKTbR/J7oqQsP/ROhEuFjOkjxInAAc/B5SqS4
PFvcfLnSIOf7Kxnm7iUd65ar5HwqqkDhnfBOkaqHdGmVRwjSeEUBcZe0cjGjYUgv
tjDYAjqr6OOIGQ0WDbEfn1SmHhMS3O/D9alv119IJ41tmnrhxS0MvO+geaNga5+4
6BHFWZ1Hh6yeHPb/za6oqiE2ZtNJXDKK/PEcmItJdzhg6DQEWFlGX9XCkkljeD8U
/0i8OGpqWc3Nm6yfrVW2QLY5oEfrbIqu6od2oOdbG/MzxI8VNgOT+1PTpPoUepYv
FIGjhFW2uRRlDR+2PWy34sLSwu4lbvL8g7xXR4L/jj+4/pQirGSw8GFYjgIPQM9W
Mh4FkuN2SxewsI+reayyHSdYEb4UM3Be+gQym/nG+MUDFi8XC0VbEnjo4fHQbVp5
tlWTWSqgj/0PcW5DqELA9DyjKheQqY+DOh2kmBBKW2qFAgAFOtjJFf9gH90bcZ5Z
djnn4gGCv81Il5RdPPj6CVGRYjSQOeGlZkVNG6DfqwLGAyQIjigajIFN0RsxhKYI
LckH8K9fJWxGhIiEmajhwOJrD1D1Joj+unNmo+TmweGNOpKVWwyOw7s6H+EhhvCA
3r2C9k3KY+e8fLsmeNuNC1ltpefCUMD8nZox40NUCFjCJvo0+LtIT65CwGEKSObo
x6xP3jH0Av5VUdI6eo/M
=3c8N
-----END PGP SIGNATURE-----
--=-=-=--
