From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2] spi: bcm53xx: driver for SPI controller on Broadcom bcma SoC
Date: Sun, 17 Aug 2014 18:33:38 +0200
Message-ID: <1408293218-32439-1-git-send-email-zajec5@gmail.com>
References: <1408228864-20313-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408228864-20313-1-git-send-email-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Broadcom 53xx ARM SoCs use bcma bus that contains various cores (AKA
devices). If board has a serial flash, it's connected over SPI and the
bcma bus includes a SPI controller. Example log from such a board:
bus0: Found chip with id 53010, rev 0x00 and package 0x02
(...)
bus0: Core 18 found: SPI flash controller (manuf 0x4BF, id 0x50A, rev 0=
x01, class 0x0)

This patch adds a bcma driver for SPI core, it registers SPI master
controller and "bcm53xxspiflash" SPI device.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Since RFC: Add Signed-off-by
	   Update to compile on top of for-next
V2: Use wait timeout
    Describe bcm53xxspi_calc_timeout a bit
    Use devm_spi_register_master

Thanks Mark for your comments!
---
 drivers/spi/Kconfig       |   6 +
 drivers/spi/Makefile      |   1 +
 drivers/spi/spi-bcm53xx.c | 295 ++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/spi/spi-bcm53xx.h |  72 +++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 drivers/spi/spi-bcm53xx.c
 create mode 100644 drivers/spi/spi-bcm53xx.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 62e2242..b14b829 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -112,6 +112,12 @@ config SPI_AU1550
 	  If you say yes to this option, support will be included for the
 	  PSC SPI controller found on Au1550, Au1200 and Au1300 series.
=20
+config SPI_BCM53XX
+	tristate "Broadcom BCM53xx SPI controller"
+	depends on ARCH_BCM_5301X
+	help
+          Enable support for the SPI controller on Broadcom BCM53xx AR=
M SoCs.
+
 config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
 	depends on BCM63XX
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 762da07..78f24ca 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SPI_ATMEL)			+=3D spi-atmel.o
 obj-$(CONFIG_SPI_ATH79)			+=3D spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+=3D spi-au1550.o
 obj-$(CONFIG_SPI_BCM2835)		+=3D spi-bcm2835.o
+obj-$(CONFIG_SPI_BCM53XX)		+=3D spi-bcm53xx.o
 obj-$(CONFIG_SPI_BCM63XX)		+=3D spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+=3D spi-bcm63xx-hsspi.o
 obj-$(CONFIG_SPI_BFIN5XX)		+=3D spi-bfin5xx.o
diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
new file mode 100644
index 0000000..ffc4461
--- /dev/null
+++ b/drivers/spi/spi-bcm53xx.c
@@ -0,0 +1,295 @@
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/bcma/bcma.h>
+#include <linux/spi/spi.h>
+
+#include "spi-bcm53xx.h"
+
+#define BCM53XXSPI_MAX_SPI_BAUD	13500000	/* 216 MHz? */
+
+/* The longest observed required wait was 19 ms */
+#define BCM53XXSPI_SPE_TIMEOUT_MS	80
+
+struct bcm53xxspi {
+	struct bcma_device *core;
+	struct spi_master *master;
+
+	size_t read_offset;
+};
+
+static inline u32 bcm53xxspi_read(struct bcm53xxspi *b53spi, u16 offse=
t)
+{
+	return bcma_read32(b53spi->core, offset);
+}
+
+static inline void bcm53xxspi_write(struct bcm53xxspi *b53spi, u16 off=
set,
+				    u32 value)
+{
+	bcma_write32(b53spi->core, offset, value);
+}
+
+static inline unsigned int bcm53xxspi_calc_timeout(size_t len)
+{
+	/* Do some magic calculation based on length and buad. Add 10% and 1.=
 */
+	return (len * 9000 / BCM53XXSPI_MAX_SPI_BAUD * 110 / 100) + 1;
+}
+
+static int bcm53xxspi_wait(struct bcm53xxspi *b53spi, unsigned int tim=
eout_ms)
+{
+	unsigned long deadline;
+	u32 tmp;
+
+	/* SPE bit has to be 0 before we read MSPI STATUS */
+	deadline =3D jiffies + BCM53XXSPI_SPE_TIMEOUT_MS * HZ / 1000;
+	do {
+		tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
+		if (!(tmp & B53SPI_MSPI_SPCR2_SPE))
+			break;
+		udelay(5);
+	} while (!time_after_eq(jiffies, deadline));
+
+	if (tmp & B53SPI_MSPI_SPCR2_SPE)
+		goto spi_timeout;
+
+	/* Check status */
+	deadline =3D jiffies + timeout_ms * HZ / 1000;
+	do {
+		tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_MSPI_STATUS);
+		if (tmp & B53SPI_MSPI_MSPI_STATUS_SPIF) {
+			bcm53xxspi_write(b53spi, B53SPI_MSPI_MSPI_STATUS, 0);
+			return 0;
+		}
+
+		cpu_relax();
+		udelay(100);
+	} while (!time_after_eq(jiffies, deadline));
+
+spi_timeout:
+	bcm53xxspi_write(b53spi, B53SPI_MSPI_MSPI_STATUS, 0);
+
+	pr_err("Timeout waiting for SPI to be ready!\n");
+
+	return -EBUSY;
+}
+
+static void bcm53xxspi_buf_write(struct bcm53xxspi *b53spi, u8 *w_buf,
+				 size_t len, bool cont)
+{
+	u32 tmp;
+	int i;
+
+	for (i =3D 0; i < len; i++) {
+		/* Transmit Register File MSB */
+		bcm53xxspi_write(b53spi, B53SPI_MSPI_TXRAM + 4 * (i * 2),
+				 (unsigned int)w_buf[i]);
+	}
+
+	for (i =3D 0; i < len; i++) {
+		tmp =3D B53SPI_CDRAM_CONT | B53SPI_CDRAM_PCS_DISABLE_ALL |
+		      B53SPI_CDRAM_PCS_DSCK;
+		if (!cont && i =3D=3D len - 1)
+			tmp &=3D ~B53SPI_CDRAM_CONT;
+		tmp &=3D ~0x1;
+		/* Command Register File */
+		bcm53xxspi_write(b53spi, B53SPI_MSPI_CDRAM + 4 * i, tmp);
+	}
+
+	/* Set queue pointers */
+	bcm53xxspi_write(b53spi, B53SPI_MSPI_NEWQP, 0);
+	bcm53xxspi_write(b53spi, B53SPI_MSPI_ENDQP, len - 1);
+
+	if (cont)
+		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 1);
+
+	/* Start SPI transfer */
+	tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
+	tmp |=3D B53SPI_MSPI_SPCR2_SPE;
+	if (cont)
+		tmp |=3D B53SPI_MSPI_SPCR2_CONT_AFTER_CMD;
+	bcm53xxspi_write(b53spi, B53SPI_MSPI_SPCR2, tmp);
+
+	/* Wait for SPI to finish */
+	bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));
+
+	if (!cont)
+		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 0);
+
+	b53spi->read_offset =3D len;
+}
+
+static void bcm53xxspi_buf_read(struct bcm53xxspi *b53spi, u8 *r_buf,
+				size_t len, bool cont)
+{
+	u32 tmp;
+	int i;
+
+	for (i =3D 0; i < b53spi->read_offset + len; i++) {
+		tmp =3D B53SPI_CDRAM_CONT | B53SPI_CDRAM_PCS_DISABLE_ALL |
+		      B53SPI_CDRAM_PCS_DSCK;
+		if (!cont && i =3D=3D b53spi->read_offset + len - 1)
+			tmp &=3D ~B53SPI_CDRAM_CONT;
+		tmp &=3D ~0x1;
+		/* Command Register File */
+		bcm53xxspi_write(b53spi, B53SPI_MSPI_CDRAM + 4 * i, tmp);
+	}
+
+	/* Set queue pointers */
+	bcm53xxspi_write(b53spi, B53SPI_MSPI_NEWQP, 0);
+	bcm53xxspi_write(b53spi, B53SPI_MSPI_ENDQP,
+			 b53spi->read_offset + len - 1);
+
+	if (cont)
+		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 1);
+
+	/* Start SPI transfer */
+	tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
+	tmp |=3D B53SPI_MSPI_SPCR2_SPE;
+	if (cont)
+		tmp |=3D B53SPI_MSPI_SPCR2_CONT_AFTER_CMD;
+	bcm53xxspi_write(b53spi, B53SPI_MSPI_SPCR2, tmp);
+
+	/* Wait for SPI to finish */
+	bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));
+
+	if (!cont)
+		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 0);
+
+	for (i =3D 0; i < len; ++i) {
+		int offset =3D b53spi->read_offset + i;
+
+		/* Data stored in the transmit register file LSB */
+		r_buf[i] =3D (u8)bcm53xxspi_read(b53spi, B53SPI_MSPI_RXRAM + 4 * (1 =
+ offset * 2));
+	}
+
+	b53spi->read_offset =3D 0;
+}
+
+static int bcm53xxspi_transfer_one(struct spi_master *master,
+				   struct spi_device *spi,
+				   struct spi_transfer *t)
+{
+	struct bcm53xxspi *b53spi =3D spi_master_get_devdata(master);
+	u8 *buf;
+	size_t left;
+
+	if (t->tx_buf) {
+		buf =3D (u8 *)t->tx_buf;
+		left =3D t->len;
+		while (left) {
+			size_t to_write =3D min_t(size_t, 16, left);
+			bool cont =3D left - to_write > 0;
+
+			bcm53xxspi_buf_write(b53spi, buf, to_write, cont);
+			left -=3D to_write;
+			buf +=3D to_write;
+		}
+	}
+
+	if (t->rx_buf) {
+		buf =3D (u8 *)t->rx_buf;
+		left =3D t->len;
+		while (left) {
+			size_t to_read =3D min_t(size_t, 16 - b53spi->read_offset,
+					       left);
+			bool cont =3D left - to_read > 0;
+
+			bcm53xxspi_buf_read(b53spi, buf, to_read, cont);
+			left -=3D to_read;
+			buf +=3D to_read;
+		}
+	}
+
+	return 0;
+}
+
+/**************************************************
+ * BCMA
+ **************************************************/
+
+struct spi_board_info bcm53xx_info =3D {
+	.modalias	=3D "bcm53xxspiflash",
+};
+
+static const struct bcma_device_id bcm53xxspi_bcma_tbl[] =3D {
+	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_NS_QSPI, BCMA_ANY_REV, BCMA_ANY_C=
LASS),
+	BCMA_CORETABLE_END
+};
+MODULE_DEVICE_TABLE(bcma, bcm53xxspi_bcma_tbl);
+
+static int bcm53xxspi_bcma_probe(struct bcma_device *core)
+{
+	struct bcm53xxspi *b53spi;
+	struct spi_master *master;
+	int err;
+
+	if (core->bus->drv_cc.core->id.rev !=3D 42) {
+		pr_err("SPI on SoC with unsupported ChipCommon rev\n");
+		return -ENOTSUPP;
+	}
+
+	master =3D spi_alloc_master(&core->dev, sizeof(*b53spi));
+	if (!master)
+		return -ENOMEM;
+
+	b53spi =3D spi_master_get_devdata(master);
+	b53spi->master =3D master;
+	b53spi->core =3D core;
+
+	master->transfer_one =3D bcm53xxspi_transfer_one;
+
+	bcma_set_drvdata(core, b53spi);
+
+	err =3D devm_spi_register_master(&core->dev, master);
+	if (err) {
+		spi_master_put(master);
+		bcma_set_drvdata(core, NULL);
+		goto out;
+	}
+
+	/* Broadcom SoCs (at least with the CC rev 42) use SPI for flash only=
 */
+	spi_new_device(master, &bcm53xx_info);
+
+out:
+	return err;
+}
+
+static void bcm53xxspi_bcma_remove(struct bcma_device *core)
+{
+	struct bcm53xxspi *b53spi =3D bcma_get_drvdata(core);
+
+	spi_unregister_master(b53spi->master);
+}
+
+static struct bcma_driver bcm53xxspi_bcma_driver =3D {
+	.name		=3D KBUILD_MODNAME,
+	.id_table	=3D bcm53xxspi_bcma_tbl,
+	.probe		=3D bcm53xxspi_bcma_probe,
+	.remove		=3D bcm53xxspi_bcma_remove,
+};
+
+/**************************************************
+ * Init & exit
+ **************************************************/
+
+static int __init bcm53xxspi_module_init(void)
+{
+	int err =3D 0;
+
+	err =3D bcma_driver_register(&bcm53xxspi_bcma_driver);
+	if (err)
+		pr_err("Failed to register bcma driver: %d\n", err);
+
+	return err;
+}
+
+static void __exit bcm53xxspi_module_exit(void)
+{
+	bcma_driver_unregister(&bcm53xxspi_bcma_driver);
+}
+
+module_init(bcm53xxspi_module_init);
+module_exit(bcm53xxspi_module_exit);
diff --git a/drivers/spi/spi-bcm53xx.h b/drivers/spi/spi-bcm53xx.h
new file mode 100644
index 0000000..73575df
--- /dev/null
+++ b/drivers/spi/spi-bcm53xx.h
@@ -0,0 +1,72 @@
+#ifndef SPI_BCM53XX_H
+#define SPI_BCM53XX_H
+
+#define B53SPI_BSPI_REVISION_ID			0x000
+#define B53SPI_BSPI_SCRATCH			0x004
+#define B53SPI_BSPI_MAST_N_BOOT_CTRL		0x008
+#define B53SPI_BSPI_BUSY_STATUS			0x00c
+#define B53SPI_BSPI_INTR_STATUS			0x010
+#define B53SPI_BSPI_B0_STATUS			0x014
+#define B53SPI_BSPI_B0_CTRL			0x018
+#define B53SPI_BSPI_B1_STATUS			0x01c
+#define B53SPI_BSPI_B1_CTRL			0x020
+#define B53SPI_BSPI_STRAP_OVERRIDE_CTRL		0x024
+#define B53SPI_BSPI_FLEX_MODE_ENABLE		0x028
+#define B53SPI_BSPI_BITS_PER_CYCLE		0x02c
+#define B53SPI_BSPI_BITS_PER_PHASE		0x030
+#define B53SPI_BSPI_CMD_AND_MODE_BYTE		0x034
+#define B53SPI_BSPI_BSPI_FLASH_UPPER_ADDR_BYTE	0x038
+#define B53SPI_BSPI_BSPI_XOR_VALUE		0x03c
+#define B53SPI_BSPI_BSPI_XOR_ENABLE		0x040
+#define B53SPI_BSPI_BSPI_PIO_MODE_ENABLE	0x044
+#define B53SPI_BSPI_BSPI_PIO_IODIR		0x048
+#define B53SPI_BSPI_BSPI_PIO_DATA		0x04c
+
+/* RAF */
+#define B53SPI_RAF_START_ADDR			0x100
+#define B53SPI_RAF_NUM_WORDS			0x104
+#define B53SPI_RAF_CTRL				0x108
+#define B53SPI_RAF_FULLNESS			0x10c
+#define B53SPI_RAF_WATERMARK			0x110
+#define B53SPI_RAF_STATUS			0x114
+#define B53SPI_RAF_READ_DATA			0x118
+#define B53SPI_RAF_WORD_CNT			0x11c
+#define B53SPI_RAF_CURR_ADDR			0x120
+
+/* MSPI */
+#define B53SPI_MSPI_SPCR0_LSB			0x200
+#define B53SPI_MSPI_SPCR0_MSB			0x204
+#define B53SPI_MSPI_SPCR1_LSB			0x208
+#define B53SPI_MSPI_SPCR1_MSB			0x20c
+#define B53SPI_MSPI_NEWQP			0x210
+#define B53SPI_MSPI_ENDQP			0x214
+#define B53SPI_MSPI_SPCR2			0x218
+#define  B53SPI_MSPI_SPCR2_SPE			0x00000040
+#define  B53SPI_MSPI_SPCR2_CONT_AFTER_CMD	0x00000080
+#define B53SPI_MSPI_MSPI_STATUS			0x220
+#define  B53SPI_MSPI_MSPI_STATUS_SPIF		0x00000001
+#define B53SPI_MSPI_CPTQP			0x224
+#define B53SPI_MSPI_TXRAM			0x240 /* 32 registers, up to 0x2b8 */
+#define B53SPI_MSPI_RXRAM			0x2c0 /* 32 registers, up to 0x33c */
+#define B53SPI_MSPI_CDRAM			0x340 /* 16 registers, up to 0x37c */
+#define  B53SPI_CDRAM_PCS_PCS0			0x00000001
+#define  B53SPI_CDRAM_PCS_PCS1			0x00000002
+#define  B53SPI_CDRAM_PCS_PCS2			0x00000004
+#define  B53SPI_CDRAM_PCS_PCS3			0x00000008
+#define  B53SPI_CDRAM_PCS_DISABLE_ALL		0x0000000f
+#define  B53SPI_CDRAM_PCS_DSCK			0x00000010
+#define  B53SPI_CDRAM_BITSE			0x00000040
+#define  B53SPI_CDRAM_CONT			0x00000080
+#define B53SPI_MSPI_WRITE_LOCK			0x380
+#define B53SPI_MSPI_DISABLE_FLUSH_GEN		0x384
+
+/* Interrupt */
+#define B53SPI_INTR_RAF_LR_FULLNESS_REACHED	0x3a0
+#define B53SPI_INTR_RAF_LR_TRUNCATED		0x3a4
+#define B53SPI_INTR_RAF_LR_IMPATIENT		0x3a8
+#define B53SPI_INTR_RAF_LR_SESSION_DONE		0x3ac
+#define B53SPI_INTR_RAF_LR_OVERREAD		0x3b0
+#define B53SPI_INTR_MSPI_DONE			0x3b4
+#define B53SPI_INTR_MSPI_HALT_SET_TRANSACTION_DONE	0x3b8
+
+#endif /* SPI_BCM53XX_H */
--=20
1.8.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
