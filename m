From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=20v2=203/5=5D=20spi=3A=20bcm-mspi=3A=20Refactor=20to=20make=20driver=20nonspecific=20to=2053xx=20SoCs?=
Date: Wed, 8 Apr 2015 11:04:33 -0700
Message-ID: <1428516275-12819-4-git-send-email-jonathar@broadcom.com>
References: <1428516275-12819-1-git-send-email-jonathar@broadcom.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428516275-12819-1-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Rename variables, structures, etc so that the naming matches the new
driver name (bcm mspi) instead of the previous naming that was chip
specific (53xx).

Signed-off-by: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-bcm-mspi.c |  200 ++++++++++++++++++++++--------------=
--------
 drivers/spi/spi-bcm-mspi.h |  140 +++++++++++++++++--------------
 2 files changed, 178 insertions(+), 162 deletions(-)

diff --git a/drivers/spi/spi-bcm-mspi.c b/drivers/spi/spi-bcm-mspi.c
index db3d293..502227d 100644
--- a/drivers/spi/spi-bcm-mspi.c
+++ b/drivers/spi/spi-bcm-mspi.c
@@ -1,5 +1,15 @@
-#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
-
+/*
+ * Portions Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -9,58 +19,58 @@
=20
 #include "spi-bcm-mspi.h"
=20
-#define BCM53XXSPI_MAX_SPI_BAUD	13500000	/* 216 MHz? */
+#define BCM_MSPI_MAX_SPI_BAUD   13500000	/* 216 MHz? */
=20
 /* The longest observed required wait was 19 ms */
