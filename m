From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] spi: add driver for BCM2835
Date: Tue,  5 Mar 2013 19:49:02 -0700
Message-ID: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>

The BCM2835 contains two forms of SPI master controller (one known
simply as SPI0, and the other known as the "Universal SPI Master", in
the auxilliary block) and one form of SPI slave controller. This patch
adds support for the SPI0 controller.

This driver is taken from Chris Boot's repository at
git://github.com/bootc/linux.git rpi-linear
as of commit 6de2905 "spi-bcm2708: fix printf with spurious %s".
In the first SPI-related commit there, Chris wrote:

Thanks to csoutreach / A Robinson for his driver which I used as an
inspiration. You can find his version here:
http://piface.openlx.org.uk/raspberry-pi-spi-kernel-driver-available-for

Changes made during upstreaming:
* Renamed bcm2708 to bcm2835 as per upstream naming for this SoC.
* Wrote device tree binding documentation.
* Request unnamed clock rather than "sys_pclk"; the DT will provide the
  correct clock.
* Assume that tfr->speed_hz and tfr->bits_per_word are always set in
  bcm2835_spi_start_transfer(), bcm2835_spi_transfer_one(), so no need
  to check spi->speed_hz or tft->bits_per_word.
* Re-ordered probe() to remove the need for temporary variables.
* Don't use devm_request_irq(), to ensure that the IRQ doesn't fire after
  we've torn down the device, but not unhooked the IRQ.
* Removed empty prepare/unprepare implementations.
* Removed use of devinit/devexit.
* Added BCM2835_ prefix to defines.

