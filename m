From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Subject: [RFT PATCH] SuperH HSPI controller driver.
Date: Mon, 21 Jul 2008 11:07:44 +0200
Message-ID: <20080721090744.GA16714__1694.28207814253$1216631354$gmane$org@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

Here is a very simple driver for the HSPI block on many SuperH processors.
I could only subject it to limited testings, as my sole SPI device here is
a write-only 8bit digital poti.  It seems to do the right thing as far as
I could see on an oscilloscope.

The driver doesn't do DMA and pushes/pops bytes one-at-a-time from/to fifos
(I'm going to fix that at a later time).

Please test and comment!

Thanks,
	Manuel Lauss

---

A simple driver for the HSPI block found on many SuperH processors.

Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
---
 drivers/spi/Kconfig       |    8 +
 drivers/spi/Makefile      |    1 +
 drivers/spi/spi_hspi.c    |  431 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-sh/spi_hspi.h |   13 ++
 4 files changed, 453 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/spi_hspi.c
 create mode 100644 include/asm-sh/spi_hspi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 66ec5d8..1154271 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -100,6 +100,14 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+config SPI_HSPI
+	tristate "SuperH on-chip HSPI controller"
+	depends on SPI_MASTER && SUPERH
+	select SPI_BITBANG
+	help
+	  Driver for the Hitachi HSPI controller core found on various
+	  SuperH processors.
+
 config SPI_IMX
 	tristate "Freescale iMX SPI controller"
 	depends on SPI_MASTER && ARCH_IMX && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 7fca043..3443855 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
+obj-$(CONFIG_SPI_HSPI)			+= spi_hspi.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/spi_hspi.c b/drivers/spi/spi_hspi.c
new file mode 100644
index 0000000..eb8f173
--- /dev/null
+++ b/drivers/spi/spi_hspi.c
@@ -0,0 +1,431 @@
+/*
+ * SuperH on-chip SPI (HSPI) controller driver.
+ *
+ * (c) 2008 Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
+ *
+ * largely based on spi_s3c24xx.
+ *
+ * This program is licensed under the terms outlined in the file COPYING
+ * in the root of this archive.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <asm/clock.h>
+#include <asm/spi_hspi.h>
+
+#define SPCR	0x00			/* control */
+#define SPSR	0x04			/* status */
+#define SPSCR	0x08			/* sys control */
+#define SPTBR	0x0c			/* tx fifo port */
+#define SPRBR	0x10			/* rx fifo port */
+
+#define SPCR_FBS	(1 << 7)	/* CPHA */
+#define SPCR_CLKP	(1 << 6)	/* CPOL */
+#define SPCR_IDIV	(1 << 5)	/* clock prescaler: 4, 32*/
+#define SPCR_CLKMASK	0x1f
+
+#define SPSR_TXFU	(1 << 10)	/* tx fifo full */
+#define SPSR_TXHA	(1 << 9)	/* tx fifo half */
+#define SPSR_TXEM	(1 << 8)	/* tx fifo empty */
+#define SPSR_RXFU	(1 << 7)	/* rx fifo full */
+#define SPSR_RXHA	(1 << 6)	/* rx fifo half */
+#define SPSR_RXEM	(1 << 5)	/* rx fifo empty */
+#define SPSR_RXOO	(1 << 4)	/* rx overrun */
+#define SPSR_RXOW	(1 << 3)	/* rx overrun warning */
+#define SPSR_RXFL	(1 << 2)	/* new rx byte */
+#define SPSR_TXFN	(1 << 1)	/* tx complete */
+#define SPSR_TXFL	(1 << 0)	/* tx buffer not empty */
+
+#define SPSCR_TEIE	(1 << 13)	/* tx fifo empty */
+#define SPSCR_THIE	(1 << 12)	/* tx fifo half full */
+#define SPSCR_RNIE	(1 << 11)	/* rx fifo not-empty */
+#define SPSCR_RHIE	(1 << 10)	/* rx fifo half full */
+#define SPSCR_RFIE	(1 << 9)	/* rx fifo full */
+#define SPSCR_FFEN	(1 << 8)	/* fifo enable */
+#define SPSCR_LMSB	(1 << 7)	/* MSB/LSB first */
+#define SPSCR_CSV	(1 << 6)	/* CS pin polarity */
+#define SPSCR_CSA	(1 << 5)	/* auto CS control enable */
+#define SPSCR_TFIE	(1 << 4)	/* 1-byte-tx'ed int */
+#define SPSCR_ROIE	(1 << 3)	/* rx overflow ints */
+#define SPSCR_RXDE	(1 << 2)	/* rx dma enable */
+#define SPSCR_TXDE	(1 << 1)	/* tx dma enable */
+#define SPSCR_MASL	(1 << 0)	/* master(1) / slave(0) select */
+
+#define SPSCR_IMASK (SPSCR_TEIE | SPSCR_THIE | SPSCR_RNIE | SPSCR_RHIE | \
+		     SPSCR_RFIE | SPSCR_TFIE | SPSCR_ROIE)
+
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+
+#define FIFO_SIZE	8
+
+struct hspi_priv {
+	struct spi_bitbang bitbang;
+	void __iomem *io;
+
+	/* data buffers */
+	const unsigned char	*tx;
+	unsigned char		*rx;
+	int			 len;
+	int			 count;
+
+	unsigned long spcr;
+	unsigned long spscr;
+
+	struct completion done;
+
+	int irq;
+
+	struct device *dev;
+	struct resource *ioarea;
+	struct spi_master *master;
+	struct hspi_platdata *pd;
+};
+
+static inline void hspi_platcs(struct hspi_priv *priv, int cs, int pol)
+{
+	if (priv->pd && priv->pd->set_cs)
+		priv->pd->set_cs(priv->pd, cs, pol);
+}
+
+static inline struct hspi_priv *to_priv(struct spi_device *sdev)
+{
+	return spi_master_get_devdata(sdev->master);
+}
+
+static void hspi_chipsel(struct spi_device *spi, int value)
+{
+	struct hspi_priv *priv = to_priv(spi);
+	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+
+	if (cspol)
+		priv->spscr |= SPSCR_CSV;
+	else
+		priv->spscr &= ~SPSCR_CSV;
+
+	switch (value) {
+	case BITBANG_CS_INACTIVE:
+		if (cspol^1)
+			priv->spscr |= SPSCR_CSV;
+		else
+			priv->spscr &= ~SPSCR_CSV;
+
+		hspi_platcs(priv, spi->chip_select, cspol^1);
+		break;
+
+	case BITBANG_CS_ACTIVE:
+		if (spi->mode & SPI_CPHA)
+			priv->spcr |= SPCR_FBS;
+		else
+			priv->spcr &= ~SPCR_FBS;
+
+		if (spi->mode & SPI_CPOL)
+			priv->spcr |= SPCR_CLKP;
+		else
+			priv->spcr &= ~SPCR_CLKP;
+
+		if (spi->mode & SPI_LSB_FIRST)
+			priv->spscr |= SPSCR_LMSB;
+		else
+			priv->spscr &= ~SPSCR_LMSB;
+
+		hspi_platcs(priv, spi->chip_select, cspol);
+
+		if (cspol)
+			priv->spscr |= SPSCR_CSV;
+		else
+			priv->spscr &= ~SPSCR_CSV;
+
+		break;
+	}
+
+	iowrite32(priv->spcr, priv->io + SPCR);
+	iowrite32(priv->spscr, priv->io + SPSCR);
+}
+
+static int hspi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct hspi_priv *priv = to_priv(spi);
+	struct clk *clk;
+	unsigned int bpw, hz, div;
+
+	bpw = t ? t->bits_per_word : spi->bits_per_word;
+	hz  = t ? t->speed_hz : spi->max_speed_hz;
+
+	if (bpw != 8) {
+		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
+		return -EINVAL;
+	}
+
+	clk = clk_get(NULL, "module_clk");
+	if (!clk)
+		return -EINVAL;
+
+	/* HSPI peripheral clock is module_clk divided by 4 or 32;
+	 * SPI bus clock is HSPI clock prescaled by 2..64.
+	 * spiclk = (module_clk / 4) / (2 .. 64) or
+	 * spiclk = (module_clk / 32) / (2 .. 64)
+	 */
+	div = (clk->rate / 4) / hz;
+	priv->spcr &= ~(SPCR_IDIV | SPCR_CLKMASK);
+
+	if (div < 2)
+		div = 2;
+	if (div > 512)
+		div = 512;	/* hmm, maybe warn? */
+
+	if (div >= 64) {
+		priv->spcr |= SPCR_IDIV;	/* pclk/32 instead of 4 */
+		div /= 8;
+	}
+
+	priv->spcr |= ((div >> 1) - 1) & SPCR_CLKMASK;
+
+	dev_dbg(&spi->dev, "mclk %lu hz %d spcr %08lux\n", clk->rate, hz,
+		priv->spcr);
+
+	clk_put(clk);
+
+	iowrite32(priv->spcr, priv->io + SPCR);
+
+	spin_lock(&priv->bitbang.lock);
+	if (!priv->bitbang.busy) {
+		priv->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
+		/* need to ndelay for 0.5 clocktick ? */
+	}
+	spin_unlock(&priv->bitbang.lock);
+
+	return 0;
+}
+
+static int hspi_setup(struct spi_device *spi)
+{
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
+	return hspi_setupxfer(spi, NULL);
+}
+
+static inline unsigned int priv_txbyte(struct hspi_priv *priv, int count)
+{
+	return priv->tx ? priv->tx[count] : 0;
+}
+
+static int hspi_txrx(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct hspi_priv *priv = to_priv(spi);
+
+	priv->tx = t->tx_buf;
+	priv->rx = t->rx_buf;
+	priv->len = t->len;
+	priv->count = 0;
+
+	/* master mode, FIFO enabled +  some interesting IRQs */	
+	priv->spscr |= SPSCR_FFEN | SPSCR_RNIE | SPSCR_ROIE | SPSCR_MASL;
+	iowrite32(priv->spscr, priv->io + SPSCR);
+
+	/* change the SPCR register contents to trigger a FIFO reset */
+	iowrite32(priv->spcr & ~SPCR_CLKMASK, priv->io + SPCR);
+	iowrite32(priv->spcr, priv->io + SPCR);
+
+	init_completion(&priv->done);
+
+	/* write first byte in TX fifo */
+	iowrite32(priv_txbyte(priv, priv->count), priv->io + SPTBR);
+
+	wait_for_completion(&priv->done);
+
+	iowrite32(0, priv->io + SPSCR);
+	priv->spscr = 0;
+
+	return priv->count;
+}
+
+static irqreturn_t hspi_master_irq(int irq, void *data)
+{
+	struct hspi_priv *priv = data;
+	unsigned long spsr = ioread32(priv->io + SPSR);
+	unsigned int count = priv->count;
+
+	dev_dbg(priv->dev, "spsr %08lux len %d count %d\n", spsr,
+		priv->len, priv->count);
+
+	if (spsr & SPSR_RXOO) {
+		dev_dbg(priv->dev, "RX overrun\n");
+		goto out;
+	}
+
+	if (spsr & SPSR_RXOW)
+		dev_dbg(priv->dev, "RX overrun warning!!\n");
+
+	/* then it's RNIE: RX fifo not empty */
+	priv->count++;
+	if (priv->rx)
+		priv->rx[count] = ioread32(priv->io + SPRBR);
+
+	count++;
+	if (count < priv->len)
+		iowrite32(priv_txbyte(priv, count), priv->io + SPTBR);
+	else {
+out:
+		priv->spscr &= ~SPSCR_IMASK;
+		iowrite32(priv->spscr, priv->io + SPSCR);
+		complete(&priv->done);
+	}
+
+	iowrite32(0, priv->io + SPSR);		/* ack RXOs */
+	return IRQ_HANDLED;
+}
+
+static int __devinit hspi_probe(struct platform_device *pdev)
+{
+	struct hspi_priv *priv;
+	struct resource *r;
+	struct spi_master *master;
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "No MMIO\n");
+		ret = -ENODEV;
+		goto out0;
+	}
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct hspi_priv));
+	if (!master) {
+		dev_err(&pdev->dev, "No memory for spi_master\n");
+		ret = -ENOMEM;
+		goto out0;
+	}
+
+	priv = spi_master_get_devdata(master);
+	memset(priv, 0, sizeof(struct hspi_priv));
+
+	priv->master = master;
+	priv->dev = &pdev->dev;
+	priv->pd = pdev->dev.platform_data;
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ\n");
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	priv->ioarea = request_mem_region(r->start, r->end - r->start,
+					  pdev->name);
+	if (!priv->ioarea) {
+		dev_err(&pdev->dev, "MMIO alread in use\n");
+		ret = -EBUSY;
+		goto out1;
+	}
+
+	priv->io = ioremap(r->start, r->end - r->start + 1);
+	if (!priv->io) {
+		dev_err(&pdev->dev, "cannot ioremap mmio\n");
+		ret = -EBUSY;
+		goto out2;
+	}
+
+	iowrite32(0, priv->io + SPCR);
+	iowrite32(0, priv->io + SPSCR);
+	iowrite32(0, priv->io + SPSR);
+
+	ret = request_irq(priv->irq, hspi_master_irq, 0, pdev->name, priv);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot grab IRQ\n");
+		goto out3;
+	}
+
+	master->num_chipselect = priv->pd ? priv->pd->num_cs : 1;
+	master->bus_num = pdev->id;
+	master->setup = hspi_setup;
+
+	priv->bitbang.master = master;
+	priv->bitbang.setup_transfer = hspi_setupxfer;
+	priv->bitbang.chipselect = hspi_chipsel;
+	priv->bitbang.txrx_bufs = hspi_txrx;
+
+	ret = spi_bitbang_start(&priv->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register SPI master\n");
+		goto out4;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+out4:
+	free_irq(priv->irq, priv);
+out3:
+	iounmap(priv->io);
+out2:
+	release_resource(priv->ioarea);
+	kfree(priv->ioarea);
+out1:
+	spi_master_put(priv->master);
+out0:
+	return ret;
+}
+
+static int __devexit hspi_remove(struct platform_device *pdev)
+{
+	struct hspi_priv *priv = platform_get_drvdata(pdev);
+
+	spi_bitbang_stop(&priv->bitbang);
+	iowrite32(0, priv->io + SPCR);
+	iowrite32(0, priv->io + SPSCR);
+	iowrite32(0, priv->io + SPSR);
+	free_irq(priv->irq, priv);
+	iounmap(priv->io);
+	release_resource(priv->ioarea);
+	kfree(priv->ioarea);
+	spi_master_put(priv->master);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver hspi_driver = {
+	.driver = {
+		.name	= "spi_hspi",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hspi_probe,
+	.remove		= hspi_remove,
+};
+
+static int __init hspi_init(void)
+{
+	return platform_driver_register(&hspi_driver);
+}
+
+static void __exit hspi_exit(void)
+{
+	platform_driver_unregister(&hspi_driver);
+}
+
+module_init(hspi_init);
+module_exit(hspi_exit);
+
+MODULE_AUTHOR("Manuel Lauss");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SuperH on-chip SPI (HSPI) Controller driver");
+MODULE_ALIAS("platform:spi_hspi");
diff --git a/include/asm-sh/spi_hspi.h b/include/asm-sh/spi_hspi.h
new file mode 100644
index 0000000..74cb219
--- /dev/null
+++ b/include/asm-sh/spi_hspi.h
@@ -0,0 +1,13 @@
+/*
+ * platform data for spi_hspi driver.
+ */
+
+#ifndef _SPI_HSPI_H_
+#define _SPI_HSPI_H_
+
+struct hspi_platdata {
+	int num_cs;
+	void(*set_cs)(struct hspi_platdata *pd, int cs, int pol);
+};
+
+#endif
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