-#define BCM53XXSPI_SPE_TIMEOUT_MS	80
+#define BCM_MSPI_SPE_TIMEOUT_MS 80
=20
-struct bcm53xxspi {
+struct bcm_mspi {
 	struct bcma_device *core;
 	struct spi_master *master;
=20
 	size_t read_offset;
 };
=20
-static inline u32 bcm53xxspi_read(struct bcm53xxspi *b53spi, u16 offse=
t)
+static inline u32 bcm_mspi_read(struct bcm_mspi *mspi, u16 offset)
 {
-	return bcma_read32(b53spi->core, offset);
+	return bcma_read32(mspi->core, offset);
 }
=20
-static inline void bcm53xxspi_write(struct bcm53xxspi *b53spi, u16 off=
set,
+static inline void bcm_mspi_write(struct bcm_mspi *mspi, u16 offset,
 				    u32 value)
 {
-	bcma_write32(b53spi->core, offset, value);
+	bcma_write32(mspi->core, offset, value);
 }
=20
-static inline unsigned int bcm53xxspi_calc_timeout(size_t len)
+static inline unsigned int bcm_mspi_calc_timeout(size_t len)
 {
 	/* Do some magic calculation based on length and buad. Add 10% and 1.=
 */
-	return (len * 9000 / BCM53XXSPI_MAX_SPI_BAUD * 110 / 100) + 1;
+	return (len * 9000 / BCM_MSPI_MAX_SPI_BAUD * 110 / 100) + 1;
 }
=20
-static int bcm53xxspi_wait(struct bcm53xxspi *b53spi, unsigned int tim=
eout_ms)
+static int bcm_mspi_wait(struct bcm_mspi *mspi, unsigned int timeout_m=
s)
 {
 	unsigned long deadline;
 	u32 tmp;
=20
 	/* SPE bit has to be 0 before we read MSPI STATUS */
-	deadline =3D jiffies + BCM53XXSPI_SPE_TIMEOUT_MS * HZ / 1000;
+	deadline =3D jiffies + BCM_MSPI_SPE_TIMEOUT_MS * HZ / 1000;
 	do {
-		tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
-		if (!(tmp & B53SPI_MSPI_SPCR2_SPE))
+		tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
+		if (!(tmp & MSPI_SPCR2_SPE))
 			break;
 		udelay(5);
 	} while (!time_after_eq(jiffies, deadline));
=20
-	if (tmp & B53SPI_MSPI_SPCR2_SPE)
+	if (tmp & MSPI_SPCR2_SPE)
 		goto spi_timeout;
=20
 	/* Check status */
 	deadline =3D jiffies + timeout_ms * HZ / 1000;
 	do {
-		tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_MSPI_STATUS);
-		if (tmp & B53SPI_MSPI_MSPI_STATUS_SPIF) {
-			bcm53xxspi_write(b53spi, B53SPI_MSPI_MSPI_STATUS, 0);
+		tmp =3D bcm_mspi_read(mspi, MSPI_STATUS);
+		if (tmp & MSPI_STATUS_SPIF) {
+			bcm_mspi_write(mspi, MSPI_STATUS, 0);
 			return 0;
 		}
=20
@@ -69,14 +79,14 @@ static int bcm53xxspi_wait(struct bcm53xxspi *b53sp=
i, unsigned int timeout_ms)
 	} while (!time_after_eq(jiffies, deadline));
=20
 spi_timeout:
-	bcm53xxspi_write(b53spi, B53SPI_MSPI_MSPI_STATUS, 0);
+	bcm_mspi_write(mspi, MSPI_STATUS, 0);
=20
 	pr_err("Timeout waiting for SPI to be ready!\n");
=20
 	return -EBUSY;
 }
=20
-static void bcm53xxspi_buf_write(struct bcm53xxspi *b53spi, u8 *w_buf,
+static void bcm_mspi_buf_write(struct bcm_mspi *mspi, u8 *w_buf,
 				 size_t len, bool cont)
 {
 	u32 tmp;
@@ -84,96 +94,95 @@ static void bcm53xxspi_buf_write(struct bcm53xxspi =
*b53spi, u8 *w_buf,
=20
 	for (i =3D 0; i < len; i++) {
 		/* Transmit Register File MSB */
-		bcm53xxspi_write(b53spi, B53SPI_MSPI_TXRAM + 4 * (i * 2),
+		bcm_mspi_write(mspi, MSPI_TXRAM + 4 * (i * 2),
 				 (unsigned int)w_buf[i]);
 	}
=20
 	for (i =3D 0; i < len; i++) {
-		tmp =3D B53SPI_CDRAM_CONT | B53SPI_CDRAM_PCS_DISABLE_ALL |
-		      B53SPI_CDRAM_PCS_DSCK;
+		tmp =3D MSPI_CDRAM_CONT | MSPI_CDRAM_PCS_DISABLE_ALL |
+			MSPI_CDRAM_PCS_DSCK;
 		if (!cont && i =3D=3D len - 1)
-			tmp &=3D ~B53SPI_CDRAM_CONT;
+			tmp &=3D ~MSPI_CDRAM_CONT;
 		tmp &=3D ~0x1;
 		/* Command Register File */
-		bcm53xxspi_write(b53spi, B53SPI_MSPI_CDRAM + 4 * i, tmp);
+		bcm_mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
 	}
=20
 	/* Set queue pointers */
-	bcm53xxspi_write(b53spi, B53SPI_MSPI_NEWQP, 0);
-	bcm53xxspi_write(b53spi, B53SPI_MSPI_ENDQP, len - 1);
+	bcm_mspi_write(mspi, MSPI_NEWQP, 0);
+	bcm_mspi_write(mspi, MSPI_ENDQP, len - 1);
=20
 	if (cont)
-		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 1);
+		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 1);
=20
 	/* Start SPI transfer */
-	tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
-	tmp |=3D B53SPI_MSPI_SPCR2_SPE;
+	tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
+	tmp |=3D MSPI_SPCR2_SPE;
 	if (cont)
-		tmp |=3D B53SPI_MSPI_SPCR2_CONT_AFTER_CMD;
-	bcm53xxspi_write(b53spi, B53SPI_MSPI_SPCR2, tmp);
+		tmp |=3D MSPI_SPCR2_CONT_AFTER_CMD;
+	bcm_mspi_write(mspi, MSPI_SPCR2, tmp);
=20
 	/* Wait for SPI to finish */
-	bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));
+	bcm_mspi_wait(mspi, bcm_mspi_calc_timeout(len));
=20
 	if (!cont)
-		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 0);
+		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 0);
=20
-	b53spi->read_offset =3D len;
+	mspi->read_offset =3D len;
 }
