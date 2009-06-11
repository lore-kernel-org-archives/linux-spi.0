From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 2/9 v2] SPI: xilinx_spi: Added platform driver and support
 for DS570
Date: Thu, 11 Jun 2009 15:24:22 +0200
Message-ID: <4A310586.3030509@mocean-labs.com>
References: <4A292043.70704@mocean-labs.com>	<20090609160954.ae0bda8e.akpm@linux-foundation.org>	<4A2F737A.2000407@mocean-labs.com> <20090610015710.3afb1a92.akpm@linux-foundation.org> <4A2FB734.4020202@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756364AbZFKNn7@vger.kernel.org>
In-Reply-To: <4A2FB734.4020202@mocean-labs.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch splits xilinx_spi into three parts, an OF and a platform
driver and generic part.

The generic part now also works on X86 and also supports the Xilinx
SPI IP DS570

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>
---
Index: linux-2.6.30-rc7-spi/drivers/spi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7-spi/drivers/spi/Kconfig	(revision 909)
+++ linux-2.6.30-rc7-spi/drivers/spi/Kconfig	(revision 912)
@@ -211,8 +211,8 @@
 	  SPI driver for Toshiba TXx9 MIPS SoCs

 config SPI_XILINX
-	tristate "Xilinx SPI controller"
-	depends on XILINX_VIRTEX && EXPERIMENTAL
+	tristate "Xilinx SPI controller common module"
+	depends on EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This exposes the SPI controller IP from the Xilinx EDK.
@@ -220,6 +220,25 @@
 	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
 	  Product Specification document (DS464) for hardware details.

