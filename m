From: "kernelci.org bot" <bot@kernelci.org>
Subject: broonie-spi/for-next boot bisection: v5.4-rc3-73-gc673f2d99c3d on
 jetson-tk1
Date: Fri, 18 Oct 2019 23:24:13 -0700 (PDT)
Message-ID: <5daaac0d.1c69fb81.12761.2a24@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, tomeu.vizoso@collabora.com,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

broonie-spi/for-next boot bisection: v5.4-rc3-73-gc673f2d99c3d on jetson-tk1

Summary:
  Start:      c673f2d99c3d Merge remote-tracking branch 'spi/topic/ptp' int=
o spi-next
  Details:    https://kernelci.org/boot/id/5daa485f59b5142f647525a0
  Plain log:  https://storage.kernelci.org//broonie-spi/for-next/v5.4-rc3-7=
3-gc673f2d99c3d/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/b=
oot-tegra124-jetson-tk1.txt
  HTML log:   https://storage.kernelci.org//broonie-spi/for-next/v5.4-rc3-7=
3-gc673f2d99c3d/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/b=
oot-tegra124-jetson-tk1.html
  Result:     3e5ec1db8bfe spi: Fix SPI_CS_HIGH setting when using native a=
nd GPIO CS

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       broonie-spi
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.g=
it
  Branch:     for-next
  Target:     jetson-tk1
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     multi_v7_defconfig+CONFIG_SMP=3Dn
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 3e5ec1db8bfee845d9f8560d1c64aeaccd586398
Author: Gregory CLEMENT <gregory.clement@bootlin.com>
Date:   Fri Oct 18 17:29:29 2019 +0200

    spi: Fix SPI_CS_HIGH setting when using native and GPIO CS
    =

    When improving the CS GPIO support at core level, the SPI_CS_HIGH
    has been enabled for all the CS lines used for a given SPI controller.
    =

    However, the SPI framework allows to have on the same controller native
    CS and GPIO CS. The native CS may not support the SPI_CS_HIGH, so they
    should not be setup automatically.
    =

    With this patch the setting is done only for the CS that will use a
    GPIO as CS
    =

    Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs=
")
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
    Link: https://lore.kernel.org/r/20191018152929.3287-1-gregory.clement@b=
ootlin.com
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f8b4654a57d3..d07517151340 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1711,15 +1711,7 @@ static int of_spi_parse_dt(struct spi_controller *ct=
lr, struct spi_device *spi,
 		spi->mode |=3D SPI_3WIRE;
 	if (of_property_read_bool(nc, "spi-lsb-first"))
 		spi->mode |=3D SPI_LSB_FIRST;
-
-	/*
-	 * For descriptors associated with the device, polarity inversion is
-	 * handled in the gpiolib, so all chip selects are "active high" in
-	 * the logical sense, the gpiolib will invert the line if need be.
-	 */
-	if (ctlr->use_gpio_descriptors)
-		spi->mode |=3D SPI_CS_HIGH;
-	else if (of_property_read_bool(nc, "spi-cs-high"))
+	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |=3D SPI_CS_HIGH;
 =

 	/* Device DUAL/QUAD mode */
@@ -1783,6 +1775,14 @@ static int of_spi_parse_dt(struct spi_controller *ct=
lr, struct spi_device *spi,
 	}
 	spi->chip_select =3D value;
 =

+	/*
+	 * For descriptors associated with the device, polarity inversion is
+	 * handled in the gpiolib, so all gpio chip selects are "active high"
+	 * in the logical sense, the gpiolib will invert the line if need be.
+	 */
+	if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods[spi->chip_select])
+		spi->mode |=3D SPI_CS_HIGH;
+
 	/* Device speed */
 	rc =3D of_property_read_u32(nc, "spi-max-frequency", &value);
 	if (rc) {
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [4f5cafb5cb8471e54afdc9054d973535614f7675] Linux 5.4-rc3
git bisect good 4f5cafb5cb8471e54afdc9054d973535614f7675
# bad: [c673f2d99c3d644733cc1b0ceabdec47047bbe80] Merge remote-tracking bra=
nch 'spi/topic/ptp' into spi-next
git bisect bad c673f2d99c3d644733cc1b0ceabdec47047bbe80
# good: [b2c98153f45fc17b9fcb241000f2d131ddea6030] spi: introduce spi_delay=
 struct as "value + unit" & spi_delay_exec()
git bisect good b2c98153f45fc17b9fcb241000f2d131ddea6030
# good: [4f3d957718e7f0ac2b033dbf48c7cddecd0a8dd3] spi: pxa2xx: No need to =
keep pointer to platform device
git bisect good 4f3d957718e7f0ac2b033dbf48c7cddecd0a8dd3
# good: [1cb84b02bf130f34ee81f99bc7dee5bca2943ed7] spi: atmel: Remove platf=
orm data support
git bisect good 1cb84b02bf130f34ee81f99bc7dee5bca2943ed7
# bad: [fed8d8c7a6dc2a76d7764842853d81c770b0788e] spi: atmel: fix handling =
of cs_change set on non-last xfer
git bisect bad fed8d8c7a6dc2a76d7764842853d81c770b0788e
# bad: [3e5ec1db8bfee845d9f8560d1c64aeaccd586398] spi: Fix SPI_CS_HIGH sett=
ing when using native and GPIO CS
git bisect bad 3e5ec1db8bfee845d9f8560d1c64aeaccd586398
# good: [b2662a164f9dc48da8822e56600686d639056282] spi: pxa2xx: Set control=
ler->max_transfer_size in dma mode
git bisect good b2662a164f9dc48da8822e56600686d639056282
# first bad commit: [3e5ec1db8bfee845d9f8560d1c64aeaccd586398] spi: Fix SPI=
_CS_HIGH setting when using native and GPIO CS
---------------------------------------------------------------------------=
----