=20
-static void bcm53xxspi_buf_read(struct bcm53xxspi *b53spi, u8 *r_buf,
+static void bcm_mspi_buf_read(struct bcm_mspi *mspi, u8 *r_buf,
 				size_t len, bool cont)
 {
 	u32 tmp;
 	int i;
=20
-	for (i =3D 0; i < b53spi->read_offset + len; i++) {
-		tmp =3D B53SPI_CDRAM_CONT | B53SPI_CDRAM_PCS_DISABLE_ALL |
-		      B53SPI_CDRAM_PCS_DSCK;
-		if (!cont && i =3D=3D b53spi->read_offset + len - 1)
-			tmp &=3D ~B53SPI_CDRAM_CONT;
+	for (i =3D 0; i < mspi->read_offset + len; i++) {
+		tmp =3D MSPI_CDRAM_CONT | MSPI_CDRAM_PCS_DISABLE_ALL |
+		      MSPI_CDRAM_PCS_DSCK;
+		if (!cont && i =3D=3D mspi->read_offset + len - 1)
+			tmp &=3D ~MSPI_CDRAM_CONT;
 		tmp &=3D ~0x1;
 		/* Command Register File */
-		bcm53xxspi_write(b53spi, B53SPI_MSPI_CDRAM + 4 * i, tmp);
+		bcm_mspi_write(mspi, MSPI_CDRAM + 4 * i, tmp);
 	}
=20
 	/* Set queue pointers */
-	bcm53xxspi_write(b53spi, B53SPI_MSPI_NEWQP, 0);
-	bcm53xxspi_write(b53spi, B53SPI_MSPI_ENDQP,
-			 b53spi->read_offset + len - 1);
+	bcm_mspi_write(mspi, MSPI_NEWQP, 0);
+	bcm_mspi_write(mspi, MSPI_ENDQP, mspi->read_offset + len - 1);
=20
 	if (cont)
-		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 1);
+		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 1);
=20
 	/* Start SPI transfer */
-	tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
-	tmp |=3D B53SPI_MSPI_SPCR2_SPE;
+	tmp =3D bcm_mspi_read(mspi, MSPI_SPCR2);
+	tmp |=3D MSPI_SPCR2_SPE;
 	if (cont)
-		tmp |=3D B53SPI_MSPI_SPCR2_CONT_AFTER_CMD;
-	bcm53xxspi_write(b53spi, B53SPI_MSPI_SPCR2, tmp);
+		tmp |=3D MSPI_SPCR2_CONT_AFTER_CMD;
+	bcm_mspi_write(mspi, MSPI_SPCR2, tmp);
=20
 	/* Wait for SPI to finish */
-	bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));
+	bcm_mspi_wait(mspi, bcm_mspi_calc_timeout(len));
=20
 	if (!cont)
-		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 0);
+		bcm_mspi_write(mspi, MSPI_WRITE_LOCK, 0);
=20
 	for (i =3D 0; i < len; ++i) {
-		int offset =3D b53spi->read_offset + i;
+		int offset =3D mspi->read_offset + i;
=20
 		/* Data stored in the transmit register file LSB */
-		r_buf[i] =3D (u8)bcm53xxspi_read(b53spi,
-			B53SPI_MSPI_RXRAM + 4 * (1 + offset * 2));
+		r_buf[i] =3D (u8)bcm_mspi_read(mspi,
+			MSPI_RXRAM + 4 * (1 + offset * 2));
 	}
=20
-	b53spi->read_offset =3D 0;
+	mspi->read_offset =3D 0;
 }