Signed-off-by: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>
Signed-off-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 .../devicetree/bindings/spi/brcm,bcm2835-spi.txt   |   26 ++
 drivers/spi/Kconfig                                |   11 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm2835.c                          |  430 ++++++++++++++++++++
 4 files changed, 468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
 create mode 100644 drivers/spi/spi-bcm2835.c

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
new file mode 100644
index 0000000..3f54bc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
@@ -0,0 +1,26 @@
+Broadcom BCM2835 SPI0 controller
+
+The BCM2835 contains two forms of SPI master controller, one known simply as
+SPI0, and the other known as the "Universal SPI Master"; part of the
+auxilliary block. This binding applies to the SPI0 controller.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-spi".
+- reg: Should contain register location and length.
+- interrupts: Should contain interrupt.
+- clocks: The clock feeding the SPI controller.
+
+Optional properties:
+- brcm,realtime: Boolean. Indicates the driver should operate with realtime
+  priority to minimise the transfer latency on the bus.
+
+Example:
+
+spi@20204000 {
+	compatible = "brcm,bcm2835-spi";
+	reg = <0x7e204000 0x1000>;
+	interrupts = <2 22>;
+	clocks = <&clk_spi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f80eee7..32b85d4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -74,6 +74,17 @@ config SPI_ATMEL
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.
 
+config SPI_BCM2835
+	tristate "BCM2835 SPI controller"
+	depends on ARCH_BCM2835
+	help
+	  This selects a driver for the Broadcom BCM2835 SPI master.
+
+	  The BCM2835 contains two types of SPI master controller; the
+	  "universal SPI master", and the regular SPI controller. This driver
+	  is for the regular SPI controller. Slave mode operation is not also
+	  not supported.
+
 config SPI_BFIN5XX
 	tristate "SPI controller driver for ADI Blackfin5xx"
 	depends on BLACKFIN
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e53c309..3ce1d08 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
+obj-$(CONFIG_SPI_BCM2835)		+= spi-bcm2835.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
 obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
new file mode 100644
index 0000000..74fefeb
--- /dev/null
+++ b/drivers/spi/spi-bcm2835.c
@@ -0,0 +1,430 @@
+/*
+ * Driver for Broadcom BCM2835 SPI Controllers
+ *
+ * Copyright (C) 2012 Chris Boot
+ * Copyright (C) 2012 Stephen Warren
+ *
+ * This driver is inspired by:
+ * spi-ath79.c, Copyright (C) 2009-2011 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
+ * spi-atmel.c, Copyright (C) 2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+/* SPI register offsets */
+#define BCM2835_SPI_CS			0x00
+#define BCM2835_SPI_FIFO		0x04
+#define BCM2835_SPI_CLK			0x08
+#define BCM2835_SPI_DLEN		0x0c
+#define BCM2835_SPI_LTOH		0x10
+#define BCM2835_SPI_DC			0x14
+
+/* Bitfields in CS */
+#define BCM2835_SPI_CS_LEN_LONG		0x02000000
+#define BCM2835_SPI_CS_DMA_LEN		0x01000000
+#define BCM2835_SPI_CS_CSPOL2		0x00800000
+#define BCM2835_SPI_CS_CSPOL1		0x00400000
+#define BCM2835_SPI_CS_CSPOL0		0x00200000
+#define BCM2835_SPI_CS_RXF		0x00100000
+#define BCM2835_SPI_CS_RXR		0x00080000
+#define BCM2835_SPI_CS_TXD		0x00040000
+#define BCM2835_SPI_CS_RXD		0x00020000
+#define BCM2835_SPI_CS_DONE		0x00010000
+#define BCM2835_SPI_CS_LEN		0x00002000
+#define BCM2835_SPI_CS_REN		0x00001000
+#define BCM2835_SPI_CS_ADCS		0x00000800
+#define BCM2835_SPI_CS_INTR		0x00000400
+#define BCM2835_SPI_CS_INTD		0x00000200
+#define BCM2835_SPI_CS_DMAEN		0x00000100
+#define BCM2835_SPI_CS_TA		0x00000080
+#define BCM2835_SPI_CS_CSPOL		0x00000040
+#define BCM2835_SPI_CS_CLEAR_RX		0x00000020
+#define BCM2835_SPI_CS_CLEAR_TX		0x00000010
+#define BCM2835_SPI_CS_CPOL		0x00000008
+#define BCM2835_SPI_CS_CPHA		0x00000004
+#define BCM2835_SPI_CS_CS_10		0x00000002
+#define BCM2835_SPI_CS_CS_01		0x00000001
+
+#define BCM2835_SPI_TIMEOUT_MS	150
+#define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS)
+
+#define DRV_NAME	"spi-bcm2835"
+
+struct bcm2835_spi {
+	void __iomem *regs;
+	struct clk *clk;
+	int irq;
+	struct completion done;
+	const u8 *tx_buf;
+	u8 *rx_buf;
+	int len;
+};
+
+static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
+{
+	return readl(bs->regs + reg);
+}
+
+static inline void bcm2835_wr(struct bcm2835_spi *bs, unsigned reg, u32 val)
+{
+	writel(val, bs->regs + reg);
+}
+
+static inline void bcm2835_rd_fifo(struct bcm2835_spi *bs, int len)
+{
+	u8 byte;
+
+	while (len--) {
+		byte = bcm2835_rd(bs, BCM2835_SPI_FIFO);
+		if (bs->rx_buf)
+			*bs->rx_buf++ = byte;
+	}
+}
+
+static inline void bcm2835_wr_fifo(struct bcm2835_spi *bs, int len)
+{
+	u8 byte;
+
+	if (len > bs->len)
+		len = bs->len;
+
+	while (len--) {
+		byte = bs->tx_buf ? *bs->tx_buf++ : 0;
+		bcm2835_wr(bs, BCM2835_SPI_FIFO, byte);
+		bs->len--;
+	}
+}
+
+static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_master *master = dev_id;
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+
+	if (cs & BCM2835_SPI_CS_DONE) {
+		if (bs->len) { /* first interrupt in a transfer */
+			/* fill the TX fifo with up to 16 bytes */
+			bcm2835_wr_fifo(bs, 16);
+		} else { /* transfer complete */
+			/* disable SPI interrupts */
+			cs &= ~(BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD);
+			bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+
+			/* wake up our bh */
+			complete(&bs->done);
+		}
+	} else if (cs & BCM2835_SPI_CS_RXR) {
+		/* read 12 bytes of data */
+		bcm2835_rd_fifo(bs, 12);
+
+		/* write up to 12 bytes */
+		bcm2835_wr_fifo(bs, 12);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int bcm2835_spi_check_transfer(struct spi_device *spi,
+		struct spi_transfer *tfr)
+{
+	/* tfr==NULL when called from bcm2835_spi_setup() */
+	u32 bpw = tfr ? tfr->bits_per_word : spi->bits_per_word;
+
+	switch (bpw) {
+	case 8:
+		break;
+	default:
+		dev_err(&spi->dev, "unsupported bits_per_word=%d\n", bpw);
+		return -EINVAL;
+	}
+
+	if (!(spi->mode & SPI_NO_CS) &&
+			(spi->chip_select > spi->master->num_chipselect)) {
+		dev_err(&spi->dev,
+				"invalid chipselect %u\n",
+				spi->chip_select);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bcm2835_spi_start_transfer(struct spi_device *spi,
+		struct spi_transfer *tfr)
+{
+	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
+	unsigned long spi_hz, clk_hz, cdiv;
+	u32 cs = BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD | BCM2835_SPI_CS_TA;
+
+	spi_hz = tfr->speed_hz;
+	clk_hz = clk_get_rate(bs->clk);
+
+	if (spi_hz >= clk_hz / 2) {
+		cdiv = 2; /* clk_hz/2 is the fastest we can go */
+	} else if (spi_hz) {
+		/* CDIV must be a power of two */
+		cdiv = roundup_pow_of_two(DIV_ROUND_UP(clk_hz, spi_hz));
+
+		if (cdiv >= 65536)
+			cdiv = 0; /* 0 is the slowest we can go */
+	} else
+		cdiv = 0; /* 0 is the slowest we can go */
+
+	if (spi->mode & SPI_CPOL)
+		cs |= BCM2835_SPI_CS_CPOL;
+	if (spi->mode & SPI_CPHA)
+		cs |= BCM2835_SPI_CS_CPHA;
+
+	if (!(spi->mode & SPI_NO_CS)) {
+		if (spi->mode & SPI_CS_HIGH) {
+			cs |= BCM2835_SPI_CS_CSPOL;
+			cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
+		}
+
+		cs |= spi->chip_select;
+	}
+
+	INIT_COMPLETION(bs->done);
+	bs->tx_buf = tfr->tx_buf;
+	bs->rx_buf = tfr->rx_buf;
+	bs->len = tfr->len;
+
+	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+
+	return 0;
+}
+
+static int bcm2835_spi_finish_transfer(struct spi_device *spi,
+		struct spi_transfer *tfr, bool cs_change)
+{
+	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+
+	/* drain RX FIFO */
+	while (cs & BCM2835_SPI_CS_RXD) {
+		bcm2835_rd_fifo(bs, 1);
+		cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+	}
+
+	if (tfr->delay_usecs)
+		udelay(tfr->delay_usecs);
+
+	if (cs_change)
+		/* clear TA flag */
+		bcm2835_wr(bs, BCM2835_SPI_CS, cs & ~BCM2835_SPI_CS_TA);
+
+	return 0;
+}
+
+static int bcm2835_spi_setup(struct spi_device *spi)
+{
+	int ret;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~BCM2835_SPI_MODE_BITS) {
+		dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
+				spi->mode & ~BCM2835_SPI_MODE_BITS);
+		return -EINVAL;
+	}
+
+	ret = bcm2835_spi_check_transfer(spi, NULL);
+	if (ret) {
+		dev_err(&spi->dev, "setup: invalid message\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bcm2835_spi_transfer_one(struct spi_master *master,
+		struct spi_message *mesg)
+{
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	struct spi_transfer *tfr;
+	struct spi_device *spi = mesg->spi;
+	int err = 0;
+	unsigned int timeout;
+	bool cs_change;
+
+	list_for_each_entry(tfr, &mesg->transfers, transfer_list) {
+		err = bcm2835_spi_check_transfer(spi, tfr);
+		if (err)
+			goto out;
+
+		err = bcm2835_spi_start_transfer(spi, tfr);
+		if (err)
+			goto out;
+
+		timeout = wait_for_completion_timeout(&bs->done,
+				msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS));
+		if (!timeout) {
+			err = -ETIMEDOUT;
+			goto out;
+		}
+
+		cs_change = tfr->cs_change ||
+			list_is_last(&tfr->transfer_list, &mesg->transfers);
+
+		err = bcm2835_spi_finish_transfer(spi, tfr, cs_change);
+		if (err)
+			goto out;
+
+		mesg->actual_length += (tfr->len - bs->len);
+	}
+
+out:
+	mesg->status = err;
+	spi_finalize_current_message(master);
+
+	return 0;
+}
+
+static int bcm2835_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct bcm2835_spi *bs;
+	struct resource *res;
+	int err;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
+	if (!master) {
+		dev_err(&pdev->dev, "spi_alloc_master() failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, master);
+
+	master->mode_bits = BCM2835_SPI_MODE_BITS;
+	master->bus_num = -1;
+	master->num_chipselect = 3;
+	master->setup = bcm2835_spi_setup;
+	master->transfer_one_message = bcm2835_spi_transfer_one;
+	master->dev.of_node = pdev->dev.of_node;
+	master->rt = of_property_read_bool(pdev->dev.of_node, "brcm,realtime");
+
+	bs = spi_master_get_devdata(master);
+
+	init_completion(&bs->done);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "could not get memory resource\n");
+		err = -ENODEV;
+		goto out_master_put;
+	}
+
+	bs->regs = devm_request_and_ioremap(&pdev->dev, res);
+	if (!bs->regs) {
+		dev_err(&pdev->dev, "could not request/map memory region\n");
+		err = -ENODEV;
+		goto out_master_put;
+	}
+
+	bs->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(bs->clk)) {
+		err = PTR_ERR(bs->clk);
+		dev_err(&pdev->dev, "could not get clk: %d\n", err);
+		goto out_master_put;
+	}
+
+	bs->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (bs->irq <= 0) {
+		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
+		err = bs->irq ? bs->irq : -ENODEV;
+		goto out_master_put;
+	}
+
+	err = request_irq(bs->irq, bcm2835_spi_interrupt, 0,
+			dev_name(&pdev->dev), master);
+	if (err) {
+		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
+		goto out_master_put;
+	}
+
+	/* initialise the hardware */
+	clk_prepare_enable(bs->clk);
+	bcm2835_wr(bs, BCM2835_SPI_CS,
+		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
+
+	err = spi_register_master(master);
+	if (err) {
+		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
+		goto out_clk_unprepare;
+	}
+
+	return 0;
+
+out_clk_unprepare:
+	clk_unprepare(bs->clk);
+	free_irq(bs->irq, master);
+out_master_put:
+	spi_master_put(master);
+	return err;
+}
+
+static int bcm2835_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+
+	spi_unregister_master(master);
+	free_irq(bs->irq, master);
+
+	/* reset the hardware and block queue progress */
+	bcm2835_wr(bs, BCM2835_SPI_CS,
+		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
+
+	clk_disable_unprepare(bs->clk);
+	spi_master_put(master);
+
+	return 0;
+}
+
+static const struct of_device_id bcm2835_spi_match[] = {
+	{ .compatible = "brcm,bcm2835-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bcm2835_spi_match);
+
+static struct platform_driver bcm2835_spi_driver = {
+	.driver		= {
+		.name		= DRV_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= bcm2835_spi_match,
+	},
+	.probe		= bcm2835_spi_probe,
+	.remove		= bcm2835_spi_remove,
+};
+module_platform_driver(bcm2835_spi_driver);
+
+MODULE_DESCRIPTION("SPI controller driver for Broadcom BCM2835");
+MODULE_AUTHOR("Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.10.4
