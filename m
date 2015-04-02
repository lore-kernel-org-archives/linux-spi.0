From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=203/4=5D=20spi=3A=20bcm-mspi=3A=20Make=20BCMA=20optional=20to=20support=20non-BCMA=20chips?=
Date: Thu, 2 Apr 2015 12:23:22 -0700
Message-ID: <1428002603-21892-4-git-send-email-jonathar@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428002603-21892-1-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Broadcom MSPI controller is used on various chips. The driver only
supported BCM53xx chips with BCMA (an AMBA bus variant). The driver is
refactored to make BCMA optional and provides a new config for non BCMA
systems.

Signed-off-by: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/Kconfig        |    5 ++
 drivers/spi/Makefile       |    1 +
 drivers/spi/spi-bcm-mspi.c |  200 +++++++++++++++++++++++++++++++++---=
--------
 3 files changed, 155 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 766e08d..23f2357 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -120,6 +120,11 @@ config SPI_BCMA_MSPI
 	help
 	  Enable support for the Broadcom BCMA MSPI controller.
=20
+config SPI_BCM_MSPI
+	tristate "Broadcom MSPI controller"
+	help
+	  Enable support for the Broadcom MSPI controller.
+
 config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
 	depends on BCM63XX
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6b58100..36872d2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_ATH79)			+=3D spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+=3D spi-au1550.o
 obj-$(CONFIG_SPI_BCM2835)		+=3D spi-bcm2835.o
 obj-$(CONFIG_SPI_BCMA_MSPI)		+=3D spi-bcm-mspi.o
+obj-$(CONFIG_SPI_BCM_MSPI)		+=3D spi-bcm-mspi.o
 obj-$(CONFIG_SPI_BCM63XX)		+=3D spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+=3D spi-bcm63xx-hsspi.o
 obj-$(CONFIG_SPI_BFIN5XX)		+=3D spi-bfin5xx.o
diff --git a/drivers/spi/spi-bcm-mspi.c b/drivers/spi/spi-bcm-mspi.c
index 67ea246..df27449 100644
--- a/drivers/spi/spi-bcm-mspi.c
+++ b/drivers/spi/spi-bcm-mspi.c
@@ -11,11 +11,13 @@
  * GNU General Public License for more details.
  */
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/bcma/bcma.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
=20
 #include "spi-bcm-mspi.h"
=20
@@ -25,22 +27,17 @@
 #define BCM_MSPI_SPE_TIMEOUT_MS 80
