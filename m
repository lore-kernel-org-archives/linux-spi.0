From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] spi: spi-fsl-spi: support use of the SPISEL_BOOT signal on
 MPC8309
Date: Wed, 6 Mar 2019 10:32:05 +0000
Message-ID: <20190306103156.19897-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Esben Haabendal <esben@geanix.com>,
        Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The MPC8309 has a dedicated signal, SPISEL_BOOT, usually used as chip
select for the flash device from which the bootloader is loaded. It is
not an ordinary gpio, but is simply controlled via the SPI_CS register
in the system configuration.

To allow accessing such a spi slave, we need to teach
fsl_spi_cs_control() how to control the SPISEL_BOOT signal. To
distinguish the gpio-controlled slaves, continue to have those use
chip_select values of 0..ngpios-1, and use chip_select =3D=3D ngpios for
the boot flash.

I'm not too happy with all the ifdeffery, but it seems to be necessary
for guarding the sysdev/fsl_soc.h and use of
get_immrbase() (spi-fsl-lib.c already contains similar ifdeffery).

Googling suggests that the MPC8306 is similar, with the SPI_CS
register at the same offset.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 .../devicetree/bindings/spi/fsl-spi.txt       |  4 ++
 drivers/spi/spi-fsl-lib.h                     |  2 +
 drivers/spi/spi-fsl-spi.c                     | 40 ++++++++++++++++---
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentat=
ion/devicetree/bindings/spi/fsl-spi.txt
index 8854004a1d3a..411375eac54d 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -18,6 +18,10 @@ Optional properties:
 - gpios : specifies the gpio pins to be used for chipselects.
   The gpios will be referred to as reg =3D <index> in the SPI child nodes.
   If unspecified, a single SPI device without a chip select can be used.
+- fsl,spisel_boot : for the MPC8306 and MPC8309, specifies that the
+  SPISEL_BOOT signal is used as chip select for a slave device. Use
+  reg =3D <number of gpios> in the corresponding child node, i.e. 0 if
+  the gpios property is not present.
=20
 Example:
 	spi@4c0 {
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index f303f306b38e..483734bc1b1e 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -95,8 +95,10 @@ static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *r=
eg)
=20
 struct mpc8xxx_spi_probe_info {
 	struct fsl_spi_platform_data pdata;
+	int ngpios;
 	int *gpios;
 	bool *alow_flags;
+	__be32 __iomem *immr_spi_cs;
 };
=20
 extern u32 mpc8xxx_spi_tx_buf_u8(struct mpc8xxx_spi *mpc8xxx_spi);
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8f2e97857e8b..3d7b50c65f36 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -39,6 +39,14 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
=20
+#ifdef CONFIG_FSL_SOC
+#include <sysdev/fsl_soc.h>
+#endif
+
+/* Specific to the MPC8306/MPC8309 */
+#define IMMR_SPI_CS_OFFSET 0x14c
+#define SPI_BOOT_SEL_BIT   0x80000000
+
 #include "spi-fsl-lib.h"
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-spi.h"
@@ -701,10 +709,17 @@ static void fsl_spi_cs_control(struct spi_device *spi=
, bool on)
 	struct fsl_spi_platform_data *pdata =3D dev_get_platdata(dev);
 	struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(pdata);
 	u16 cs =3D spi->chip_select;
-	int gpio =3D pinfo->gpios[cs];
-	bool alow =3D pinfo->alow_flags[cs];
=20
-	gpio_set_value(gpio, on ^ alow);
+	if (cs < pinfo->ngpios) {
+		int gpio =3D pinfo->gpios[cs];
+		bool alow =3D pinfo->alow_flags[cs];
+
+		gpio_set_value(gpio, on ^ alow);
+	} else {
+		if (WARN_ON_ONCE(cs > pinfo->ngpios || !pinfo->immr_spi_cs))
+			return;
+		iowrite32be(on ? SPI_BOOT_SEL_BIT : 0, pinfo->immr_spi_cs);
+	}
 }
=20
 static int of_fsl_spi_get_chipselects(struct device *dev)
@@ -712,12 +727,15 @@ static int of_fsl_spi_get_chipselects(struct device *=
dev)
 	struct device_node *np =3D dev->of_node;
 	struct fsl_spi_platform_data *pdata =3D dev_get_platdata(dev);
 	struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(pdata);
+	bool spisel_boot =3D IS_ENABLED(CONFIG_FSL_SOC) &&
+		of_property_read_bool(np, "fsl,spisel_boot");
 	int ngpios;
 	int i =3D 0;
 	int ret;
=20
 	ngpios =3D of_gpio_count(np);
-	if (ngpios <=3D 0) {
+	ngpios =3D max(ngpios, 0);
+	if (ngpios =3D=3D 0 && !spisel_boot) {
 		/*
 		 * SPI w/o chip-select line. One SPI device is still permitted
 		 * though.
@@ -726,6 +744,7 @@ static int of_fsl_spi_get_chipselects(struct device *de=
v)
 		return 0;
 	}
=20
+	pinfo->ngpios =3D ngpios;
 	pinfo->gpios =3D kmalloc_array(ngpios, sizeof(*pinfo->gpios),
 				     GFP_KERNEL);
 	if (!pinfo->gpios)
@@ -769,7 +788,18 @@ static int of_fsl_spi_get_chipselects(struct device *d=
ev)
 		}
 	}
=20
-	pdata->max_chipselect =3D ngpios;
+#if IS_ENABLED(CONFIG_FSL_SOC)
+	if (spisel_boot) {
+		pinfo->immr_spi_cs =3D ioremap(get_immrbase() + IMMR_SPI_CS_OFFSET, 4);
+		if (!pinfo->immr_spi_cs) {
+			ret =3D -ENOMEM;
+			i =3D ngpios - 1;
+			goto err_loop;
+		}
+	}
+#endif
+
+	pdata->max_chipselect =3D ngpios + spisel_boot;
 	pdata->cs_control =3D fsl_spi_cs_control;
=20
 	return 0;
--=20
2.20.1