+config SPI_XILINX_OF
+	tristate "Xilinx SPI controller OF device"
+	depends on SPI_XILINX && XILINX_VIRTEX
+	help
+	  This exposes the SPI controller IP from the Xilinx EDK.
+
+	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
+	  Product Specification document (DS464) for hardware details.
+
+config SPI_XILINX_PLTFM
+	tristate "Xilinx SPI controller platform device"
+	depends on SPI_XILINX
+	help
+	  This exposes the SPI controller IP from the Xilinx EDK.
+
+	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
+	  Product Specification document (DS464) for hardware details.
+
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
Index: linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_of.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_of.c	(revision 0)
+++ linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_of.c	(revision 912)
@@ -0,0 +1,123 @@
+/*
+ * xilinx_spi.c
+ *
+ * Xilinx SPI controller driver (master mode only)
+ *
+ * Author: MontaVista Software, Inc.
+ *	source@mvista.com
+ *
+ * 2002-2007 (c) MontaVista Software, Inc.  This file is licensed unde=
r the
+ * terms of the GNU General Public License version 2.  This program is=
 licensed
+ * "as is" without any warranty of any kind, whether express or implie=
d.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/of_spi.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include "xilinx_spi.h"
+
+
+static int __init xilinx_spi_of_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
+{
+	struct resource r_irq_struct;
+	struct resource r_mem_struct;
+	struct spi_master *master;
+
+	struct resource *r_irq =3D &r_irq_struct;
+	struct resource *r_mem =3D &r_mem_struct;
+	int rc =3D 0;
+	const u32 *prop;
+	int len;
+
+	rc =3D of_address_to_resource(ofdev->node, 0, r_mem);
+	if (rc) {
+		dev_warn(&ofdev->dev, "invalid address\n");
+		return rc;
+	}
+
+	rc =3D of_irq_to_resource(ofdev->node, 0, r_irq);
+	if (rc =3D=3D NO_IRQ) {
+		dev_warn(&ofdev->dev, "no IRQ found\n");
+		return -ENODEV;
+	}
+
+	/* number of slave select bits is required */
+	prop =3D of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
+	if (!prop || len < sizeof(*prop)) {
+		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
+		return -EINVAL;
+	}
+	master =3D xilinx_spi_init(&ofdev->dev, r_mem, r_irq->start,
+		XILINX_SPI_MODEL_DS464, -1, *prop, 8);
+	if (IS_ERR(master))
+		return PTR_ERR(master);
+
+	dev_set_drvdata(&ofdev->dev, master);
+
+	/* Add any subnodes on the SPI bus */
+	of_register_spi_devices(master, ofdev->node);
+
+	return 0;
+}
+
+static int __devexit xilinx_spi_remove(struct of_device *ofdev)
+{
+	xilinx_spi_deinit(dev_get_drvdata(&ofdev->dev));
+	dev_set_drvdata(&ofdev->dev, 0);
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" XILINX_SPI_NAME);
+
+static int __exit xilinx_spi_of_remove(struct of_device *op)
+{
+	return xilinx_spi_remove(op);
+}
+
+static struct of_device_id xilinx_spi_of_match[] =3D {
+	{ .compatible =3D "xlnx,xps-spi-2.00.a", },
+	{ .compatible =3D "xlnx,xps-spi-2.00.b", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
+
+static struct of_platform_driver xilinx_spi_of_driver =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D "xilinx-xps-spi",
+	.match_table =3D xilinx_spi_of_match,
+	.probe =3D xilinx_spi_of_probe,
+	.remove =3D __exit_p(xilinx_spi_of_remove),
+	.driver =3D {
+		.name =3D "xilinx-xps-spi",
+		.owner =3D THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_of_init(void)
+{
+	return of_register_platform_driver(&xilinx_spi_of_driver);
+}
+module_init(xilinx_spi_of_init);
+
+static void __exit xilinx_spi_of_exit(void)
+{
+	of_unregister_platform_driver(&xilinx_spi_of_driver);
+}
+module_exit(xilinx_spi_of_exit);
+MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
+MODULE_DESCRIPTION("Xilinx SPI driver");
+MODULE_LICENSE("GPL");
+
Index: linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi.c	(revision 909)
+++ linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi.c	(revision 912)
@@ -14,22 +14,79 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>

-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-#include <linux/of_spi.h>
-
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/io.h>

-#define XILINX_SPI_NAME "xilinx_spi"
+#include "xilinx_spi.h"

+struct xilinx_spi {
+	/* bitbang has to be first */
+	struct spi_bitbang bitbang;
+	struct completion done;
+	struct resource mem; /* phys mem */
+	void __iomem	*regs;	/* virt. address of the control registers */
+	u32 irq;
+	u8 *rx_ptr;		/* pointer in the Tx buffer */
+	const u8 *tx_ptr;	/* pointer in the Rx buffer */
+	int remaining_bytes;	/* the number of bytes left to transfer */
+	/* offset to the XSPI regs, these might vary... */
+	u8 cr_offset;
+	u8 sr_offset;
+	u8 txd_offset;
+	u8 rxd_offset;
+	u8 ssr_offset;
+	u8 bits_per_word;
+	u8 model;
+};
+
+#ifndef CONFIG_PPC
+#define in_8(addr) ioread8(addr)
+#define in_be16(addr) ioread16(addr)
+#define in_be32(addr) ioread32(addr)
+
+#define out_8(addr, b) iowrite8(b, addr)
+#define out_be16(addr, w) iowrite16(w, addr)
+#define out_be32(addr, l) iowrite32(l, addr)
+#endif
+
+#define XSPI_WRITE8(xspi, offs, val) \
+	do { \
+		if (xspi->model =3D=3D XILINX_SPI_MODEL_DS464) \
+			out_8(xspi->regs + offs, (val) & 0xff); \
+		else \
+			XSPI_WRITE32(xspi, offs, val); \
+	} while (0)
+
+#define XSPI_WRITE16(xspi, offs, val) \
+	do { \
+		if (xspi->model =3D=3D XILINX_SPI_MODEL_DS464) \
+			out_be16(xspi->regs + offs, (val) & 0xffff); \
+		else \
+			XSPI_WRITE32(xspi, offs, val); \
+	} while (0)
+
+#define XSPI_WRITE32(xspi, offs, val) \
+	out_be32(xspi->regs + offs, val)
+
+#define XSPI_READ8(xspi, offs) \
+	(xspi->model =3D=3D XILINX_SPI_MODEL_DS464) ? \
+		in_8(xspi->regs + offs) : XSPI_READ32(xspi, offs)
+
+#define XSPI_READ16(xspi, offs) \
+	(xspi->model =3D=3D XILINX_SPI_MODEL_DS464) ? \
+	in_be16(xspi->regs + offs) : XSPI_READ32(xspi, offs)
+
+#define XSPI_READ32(xspi, offs) \
+	in_be32(xspi->regs + offs)
+
+
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) =
(v1.00e)
  * Product Specification", DS464
  */
-#define XSPI_CR_OFFSET		0x62	/* 16-bit Control Register */
+#define XSPI_CR_OFFSET_DS464	0x62	/* 16-bit Control Register */
+#define XSPI_CR_OFFSET_DS570	0x60

 #define XSPI_CR_ENABLE		0x02
 #define XSPI_CR_MASTER_MODE	0x04
@@ -40,8 +97,10 @@
 #define XSPI_CR_RXFIFO_RESET	0x40
 #define XSPI_CR_MANUAL_SSELECT	0x80
 #define XSPI_CR_TRANS_INHIBIT	0x100
+#define XSPI_CR_LSB_FIRST	0x200

-#define XSPI_SR_OFFSET		0x67	/* 8-bit Status Register */
+#define XSPI_SR_OFFSET_DS464	0x67	/* 8-bit Status Register */
+#define XSPI_SR_OFFSET_DS570	0x64

 #define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
 #define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
@@ -49,10 +108,13 @@
 #define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
 #define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */

-#define XSPI_TXD_OFFSET		0x6b	/* 8-bit Data Transmit Register */
-#define XSPI_RXD_OFFSET		0x6f	/* 8-bit Data Receive Register */
+#define XSPI_TXD_OFFSET_DS464	0x6b	/* 8-bit Data Transmit Register */
+#define XSPI_TXD_OFFSET_DS570	0x68
+#define XSPI_RXD_OFFSET_DS464	0x6f	/* 8-bit Data Receive Register */
+#define XSPI_RXD_OFFSET_DS570	0x6C

-#define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */
+#define XSPI_SSR_OFFSET_DS464	0x70	/* 32-bit Slave Select Register */
+#define XSPI_SSR_OFFSET_DS570	0x70

 /* Register definitions as per "OPB IPIF (v3.01c) Product Specificatio=
n", DS414
  * IPIF registers are 32 bit
@@ -70,43 +132,27 @@
 #define XSPI_INTR_TX_UNDERRUN		0x08	/* TxFIFO was underrun */
 #define XSPI_INTR_RX_FULL		0x10	/* RxFIFO is full */
 #define XSPI_INTR_RX_OVERRUN		0x20	/* RxFIFO was overrun */
+#define XSPI_INTR_TX_HALF_EMPTY		0x40	/* TxFIFO is half empty */

 #define XIPIF_V123B_RESETR_OFFSET	0x40	/* IPIF reset register */
 #define XIPIF_V123B_RESET_MASK		0x0a	/* the value to write */

-struct xilinx_spi {
-	/* bitbang has to be first */
-	struct spi_bitbang bitbang;
-	struct completion done;
-
-	void __iomem	*regs;	/* virt. address of the control registers */
-
-	u32		irq;
-
-	u32		speed_hz; /* SCK has a fixed frequency of speed_hz Hz */
-
-	u8 *rx_ptr;		/* pointer in the Tx buffer */
-	const u8 *tx_ptr;	/* pointer in the Rx buffer */
-	int remaining_bytes;	/* the number of bytes left to transfer */
-};
-
-static void xspi_init_hw(void __iomem *regs_base)
+static void xspi_init_hw(struct xilinx_spi *xspi)
 {
 	/* Reset the SPI device */
-	out_be32(regs_base + XIPIF_V123B_RESETR_OFFSET,
-		 XIPIF_V123B_RESET_MASK);
+	XSPI_WRITE32(xspi, XIPIF_V123B_RESETR_OFFSET, XIPIF_V123B_RESET_MASK)=
;
 	/* Disable all the interrupts just in case */
-	out_be32(regs_base + XIPIF_V123B_IIER_OFFSET, 0);
+	XSPI_WRITE32(xspi, XIPIF_V123B_IIER_OFFSET, 0);
 	/* Enable the global IPIF interrupt */
-	out_be32(regs_base + XIPIF_V123B_DGIER_OFFSET,
-		 XIPIF_V123B_GINTR_ENABLE);
+	XSPI_WRITE32(xspi, XIPIF_V123B_DGIER_OFFSET, XIPIF_V123B_GINTR_ENABLE=
);
 	/* Deselect the slave on the SPI bus */
-	out_be32(regs_base + XSPI_SSR_OFFSET, 0xffff);
+	XSPI_WRITE32(xspi, xspi->ssr_offset, 0xffff);
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
-	out_be16(regs_base + XSPI_CR_OFFSET,
-		 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT
-		 | XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE);
+	XSPI_WRITE16(xspi, xspi->cr_offset,
+		 XSPI_CR_TRANS_INHIBIT | XSPI_CR_MANUAL_SSELECT |
+		 XSPI_CR_MASTER_MODE | XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |
+		 XSPI_CR_RXFIFO_RESET);
 }

 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
@@ -115,16 +161,16 @@

 	if (is_on =3D=3D BITBANG_CS_INACTIVE) {
 		/* Deselect the slave on the SPI bus */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET, 0xffff);
+		XSPI_WRITE32(xspi, xspi->ssr_offset, 0xffff);
 	} else if (is_on =3D=3D BITBANG_CS_ACTIVE) {
 		/* Set the SPI clock phase and polarity */
-		u16 cr =3D in_be16(xspi->regs + XSPI_CR_OFFSET)
+		u32 cr =3D XSPI_READ16(xspi, xspi->cr_offset)
 			 & ~XSPI_CR_MODE_MASK;
 		if (spi->mode & SPI_CPHA)
 			cr |=3D XSPI_CR_CPHA;
 		if (spi->mode & SPI_CPOL)
 			cr |=3D XSPI_CR_CPOL;
-		out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+		XSPI_WRITE16(xspi, xspi->cr_offset, cr);

 		/* We do not check spi->max_speed_hz here as the SPI clock
 		 * frequency is not software programmable (the IP block design
@@ -132,24 +178,26 @@
 		 */

 		/* Activate the chip select */
-		out_be32(xspi->regs + XSPI_SSR_OFFSET,
+		XSPI_WRITE32(xspi, xspi->ssr_offset,
 			 ~(0x0001 << spi->chip_select));
 	}
 }

 /* spi_bitbang requires custom setup_transfer() to be defined if there=
 is a
  * custom txrx_bufs(). We have nothing to setup here as the SPI IP blo=
ck
- * supports just 8 bits per word, and SPI clock can't be changed in so=
ftware.
- * Check for 8 bits per word. Chip select delay calculations could be
+ * supports 8 or 16 bits per word, which can not be changed in softwar=
e.
+ * SPI clock can't be changed in software.
+ * Check for correct bits per word. Chip select delay calculations cou=
ld be
  * added here as soon as bitbang_work() can be made aware of the delay=
 value.
  */
 static int xilinx_spi_setup_transfer(struct spi_device *spi,
-		struct spi_transfer *t)
+	struct spi_transfer *t)
 {
 	u8 bits_per_word;
+	struct xilinx_spi *xspi =3D spi_master_get_devdata(spi->master);

 	bits_per_word =3D (t) ? t->bits_per_word : spi->bits_per_word;
-	if (bits_per_word !=3D 8) {
+	if (bits_per_word !=3D xspi->bits_per_word) {
 		dev_err(&spi->dev, "%s, unsupported bits_per_word=3D%d\n",
 			__func__, bits_per_word);
 		return -EINVAL;
@@ -160,34 +208,50 @@

 static int xilinx_spi_setup(struct spi_device *spi)
 {
-	struct spi_bitbang *bitbang;
-	struct xilinx_spi *xspi;
-	int retval;
-
-	xspi =3D spi_master_get_devdata(spi->master);
-	bitbang =3D &xspi->bitbang;
-
-	retval =3D xilinx_spi_setup_transfer(spi, NULL);
-	if (retval < 0)
-		return retval;
-
+	/* always return 0, we can not check the number of bits.
+	 * There are cases when SPI setup is called before any driver is
+	 * there, in that case the SPI core defaults to 8 bits, which we
+	 * do not support in some cases. But if we return an error, the
+	 * SPI device would not be registered and no driver can get hold of i=
t
+	 * When the driver is there, it will call SPI setup again with the
+	 * correct number of bits per transfer.
+	 * If a driver setups with the wrong bit number, it will fail when
+	 * it tries to do a transfer
+	 */
 	return 0;
 }

 static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi)
 {
-	u8 sr;
+	u32 sr;
+	u8 wsize;
+	if (xspi->bits_per_word =3D=3D 8)
+		wsize =3D 1;
+	else if (xspi->bits_per_word =3D=3D 16)
+		wsize =3D 2;
+	else
+		wsize =3D 4;

 	/* Fill the Tx FIFO with as many bytes as possible */
-	sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
-	while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0 && xspi->remaining_bytes =
> 0) {
+	sr =3D XSPI_READ8(xspi, xspi->sr_offset);
+	while ((sr & XSPI_SR_TX_FULL_MASK) =3D=3D 0 &&
+		xspi->remaining_bytes > 0) {
 		if (xspi->tx_ptr) {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, *xspi->tx_ptr++);
-		} else {
-			out_8(xspi->regs + XSPI_TXD_OFFSET, 0);
-		}
-		xspi->remaining_bytes--;
-		sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
+			if (wsize =3D=3D 1)
+				XSPI_WRITE8(xspi, xspi->txd_offset,
+					*xspi->tx_ptr);
+			else if (wsize =3D=3D 2)
+				XSPI_WRITE16(xspi, xspi->txd_offset,
+					*(u16 *)(xspi->tx_ptr));
+			else if (wsize =3D=3D 4)
+				XSPI_WRITE32(xspi, xspi->txd_offset,
+					*(u32 *)(xspi->tx_ptr));
+
+			xspi->tx_ptr +=3D wsize;
+		} else
+			XSPI_WRITE8(xspi, xspi->txd_offset, 0);
+		xspi->remaining_bytes -=3D wsize;
+		sr =3D XSPI_READ8(xspi, xspi->sr_offset);
 	}
 }

@@ -195,7 +259,7 @@
 {
 	struct xilinx_spi *xspi =3D spi_master_get_devdata(spi->master);
 	u32 ipif_ier;
-	u16 cr;
+	u32 cr;

 	/* We get here with transmitter inhibited */

@@ -209,23 +273,22 @@
 	/* Enable the transmit empty interrupt, which we use to determine
 	 * progress on the transmission.
 	 */
-	ipif_ier =3D in_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET);
-	out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET,
+	ipif_ier =3D XSPI_READ32(xspi, XIPIF_V123B_IIER_OFFSET);
+	XSPI_WRITE32(xspi, XIPIF_V123B_IIER_OFFSET,
 		 ipif_ier | XSPI_INTR_TX_EMPTY);

 	/* Start the transfer by not inhibiting the transmitter any longer */
-	cr =3D in_be16(xspi->regs + XSPI_CR_OFFSET) & ~XSPI_CR_TRANS_INHIBIT;
-	out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+	cr =3D XSPI_READ16(xspi, xspi->cr_offset) & ~XSPI_CR_TRANS_INHIBIT;
+	XSPI_WRITE16(xspi, xspi->cr_offset, cr);

 	wait_for_completion(&xspi->done);

 	/* Disable the transmit empty interrupt */
-	out_be32(xspi->regs + XIPIF_V123B_IIER_OFFSET, ipif_ier);
+	XSPI_WRITE32(xspi, XIPIF_V123B_IIER_OFFSET, ipif_ier);

 	return t->len - xspi->remaining_bytes;
 }