=20
 struct bcm_mspi {
+	#ifdef CONFIG_SPI_BCMA_MSPI
 	struct bcma_device *core;
-	struct spi_master *master;
+	#endif
=20
+	void __iomem *base;
+	struct spi_master *master;
 	size_t read_offset;
-};
=20
-static inline u32 bcm_mspi_read(struct bcm_mspi *mspi, u16 offset)
-{
-	return bcma_read32(mspi->core, offset);
-}
-
-static inline void bcm_mspi_write(struct bcm_mspi *mspi, u16 offset,
-				    u32 value)
-{
-	bcma_write32(mspi->core, offset, value);
-}
+	void (*mspi_write)(struct bcm_mspi *mspi, u16 offset, u32 value);
+	u32 (*mspi_read)(struct bcm_mspi *mspi, u16 offset);
+};
=20
 static inline unsigned int bcm_mspi_calc_timeout(size_t len)
 {
@@ -56,7 +53,7 @@ static int bcm_mspi_wait(struct bcm_mspi *mspi, unsig=
ned int timeout_ms)
 	/* SPE bit has to be 0 before we read MSPI STATUS */
 	deadline =3D jiffies + BCM_MSPI_SPE_TIMEOUT_MS * HZ / 1000;
 	do {
-		tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
+		tmp =3D mspi->mspi_read(mspi, MSPI_SPCR2);
 		if (!(tmp & MSPI_SPCR2_SPE))
 			break;
 		udelay(5);
@@ -68,9 +65,9 @@ static int bcm_mspi_wait(struct bcm_mspi *mspi, unsig=
ned int timeout_ms)
 	/* Check status */
 	deadline =3D jiffies + timeout_ms * HZ / 1000;
 	do {
-		tmp =3D bcm_mspi_read(mspi, MSPI_MSPI_STATUS);
+		tmp =3D mspi->mspi_read(mspi, MSPI_MSPI_STATUS);
 		if (tmp & MSPI_MSPI_STATUS_SPIF) {
-			bcm_mspi_write(mspi, MSPI_MSPI_STATUS, 0);
+			mspi->mspi_write(mspi, MSPI_MSPI_STATUS, 0);
 			return 0;
 		}
=20
@@ -79,7 +76,7 @@ static int bcm_mspi_wait(struct bcm_mspi *mspi, unsig=
ned int timeout_ms)
 	} while (!time_after_eq(jiffies, deadline));
=20
 spi_timeout:
-	bcm_mspi_write(mspi, MSPI_MSPI_STATUS, 0);
+	mspi->mspi_write(mspi, MSPI_MSPI_STATUS, 0);
=20
 	pr_err("Timeout waiting for SPI to be ready!\n");
=20
@@ -94,7 +91,7 @@ static void bcm_mspi_buf_write(struct bcm_mspi *mspi,=
 u8 *w_buf,
=20
 	for (i =3D 0; i < len; i++) {
 		/* Transmit Register File MSB */
-		bcm_mspi_write(mspi, MSPI_TXRAM + 4 * (i * 2),
+		mspi->mspi_write(mspi, MSPI_TXRAM + 4 * (i * 2),
 				 (unsigned int)w_buf[i]);
 	}
=20
@@ -104,28 +101,28 @@ static void bcm_mspi_buf_write(struct bcm_mspi *m=
spi, u8 *w_buf,
 			tmp &=3D ~CDRAM_CONT;
 		tmp &=3D ~0x1;
 		/* Command Register File */
-		bcm_mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
+		mspi->mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
 	}
=20
 	/* Set queue pointers */
-	bcm_mspi_write(mspi, MSPI_NEWQP, 0);
-	bcm_mspi_write(mspi, MSPI_ENDQP, len - 1);
+	mspi->mspi_write(mspi, MSPI_NEWQP, 0);
+	mspi->mspi_write(mspi, MSPI_ENDQP, len - 1);
=20
 	if (cont)
-		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 1);
+		mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 1);
=20
 	/* Start SPI transfer */
-	tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
+	tmp =3D mspi->mspi_read(mspi, MSPI_SPCR2);
 	tmp |=3D MSPI_SPCR2_SPE;
 	if (cont)
 		tmp |=3D MSPI_SPCR2_CONT_AFTER_CMD;
-	bcm_mspi_write(mspi, MSPI_SPCR2, tmp);
+	mspi->mspi_write(mspi, MSPI_SPCR2, tmp);
=20
 	/* Wait for SPI to finish */
 	bcm_mspi_wait(mspi, bcm_mspi_calc_timeout(len));
=20
 	if (!cont)
-		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 0);
+		mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 0);
=20
 	mspi->read_offset =3D len;
 }
@@ -143,35 +140,35 @@ static void bcm_mspi_buf_read(struct bcm_mspi *ms=
pi, u8 *r_buf,
 			tmp &=3D ~CDRAM_CONT;
 		tmp &=3D ~0x1;
 		/* Command Register File */
-		bcm_mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
+		mspi->mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
 	}
=20
 	/* Set queue pointers */
-	bcm_mspi_write(mspi, MSPI_NEWQP, 0);
-	bcm_mspi_write(mspi, MSPI_ENDQP,
+	mspi->mspi_write(mspi, MSPI_NEWQP, 0);
+	mspi->mspi_write(mspi, MSPI_ENDQP,
 			 mspi->read_offset + len - 1);
=20
 	if (cont)
-		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 1);
+		mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 1);
=20
 	/* Start SPI transfer */