=20
-static int bcm53xxspi_transfer_one(struct spi_master *master,
+static int bcm_mspi_transfer_one(struct spi_master *master,
 				   struct spi_device *spi,
 				   struct spi_transfer *t)
 {
-	struct bcm53xxspi *b53spi =3D spi_master_get_devdata(master);
+	struct bcm_mspi *mspi =3D spi_master_get_devdata(master);
 	u8 *buf;
 	size_t left;
=20
@@ -184,7 +193,7 @@ static int bcm53xxspi_transfer_one(struct spi_maste=
r *master,
 			size_t to_write =3D min_t(size_t, 16, left);
 			bool cont =3D left - to_write > 0;
=20
-			bcm53xxspi_buf_write(b53spi, buf, to_write, cont);
+			bcm_mspi_buf_write(mspi, buf, to_write, cont);
 			left -=3D to_write;
 			buf +=3D to_write;
 		}
@@ -194,11 +203,11 @@ static int bcm53xxspi_transfer_one(struct spi_mas=
ter *master,
 		buf =3D (u8 *)t->rx_buf;
 		left =3D t->len;
 		while (left) {
-			size_t to_read =3D min_t(size_t, 16 - b53spi->read_offset,
+			size_t to_read =3D min_t(size_t, 16 - mspi->read_offset,
 					       left);
 			bool cont =3D left - to_read > 0;
=20
-			bcm53xxspi_buf_read(b53spi, buf, to_read, cont);
+			bcm_mspi_buf_read(mspi, buf, to_read, cont);
 			left -=3D to_read;
 			buf +=3D to_read;
 		}
@@ -207,45 +216,43 @@ static int bcm53xxspi_transfer_one(struct spi_mas=
ter *master,
 	return 0;
 }
=20
-/**************************************************
- * BCMA
- **************************************************/
-
-static struct spi_board_info bcm53xx_info =3D {
+static struct spi_board_info bcm_mspi_info =3D {
 	.modalias	=3D "bcm53xxspiflash",
 };
=20
-static const struct bcma_device_id bcm53xxspi_bcma_tbl[] =3D {
+static const struct bcma_device_id bcm_mspi_bcma_tbl[] =3D {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_NS_QSPI, BCMA_ANY_REV,
 		BCMA_ANY_CLASS),
 	{},
 };
-MODULE_DEVICE_TABLE(bcma, bcm53xxspi_bcma_tbl);
+MODULE_DEVICE_TABLE(bcma, bcm_mspi_bcma_tbl);
=20
-static int bcm53xxspi_bcma_probe(struct bcma_device *core)
+static int bcm_mspi_bcma_probe(struct bcma_device *core)
 {
-	struct bcm53xxspi *b53spi;
+	struct bcm_mspi *data;
 	struct spi_master *master;
 	int err;
=20
+	dev_info(&core->dev, "BCM MSPI BCMA probe\n");
+
 	if (core->bus->drv_cc.core->id.rev !=3D 42) {
 		pr_err("SPI on SoC with unsupported ChipCommon rev\n");
 		return -ENOTSUPP;
 	}
=20
-	master =3D spi_alloc_master(&core->dev, sizeof(*b53spi));
+	master =3D spi_alloc_master(&core->dev, sizeof(*data));
 	if (!master)
 		return -ENOMEM;
=20
-	b53spi =3D spi_master_get_devdata(master);
-	b53spi->master =3D master;
-	b53spi->core =3D core;
+	data =3D spi_master_get_devdata(master);
+	data->master =3D master;
+	data->core =3D core;
=20
-	master->transfer_one =3D bcm53xxspi_transfer_one;
+	master->transfer_one =3D bcm_mspi_transfer_one;
=20
-	bcma_set_drvdata(core, b53spi);
+	bcma_set_drvdata(core, data);
=20
-	err =3D devm_spi_register_master(&core->dev, master);
+	err =3D devm_spi_register_master(&core->dev, data->master);
 	if (err) {
 		spi_master_put(master);
 		bcma_set_drvdata(core, NULL);
@@ -253,49 +260,46 @@ static int bcm53xxspi_bcma_probe(struct bcma_devi=
ce *core)
 	}
=20
 	/* Broadcom SoCs (at least with the CC rev 42) use SPI for flash only=
 */
-	spi_new_device(master, &bcm53xx_info);
+	spi_new_device(master, &bcm_mspi_info);
=20
 out:
 	return err;
 }
=20
-static void bcm53xxspi_bcma_remove(struct bcma_device *core)
+static void bcm_mspi_bcma_remove(struct bcma_device *core)
 {
-	struct bcm53xxspi *b53spi =3D bcma_get_drvdata(core);
+	struct bcm_mspi *mspi =3D bcma_get_drvdata(core);
=20
-	spi_unregister_master(b53spi->master);
+	spi_unregister_master(mspi->master);
 }
=20
-static struct bcma_driver bcm53xxspi_bcma_driver =3D {
+static struct bcma_driver bcm_mspi_bcma_driver =3D {
 	.name		=3D KBUILD_MODNAME,
-	.id_table	=3D bcm53xxspi_bcma_tbl,
-	.probe		=3D bcm53xxspi_bcma_probe,
-	.remove		=3D bcm53xxspi_bcma_remove,
+	.id_table	=3D bcm_mspi_bcma_tbl,
+	.probe		=3D bcm_mspi_bcma_probe,
+	.remove		=3D bcm_mspi_bcma_remove,
 };
=20
-/**************************************************
- * Init & exit
- **************************************************/
-
-static int __init bcm53xxspi_module_init(void)
+static int __init bcm_mspi_module_init(void)
 {
 	int err =3D 0;
=20
-	err =3D bcma_driver_register(&bcm53xxspi_bcma_driver);
+	err =3D bcma_driver_register(&bcm_mspi_bcma_driver);
 	if (err)
 		pr_err("Failed to register bcma driver: %d\n", err);
=20
 	return err;
 }
=20
-static void __exit bcm53xxspi_module_exit(void)
+static void __exit bcm_mspi_module_exit(void)
 {
-	bcma_driver_unregister(&bcm53xxspi_bcma_driver);
+	bcma_driver_unregister(&bcm_mspi_bcma_driver);
 }
=20
-module_init(bcm53xxspi_module_init);
-module_exit(bcm53xxspi_module_exit);
+module_init(bcm_mspi_module_init);
+module_exit(bcm_mspi_module_exit);
=20
-MODULE_DESCRIPTION("Broadcom BCM53xx SPI Controller driver");
+MODULE_DESCRIPTION("Broadcom MSPI SPI Controller driver");
 MODULE_AUTHOR("Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
-MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Broadcom");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/spi-bcm-mspi.h b/drivers/spi/spi-bcm-mspi.h
index b44fdca..18b24ff 100644
--- a/drivers/spi/spi-bcm-mspi.h
+++ b/drivers/spi/spi-bcm-mspi.h
@@ -1,72 +1,84 @@
-#ifndef SPI_BCM53XX_H
-#define SPI_BCM53XX_H
+/*
+ * Portions Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef SPI_BCM_MSPI_H
+#define SPI_BCM_MSPI_H
=20
-#define B53SPI_BSPI_REVISION_ID			0x000
-#define B53SPI_BSPI_SCRATCH			0x004
-#define B53SPI_BSPI_MAST_N_BOOT_CTRL		0x008
-#define B53SPI_BSPI_BUSY_STATUS			0x00c
-#define B53SPI_BSPI_INTR_STATUS			0x010
-#define B53SPI_BSPI_B0_STATUS			0x014
-#define B53SPI_BSPI_B0_CTRL			0x018
-#define B53SPI_BSPI_B1_STATUS			0x01c
-#define B53SPI_BSPI_B1_CTRL			0x020
-#define B53SPI_BSPI_STRAP_OVERRIDE_CTRL		0x024
-#define B53SPI_BSPI_FLEX_MODE_ENABLE		0x028
-#define B53SPI_BSPI_BITS_PER_CYCLE		0x02c
-#define B53SPI_BSPI_BITS_PER_PHASE		0x030
-#define B53SPI_BSPI_CMD_AND_MODE_BYTE		0x034
-#define B53SPI_BSPI_BSPI_FLASH_UPPER_ADDR_BYTE	0x038
-#define B53SPI_BSPI_BSPI_XOR_VALUE		0x03c
-#define B53SPI_BSPI_BSPI_XOR_ENABLE		0x040
-#define B53SPI_BSPI_BSPI_PIO_MODE_ENABLE	0x044
-#define B53SPI_BSPI_BSPI_PIO_IODIR		0x048
-#define B53SPI_BSPI_BSPI_PIO_DATA		0x04c
+#define BSPI_REVISION_ID                0x000
+#define BSPI_SCRATCH                    0x004
+#define BSPI_MAST_N_BOOT_CTRL           0x008
+#define BSPI_BUSY_STATUS                0x00c
+#define BSPI_INTR_STATUS                0x010
+#define BSPI_B0_STATUS                  0x014
+#define BSPI_B0_CTRL                    0x018
+#define BSPI_B1_STATUS                  0x01c
+#define BSPI_B1_CTRL                    0x020
+#define BSPI_STRAP_OVERRIDE_CTRL        0x024
+#define BSPI_FLEX_MODE_ENABLE           0x028
+#define BSPI_BITS_PER_CYCLE             0x02c
+#define BSPI_BITS_PER_PHASE             0x030
+#define BSPI_CMD_AND_MODE_BYTE          0x034
+#define BSPI_BSPI_FLASH_UPPER_ADDR_BYTE 0x038
+#define BSPI_BSPI_XOR_VALUE             0x03c
+#define BSPI_BSPI_XOR_ENABLE            0x040
+#define BSPI_BSPI_PIO_MODE_ENABLE       0x044
+#define BSPI_BSPI_PIO_IODIR             0x048
+#define BSPI_BSPI_PIO_DATA              0x04c
=20
 /* RAF */
-#define B53SPI_RAF_START_ADDR			0x100
-#define B53SPI_RAF_NUM_WORDS			0x104
-#define B53SPI_RAF_CTRL				0x108
-#define B53SPI_RAF_FULLNESS			0x10c
-#define B53SPI_RAF_WATERMARK			0x110
-#define B53SPI_RAF_STATUS			0x114
-#define B53SPI_RAF_READ_DATA			0x118
-#define B53SPI_RAF_WORD_CNT			0x11c
-#define B53SPI_RAF_CURR_ADDR			0x120
+#define RAF_START_ADDR                  0x100
+#define RAF_NUM_WORDS                   0x104
+#define RAF_CTRL                        0x108
+#define RAF_FULLNESS                    0x10c
+#define RAF_WATERMARK                   0x110
+#define RAF_STATUS                      0x114
+#define RAF_READ_DATA                   0x118
+#define RAF_WORD_CNT                    0x11c
+#define RAF_CURR_ADDR                   0x120
=20
 /* MSPI */
-#define B53SPI_MSPI_SPCR0_LSB			0x200
-#define B53SPI_MSPI_SPCR0_MSB			0x204
-#define B53SPI_MSPI_SPCR1_LSB			0x208
-#define B53SPI_MSPI_SPCR1_MSB			0x20c
-#define B53SPI_MSPI_NEWQP			0x210
-#define B53SPI_MSPI_ENDQP			0x214
-#define B53SPI_MSPI_SPCR2			0x218
-#define  B53SPI_MSPI_SPCR2_SPE			0x00000040
-#define  B53SPI_MSPI_SPCR2_CONT_AFTER_CMD	0x00000080
-#define B53SPI_MSPI_MSPI_STATUS			0x220
-#define  B53SPI_MSPI_MSPI_STATUS_SPIF		0x00000001
-#define B53SPI_MSPI_CPTQP           0x224
-#define B53SPI_MSPI_TXRAM           0x240 /* 32 registers, up to 0x2b8=
 */
-#define B53SPI_MSPI_RXRAM           0x2c0 /* 32 registers, up to 0x33c=
 */
-#define B53SPI_MSPI_CDRAM           0x340 /* 16 registers, up to 0x37c=
 */
-#define  B53SPI_CDRAM_PCS_PCS0			0x00000001
-#define  B53SPI_CDRAM_PCS_PCS1			0x00000002
-#define  B53SPI_CDRAM_PCS_PCS2			0x00000004
-#define  B53SPI_CDRAM_PCS_PCS3			0x00000008
-#define  B53SPI_CDRAM_PCS_DISABLE_ALL		0x0000000f
-#define  B53SPI_CDRAM_PCS_DSCK			0x00000010
-#define  B53SPI_CDRAM_BITSE			0x00000040
-#define  B53SPI_CDRAM_CONT			0x00000080
-#define B53SPI_MSPI_WRITE_LOCK			0x380
-#define B53SPI_MSPI_DISABLE_FLUSH_GEN		0x384
+#define MSPI_SPCR0_LSB                  0x200
+#define MSPI_SPCR0_MSB                  0x204
+#define MSPI_SPCR1_LSB                  0x208
+#define MSPI_SPCR1_MSB                  0x20c
+#define MSPI_NEWQP                      0x210
+#define MSPI_ENDQP                      0x214
+#define MSPI_SPCR2                      0x218
+#define MSPI_SPCR2_SPE                  0x00000040
+#define MSPI_SPCR2_CONT_AFTER_CMD       0x00000080
+#define MSPI_STATUS                     0x220
+#define MSPI_STATUS_SPIF                0x00000001
+#define MSPI_CPTQP                      0x224
+#define MSPI_TXRAM                      0x240 /* 32 registers, up to 0=
x2b8 */
+#define MSPI_RXRAM                      0x2c0 /* 32 registers, up to 0=
x33c */
+#define MSPI_CDRAM                      0x340 /* 16 registers, up to 0=
x37c */
+#define MSPI_CDRAM_PCS_PCS0             0x00000001
+#define MSPI_CDRAM_PCS_PCS1             0x00000002
+#define MSPI_CDRAM_PCS_PCS2             0x00000004
+#define MSPI_CDRAM_PCS_PCS3             0x00000008
+#define MSPI_CDRAM_PCS_DISABLE_ALL      0x0000000f
+#define MSPI_CDRAM_PCS_DSCK             0x00000010
+#define MSPI_CDRAM_BITSE                0x00000040
+#define MSPI_CDRAM_CONT                 0x00000080
+#define MSPI_WRITE_LOCK                 0x380
+#define MSPI_DISABLE_FLUSH_GEN          0x384
=20
 /* Interrupt */
-#define B53SPI_INTR_RAF_LR_FULLNESS_REACHED	0x3a0
-#define B53SPI_INTR_RAF_LR_TRUNCATED		0x3a4
-#define B53SPI_INTR_RAF_LR_IMPATIENT		0x3a8
-#define B53SPI_INTR_RAF_LR_SESSION_DONE		0x3ac
-#define B53SPI_INTR_RAF_LR_OVERREAD		0x3b0
-#define B53SPI_INTR_MSPI_DONE			0x3b4
-#define B53SPI_INTR_MSPI_HALT_SET_TRANSACTION_DONE	0x3b8
+#define INTR_RAF_LR_FULLNESS_REACHED    0x3a0
+#define INTR_RAF_LR_TRUNCATED           0x3a4
+#define INTR_RAF_LR_IMPATIENT           0x3a8
+#define INTR_RAF_LR_SESSION_DONE        0x3ac
+#define INTR_RAF_LR_OVERREAD            0x3b0
+#define INTR_MSPI_DONE                  0x3b4
+#define INTR_MSPI_HALT_SET_TRANSACTION_DONE  0x3b8
=20
-#endif /* SPI_BCM53XX_H */
+#endif
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