-
 /* This driver supports single master mode only. Hence Tx FIFO Empty
  * is the only interrupt we care about.
  * Receive FIFO Overrun, Transmit FIFO Underrun, Mode Fault, and Slave=
 Mode
@@ -237,32 +300,50 @@
 	u32 ipif_isr;

 	/* Get the IPIF interrupts, and clear them immediately */
-	ipif_isr =3D in_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET);
-	out_be32(xspi->regs + XIPIF_V123B_IISR_OFFSET, ipif_isr);
+	ipif_isr =3D XSPI_READ32(xspi, XIPIF_V123B_IISR_OFFSET);
+	XSPI_WRITE32(xspi, XIPIF_V123B_IISR_OFFSET, ipif_isr);

 	if (ipif_isr & XSPI_INTR_TX_EMPTY) {	/* Transmission completed */
-		u16 cr;
-		u8 sr;
+		u32 cr;
+		u32 sr;
+		u8 rsize;
+		if (xspi->bits_per_word =3D=3D 8)
+			rsize =3D 1;
+		else if (xspi->bits_per_word =3D=3D 16)
+			rsize =3D 2;
+		else
+			rsize =3D 4;

 		/* A transmit has just completed. Process received data and
 		 * check for more data to transmit. Always inhibit the
 		 * transmitter while the Isr refills the transmit register/FIFO,
 		 * or make sure it is stopped if we're done.
 		 */
-		cr =3D in_be16(xspi->regs + XSPI_CR_OFFSET);
-		out_be16(xspi->regs + XSPI_CR_OFFSET,
-			 cr | XSPI_CR_TRANS_INHIBIT);
+		cr =3D XSPI_READ16(xspi, xspi->cr_offset);
+		XSPI_WRITE16(xspi, xspi->cr_offset, cr | XSPI_CR_TRANS_INHIBIT);

 		/* Read out all the data from the Rx FIFO */
-		sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
+		sr =3D XSPI_READ8(xspi, xspi->sr_offset);
 		while ((sr & XSPI_SR_RX_EMPTY_MASK) =3D=3D 0) {
-			u8 data;
+			u32 data;
+			if (rsize =3D=3D 1)
+				data =3D XSPI_READ8(xspi, xspi->rxd_offset);
+			else if (rsize =3D=3D 2)
+				data =3D XSPI_READ16(xspi, xspi->rxd_offset);
+			else
+				data =3D XSPI_READ32(xspi, xspi->rxd_offset);

-			data =3D in_8(xspi->regs + XSPI_RXD_OFFSET);
 			if (xspi->rx_ptr) {
-				*xspi->rx_ptr++ =3D data;
+				if (rsize =3D=3D 1)
+					*xspi->rx_ptr =3D data & 0xff;
+				else if (rsize =3D=3D 2)
+					*(u16 *)(xspi->rx_ptr) =3D data & 0xffff;
+				else
+					*((u32 *)(xspi->rx_ptr)) =3D data;
+				xspi->rx_ptr +=3D rsize;
 			}
-			sr =3D in_8(xspi->regs + XSPI_SR_OFFSET);
+
+			sr =3D XSPI_READ8(xspi, xspi->sr_offset);
 		}

 		/* See if there is more data to send */
@@ -271,7 +352,7 @@
 			/* Start the transfer by not inhibiting the
 			 * transmitter any longer
 			 */
-			out_be16(xspi->regs + XSPI_CR_OFFSET, cr);
+			XSPI_WRITE16(xspi, xspi->cr_offset, cr);
 		} else {
 			/* No more data to send.
 			 * Indicate the transfer is completed.
@@ -279,45 +360,21 @@
 			complete(&xspi->done);
 		}
 	}
-
 	return IRQ_HANDLED;
 }

-static int __init xilinx_spi_of_probe(struct of_device *ofdev,
-					const struct of_device_id *match)
+struct spi_master *xilinx_spi_init(struct device *dev, struct resource=
 *mem,
+	u32 irq, u8 model, s16 bus_num, u16 num_chipselect, u8 bits_per_word)
 {
 	struct spi_master *master;
 	struct xilinx_spi *xspi;
-	struct resource r_irq_struct;
-	struct resource r_mem_struct;
+	int ret =3D 0;

-	struct resource *r_irq =3D &r_irq_struct;
-	struct resource *r_mem =3D &r_mem_struct;
-	int rc =3D 0;
-	const u32 *prop;
-	int len;
+	master =3D spi_alloc_master(dev, sizeof(struct xilinx_spi));

-	/* Get resources(memory, IRQ) associated with the device */
-	master =3D spi_alloc_master(&ofdev->dev, sizeof(struct xilinx_spi));
+	if (master =3D=3D NULL)
+		return ERR_PTR(-ENOMEM);

-	if (master =3D=3D NULL) {
-		return -ENOMEM;
-	}
-
-	dev_set_drvdata(&ofdev->dev, master);
-
-	rc =3D of_address_to_resource(ofdev->node, 0, r_mem);
-	if (rc) {
-		dev_warn(&ofdev->dev, "invalid address\n");
-		goto put_master;
-	}
-
-	rc =3D of_irq_to_resource(ofdev->node, 0, r_irq);
-	if (rc =3D=3D NO_IRQ) {
-		dev_warn(&ofdev->dev, "no IRQ found\n");
-		goto put_master;
-	}
-
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits =3D SPI_CPOL | SPI_CPHA;

@@ -329,128 +386,87 @@
 	xspi->bitbang.master->setup =3D xilinx_spi_setup;
 	init_completion(&xspi->done);

-	xspi->irq =3D r_irq->start;
-
-	if (!request_mem_region(r_mem->start,
-			r_mem->end - r_mem->start + 1, XILINX_SPI_NAME)) {
-		rc =3D -ENXIO;
-		dev_warn(&ofdev->dev, "memory request failure\n");
+	if (!request_mem_region(mem->start, resource_size(mem),
+		XILINX_SPI_NAME)) {
+		ret =3D -ENXIO;
 		goto put_master;
 	}

-	xspi->regs =3D ioremap(r_mem->start, r_mem->end - r_mem->start + 1);
+	xspi->regs =3D ioremap(mem->start, resource_size(mem));
 	if (xspi->regs =3D=3D NULL) {
-		rc =3D -ENOMEM;
-		dev_warn(&ofdev->dev, "ioremap failure\n");
-		goto release_mem;
+		ret =3D -ENOMEM;
+		dev_warn(dev, "ioremap failure\n");
+		goto map_failed;
 	}
-	xspi->irq =3D r_irq->start;

-	/* dynamic bus assignment */
-	master->bus_num =3D -1;
+	master->bus_num =3D bus_num;
+	master->num_chipselect =3D num_chipselect;

-	/* number of slave select bits is required */
-	prop =3D of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
-	if (!prop || len < sizeof(*prop)) {
-		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
-		goto unmap_io;
+	xspi->mem =3D *mem;
+	xspi->irq =3D irq;
+	xspi->bits_per_word =3D bits_per_word;
+	xspi->model =3D model;
+
+	if (model =3D=3D XILINX_SPI_MODEL_DS464) {
+		xspi->cr_offset =3D XSPI_CR_OFFSET_DS464;
+		xspi->sr_offset =3D XSPI_SR_OFFSET_DS464;
+		xspi->txd_offset =3D XSPI_TXD_OFFSET_DS464;
+		xspi->rxd_offset =3D XSPI_RXD_OFFSET_DS464;
+		xspi->ssr_offset =3D XSPI_SSR_OFFSET_DS464;
+	} else {
+		xspi->cr_offset =3D XSPI_CR_OFFSET_DS570;
+		xspi->sr_offset =3D XSPI_SR_OFFSET_DS570;
+		xspi->txd_offset =3D XSPI_TXD_OFFSET_DS570;
+		xspi->rxd_offset =3D XSPI_RXD_OFFSET_DS570;
+		xspi->ssr_offset =3D XSPI_SSR_OFFSET_DS570;
 	}
-	master->num_chipselect =3D *prop;

 	/* SPI controller initializations */
-	xspi_init_hw(xspi->regs);
+	xspi_init_hw(xspi);

 	/* Register for SPI Interrupt */
-	rc =3D request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xsp=
i);
-	if (rc !=3D 0) {
-		dev_warn(&ofdev->dev, "irq request failure: %d\n", xspi->irq);
+	ret =3D request_irq(xspi->irq, xilinx_spi_irq, 0, XILINX_SPI_NAME, xs=
pi);
+	if (ret !=3D 0)
 		goto unmap_io;
-	}

-	rc =3D spi_bitbang_start(&xspi->bitbang);
-	if (rc !=3D 0) {
-		dev_err(&ofdev->dev, "spi_bitbang_start FAILED\n");
+	ret =3D spi_bitbang_start(&xspi->bitbang);
+	if (ret !=3D 0) {
+		dev_err(dev, "spi_bitbang_start FAILED\n");
 		goto free_irq;
 	}

-	dev_info(&ofdev->dev, "at 0x%08X mapped to 0x%08X, irq=3D%d\n",
-			(unsigned int)r_mem->start, (u32)xspi->regs, xspi->irq);
+	dev_info(dev, "at 0x%08X mapped to 0x%08X, irq=3D%d\n",
+		(u32)mem->start, (u32)xspi->regs, xspi->irq);
+	return master;

-	/* Add any subnodes on the SPI bus */
-	of_register_spi_devices(master, ofdev->node);
-
-	return rc;
-
 free_irq:
 	free_irq(xspi->irq, xspi);
 unmap_io:
 	iounmap(xspi->regs);
-release_mem:
-	release_mem_region(r_mem->start, resource_size(r_mem));
+map_failed:
+	release_mem_region(mem->start, resource_size(mem));
 put_master:
 	spi_master_put(master);
-	return rc;
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL(xilinx_spi_init);

-static int __devexit xilinx_spi_remove(struct of_device *ofdev)
+void xilinx_spi_deinit(struct spi_master *master)
 {
 	struct xilinx_spi *xspi;
-	struct spi_master *master;
-	struct resource r_mem;

-	master =3D platform_get_drvdata(ofdev);
 	xspi =3D spi_master_get_devdata(master);

 	spi_bitbang_stop(&xspi->bitbang);
 	free_irq(xspi->irq, xspi);
 	iounmap(xspi->regs);
-	if (!of_address_to_resource(ofdev->node, 0, &r_mem))
-		release_mem_region(r_mem.start, resource_size(&r_mem));
-	dev_set_drvdata(&ofdev->dev, 0);
+
+	release_mem_region(xspi->mem.start, resource_size(&xspi->mem));
 	spi_master_put(xspi->bitbang.master);
-
-	return 0;
 }
+EXPORT_SYMBOL(xilinx_spi_deinit);

-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:" XILINX_SPI_NAME);
-
-static int __exit xilinx_spi_of_remove(struct of_device *op)
-{
-	return xilinx_spi_remove(op);
-}
-
-static struct of_device_id xilinx_spi_of_match[] =3D {
-	{ .compatible =3D "xlnx,xps-spi-2.00.a", },
-	{ .compatible =3D "xlnx,xps-spi-2.00.b", },
-	{}
-};
-
-MODULE_DEVICE_TABLE(of, xilinx_spi_of_match);
-
-static struct of_platform_driver xilinx_spi_of_driver =3D {
-	.owner =3D THIS_MODULE,
-	.name =3D "xilinx-xps-spi",
-	.match_table =3D xilinx_spi_of_match,
-	.probe =3D xilinx_spi_of_probe,
-	.remove =3D __exit_p(xilinx_spi_of_remove),
-	.driver =3D {
-		.name =3D "xilinx-xps-spi",
-		.owner =3D THIS_MODULE,
-	},
-};
-
-static int __init xilinx_spi_init(void)
-{
-	return of_register_platform_driver(&xilinx_spi_of_driver);
-}
-module_init(xilinx_spi_init);
-
-static void __exit xilinx_spi_exit(void)
-{
-	of_unregister_platform_driver(&xilinx_spi_of_driver);
-}
-module_exit(xilinx_spi_exit);
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
 MODULE_DESCRIPTION("Xilinx SPI driver");
 MODULE_LICENSE("GPL");
+
Index: linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_pltfm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_pltfm.c	(revision 0)
+++ linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_pltfm.c	(revision 912)
@@ -0,0 +1,104 @@
+/*
+ * xilinx_spi_pltfm.c Support for Xilinx SPI platform devices
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * Xilinx SPI devices as platform devices
+ *
+ * Inspired by xilinx_spi.c, 2002-2007 (c) MontaVista Software, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/spi/xilinx_spi.h>
+
+#include "xilinx_spi.h"
+
+static int __init xilinx_spi_probe(struct platform_device *dev)
+{
+	struct xspi_platform_data *pdata;
+	struct resource *r;
+	int irq;
+	struct spi_master *master;
+	u8 i;
+
+	pdata =3D dev->dev.platform_data;
+	if (pdata =3D=3D NULL)
+		return -ENODEV;
+
+	r =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r =3D=3D NULL)
+		return -ENODEV;
+
+	irq =3D platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	master =3D xilinx_spi_init(&dev->dev, r, irq, pdata->model,
+		pdata->bus_num, pdata->num_chipselect, pdata->bits_per_word);
+	if (IS_ERR(master))
+		return PTR_ERR(master);
+
+	for (i =3D 0; i < pdata->num_devices; i++)
+		spi_new_device(master, pdata->devices + i);
+
+	platform_set_drvdata(dev, master);
+	return 0;
+}
+
+static int __devexit xilinx_spi_remove(struct platform_device *dev)
+{
+	xilinx_spi_deinit(platform_get_drvdata(dev));
+	platform_set_drvdata(dev, 0);
+
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" XILINX_SPI_NAME);
+
+static struct platform_driver xilinx_spi_driver =3D {
+	.probe	=3D xilinx_spi_probe,
+	.remove	=3D __devexit_p(xilinx_spi_remove),
+	.driver =3D {
+		.name =3D XILINX_SPI_NAME,
+		.owner =3D THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_pltfm_init(void)
+{
+	return platform_driver_register(&xilinx_spi_driver);
+}
+module_init(xilinx_spi_pltfm_init);
+
+static void __exit xilinx_spi_pltfm_exit(void)
+{
+	platform_driver_unregister(&xilinx_spi_driver);
+}
+module_exit(xilinx_spi_pltfm_exit);
+
+MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
+MODULE_DESCRIPTION("Xilinx SPI platform driver");
+MODULE_LICENSE("GPL v2");
+
Index: linux-2.6.30-rc7-spi/drivers/spi/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7-spi/drivers/spi/Makefile	(revision 909)
+++ linux-2.6.30-rc7-spi/drivers/spi/Makefile	(revision 912)
@@ -29,6 +29,8 @@
 obj-$(CONFIG_SPI_S3C24XX)		+=3D spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+=3D spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+=3D xilinx_spi.o
+obj-$(CONFIG_SPI_XILINX_OF)		+=3D xilinx_spi_of.o
+obj-$(CONFIG_SPI_XILINX_PLTFM)		+=3D xilinx_spi_pltfm.o
 obj-$(CONFIG_SPI_SH_SCI)		+=3D spi_sh_sci.o
 # 	... add above this line ...

Index: linux-2.6.30-rc7-spi/include/linux/spi/xilinx_spi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7-spi/include/linux/spi/xilinx_spi.h	(revision 0)
+++ linux-2.6.30-rc7-spi/include/linux/spi/xilinx_spi.h	(revision 912)
@@ -0,0 +1,19 @@
+#ifndef __LINUX_SPI_XILINX_SPI_H
+#define __LINUX_SPI_XILINX_SPI_H
+
+#define XILINX_SPI_MODEL_DS464 0
+#define XILINX_SPI_MODEL_DS570 1
+
+/* SPI Controller IP */
+struct xspi_platform_data {
+	s16 bus_num;
+	u16 num_chipselect;
+	u8 model;
+	u8 bits_per_word;
+	/* devices to add to the bus when the host is up */
+	struct spi_board_info *devices;
+	u8 num_devices;
+};
+
+#endif /* __LINUX_SPI_XILINX_SPI_H */
+