-	tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
+	tmp =3D mspi->mspi_read(mspi, MSPI_SPCR2);
 	tmp |=3D MSPI_SPCR2_SPE;
 	if (cont)
 		tmp |=3D MSPI_SPCR2_CONT_AFTER_CMD;
-	bcm_mspi_write(mspi, MSPI_SPCR2, tmp);
+	mspi->mspi_write(mspi, MSPI_SPCR2, tmp);
=20
 	/* Wait for SPI to finish */
 	bcm_mspi_wait(mspi, bcm_mspi_calc_timeout(len));
=20
 	if (!cont)
-		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 0);
+		mspi->mspi_write(mspi, MSPI_WRITE_LOCK, 0);
=20
 	for (i =3D 0; i < len; ++i) {
 		int offset =3D mspi->read_offset + i;
=20
 		/* Data stored in the transmit register file LSB */
-		r_buf[i] =3D (u8)bcm_mspi_read(mspi,
+		r_buf[i] =3D (u8)mspi->mspi_read(mspi,
 			MSPI_RXRAM + 4 * (1 + offset * 2));
 	}
=20
@@ -216,9 +213,103 @@ static int bcm_mspi_transfer_one(struct spi_maste=
r *master,
 	return 0;
 }
=20
-static struct spi_board_info bcm53xx_info =3D {
-	.modalias	=3D "bcm53xxspiflash",
+/*
+ * Allocate SPI master for both bcma and non bcma bus. The SPI device =
must be
+ * configured in DT.
+ */
+static struct bcm_mspi *bcm_mspi_init(struct device *dev)
+{
+	struct bcm_mspi *data;
+	struct spi_master *master;
+
+	master =3D spi_alloc_master(dev, sizeof(*data));
+	if (!master) {
+		dev_err(dev, "error allocating spi_master\n");
+		return 0;
+	}
+
+	data =3D spi_master_get_devdata(master);
+	data->master =3D master;
+
+	/* SPI master will always use the SPI device(s) from DT. */
+	master->dev.of_node =3D dev->of_node;
+	master->transfer_one =3D bcm_mspi_transfer_one;
+
+	return data;
+}
+
+#ifdef CONFIG_SPI_BCM_MSPI
+
+static const struct of_device_id bcm_mspi_dt[] =3D {
+	{ .compatible =3D "brcm,mspi" },
+	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm_mspi_dt);
+
+static inline u32 bcm_mspi_read(struct bcm_mspi *mspi, u16 offset)
+{
+	return readl(mspi->base + offset);
+}
+
+static inline void bcm_mspi_write(struct bcm_mspi *mspi, u16 offset,
+	u32 value)
+{
+	writel(value, mspi->base + offset);
+}
+
+/*
+ * Probe routine for non-bcma devices.
+ */
+static int bcm_mspi_probe(struct platform_device *pdev)
+{
+	struct bcm_mspi *data;
+	struct device *dev =3D &pdev->dev;
+	int err;
+	struct resource *res;
+
+	dev_info(dev, "BCM MSPI probe\n");
+
+	data =3D bcm_mspi_init(dev);
+	if (!data)
+		return -ENOMEM;
+
+	/* Map base memory address. */
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->base)) {
+		dev_err(&pdev->dev, "unable to map I/O memory\n");
+		err =3D PTR_ERR(data->base);
+		goto out;
+	}
+
+	data->mspi_read =3D bcm_mspi_read;
+	data->mspi_write =3D bcm_mspi_write;
+	platform_set_drvdata(pdev, data);
+
+	err =3D devm_spi_register_master(dev, data->master);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	spi_master_put(data->master);
+	return err;
+}
+
+static struct platform_driver bcm_mspi_driver =3D {
+	.driver =3D {
+		.name =3D "bcm-mspi",
+		.of_match_table =3D bcm_mspi_dt,
+	},
+	.probe =3D bcm_mspi_probe,
+};
+
+module_platform_driver(bcm_mspi_driver);
+
+#endif
+
+#ifdef CONFIG_SPI_BCMA_MSPI
=20
 static const struct bcma_device_id bcm_mspi_bcma_tbl[] =3D {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_NS_QSPI, BCMA_ANY_REV,
@@ -227,6 +318,12 @@ static const struct bcma_device_id bcm_mspi_bcma_t=
bl[] =3D {
 };
 MODULE_DEVICE_TABLE(bcma, bcm_mspi_bcma_tbl);
=20
+static const struct of_device_id bcm_bcma_mspi_dt[] =3D {
+	{ .compatible =3D "brcm,bcma-mspi" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm_mspi_dt);
+
 static inline u32 bcm_bcma_mspi_read(struct bcm_mspi *mspi, u16 offset=
)
 {
 	return bcma_read32(mspi->core, offset);
@@ -238,53 +335,52 @@ static inline void bcm_bcma_mspi_write(struct bcm=
_mspi *mspi, u16 offset,
 	bcma_write32(mspi->core, offset, value);
 }
=20
+/*
+ * Probe routine for bcma devices.
+ */
 static int bcm_mspi_bcma_probe(struct bcma_device *core)
 {
 	struct bcm_mspi *data;
-	struct spi_master *master;
 	int err;
=20
 	dev_info(&core->dev, "BCM MSPI BCMA probe\n");
=20
 	if (core->bus->drv_cc.core->id.rev !=3D 42) {
-		pr_err("SPI on SoC with unsupported ChipCommon rev\n");
+		dev_err(&core->dev,
+			"SPI on SoC with unsupported ChipCommon rev\n");
 		return -ENOTSUPP;
 	}
=20
-	master =3D spi_alloc_master(&core->dev, sizeof(*data));
-	if (!master)
+	data =3D bcm_mspi_init(&core->dev);
+	if (!data)
 		return -ENOMEM;
=20
-	data =3D spi_master_get_devdata(master);
-	data->master =3D master;
+	data->mspi_read =3D bcm_bcma_mspi_read;
+	data->mspi_write =3D bcm_bcma_mspi_write;
 	data->core =3D core;
-
-	master->transfer_one =3D bcm_mspi_transfer_one;
 	bcma_set_drvdata(core, data);
=20
 	err =3D devm_spi_register_master(&core->dev, data->master);
 	if (err) {
-		spi_master_put(master);
-		bcma_set_drvdata(core, NULL);
-		goto out;
+		spi_master_put(data->master);
+		return err;
 	}
=20
-	/* Broadcom SoCs (at least with the CC rev 42) use SPI for flash only=
 */
-	spi_new_device(master, &bcm53xx_info);
-
-out:
-	return err;
+	return 0;
 }
=20
 static struct bcma_driver bcm_mspi_bcma_driver =3D {
 	.name		=3D KBUILD_MODNAME,
+	.drv =3D {
+		.of_match_table =3D bcm_bcma_mspi_dt,
+	},
 	.id_table	=3D bcm_mspi_bcma_tbl,
 	.probe		=3D bcm_mspi_bcma_probe,
 };
=20
 static int __init bcm_mspi_bcma_module_init(void)
 {
-	int err =3D 0;
+	int err;
=20
 	err =3D bcma_driver_register(&bcm_mspi_bcma_driver);
 	if (err)
@@ -301,6 +397,8 @@ static void __exit bcm_mspi_bcma_module_exit(void)
 module_init(bcm_mspi_bcma_module_init);
 module_exit(bcm_mspi_bcma_module_exit);
=20
+#endif
+
 MODULE_DESCRIPTION("Broadcom MSPI SPI Controller driver");
 MODULE_AUTHOR("Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
 MODULE_AUTHOR("Broadcom");
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
