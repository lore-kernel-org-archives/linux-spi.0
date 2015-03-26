From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Thu, 26 Mar 2015 11:08:36 +0100
Message-ID: <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561486F6-3580-4884-8A6A-8477D8C3BDC9-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This also allows for GPIO-CS to get used removing the limitation of
2/3 SPI devises on the SPI bus.

Fixes: spi-cs-high with native CS with multiple devices on the spi-bus
resetting the chip selects to "normal" polarity after a finished
transfer.

No other functionality/improvements added.

Tested with the following 4 devices on the spi-bus:
* mcp2515 with native CS
* mcp2515 with gpio CS
* fb_st7735r with native CS
    (plus spi-cs-high via transistor inverting polarity)
* enc28j60 with gpio-CS
Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

---

Note that there is quite a bit of complexity involved to make the native 
CS work correctly.
Also a few future optimizations in the pipeline will only work reliably 
with gpio CS. 

So the question is if we should depreciate native chip-selects for this
driver with one of those future improvements listed below.

Here a list of planned future improvements:
* initially fill the FIFO without triggering an interrupt to do that work
* use polling for "short" transfers (<20us)
* implement DMA for longer transfers (>48 bytes) if tx_dma/rx_dma are set.
* implement can_dma et.al. for dma_mapping of transfers in the framework
* multiple spi_transfers handled in interrupt alone without waking up the
  worker-thread (for some transfers) to reduce context switching
  overheads and the corresponding latencies.

As for testing: I have also tried to test with mmc_spi, but I have not
been able to make that driver work reliably in any recent kernel
versions.
Most of the time I see timeouts - and with lots of different SD-cards...

IIRC the last time I tested it successfully was with 3.12.

So if someone has experience how to make it work on the RPI with a 
recent kernel, please let me know, so that I can extend my setup to add
this device/driver also to my test-scenario to increase diversity of the
test.

Martin

 drivers/spi/spi-bcm2835.c |  212 ++++++++++++++++++++++++++-------------------
 1 file changed, 124 insertions(+), 88 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 3f93718..05be082 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2012 Chris Boot
  * Copyright (C) 2013 Stephen Warren
+ * Copyright (C) 2015 Martin Sperl
  *
  * This driver is inspired by:
  * spi-ath79.c, Copyright (C) 2009-2011 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
@@ -29,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
@@ -76,10 +78,10 @@ struct bcm2835_spi {
 	void __iomem *regs;
 	struct clk *clk;
 	int irq;
-	struct completion done;
 	const u8 *tx_buf;
 	u8 *rx_buf;
-	int len;
+	int tx_len;
+	int rx_len;
 };
 
 static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
@@ -96,10 +98,12 @@ static inline void bcm2835_rd_fifo(struct bcm2835_spi *bs)
 {
 	u8 byte;
 
-	while (bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_RXD) {
+	while ((bs->rx_len) &&
+	       (bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_RXD)) {
 		byte = bcm2835_rd(bs, BCM2835_SPI_FIFO);
 		if (bs->rx_buf)
 			*bs->rx_buf++ = byte;
+		bs->rx_len--;
 	}
 }
 
@@ -107,47 +111,60 @@ static inline void bcm2835_wr_fifo(struct bcm2835_spi *bs)
 {
 	u8 byte;
 
-	while ((bs->len) &&
+	while ((bs->tx_len) &&
 	       (bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_TXD)) {
 		byte = bs->tx_buf ? *bs->tx_buf++ : 0;
 		bcm2835_wr(bs, BCM2835_SPI_FIFO, byte);
-		bs->len--;
+		bs->tx_len--;
 	}
 }
 
+static void bcm2835_spi_reset_hw(struct spi_master *master)
+{
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+
+	/* Disable SPI interrupts and transfer */
+	cs &= ~(BCM2835_SPI_CS_INTR |
+		BCM2835_SPI_CS_INTD |
+		BCM2835_SPI_CS_TA);
+	/* and reset RX/TX FIFOS */
+	cs |= BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX;
+
+	/* and reset the SPI_HW */
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+}
+
 static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* Read as many bytes as possible from FIFO */
 	bcm2835_rd_fifo(bs);
-
-	if (bs->len) { /* there is more data to transmit */
-		bcm2835_wr_fifo(bs);
-	} else { /* Transfer complete */
-		/* Disable SPI interrupts */
-		cs &= ~(BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD);
-		bcm2835_wr(bs, BCM2835_SPI_CS, cs);
-
-		/*
-		 * Wake up bcm2835_spi_transfer_one(), which will call
-		 * bcm2835_spi_finish_transfer(), to drain the RX FIFO.
-		 */
-		complete(&bs->done);
+	/* Write as many bytes as possible to FIFO */
+	bcm2835_wr_fifo(bs);
+
+	/* based on flags decide if we can finish the transfer */
+	if (bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_DONE) {
+		/* Transfer complete - reset SPI HW */
+		bcm2835_spi_reset_hw(master);
+		/* wake up the framework */
+		complete(&master->xfer_completion);
 	}
 
 	return IRQ_HANDLED;
 }
 
-static int bcm2835_spi_start_transfer(struct spi_device *spi,
-				      struct spi_transfer *tfr)
+static int bcm2835_spi_transfer_one(struct spi_master *master,
+				    struct spi_device *spi,
+				    struct spi_transfer *tfr)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, cdiv;
-	u32 cs = BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD | BCM2835_SPI_CS_TA;
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
+	/* set clock */
 	spi_hz = tfr->speed_hz;
 	clk_hz = clk_get_rate(bs->clk);
 
@@ -163,100 +180,118 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
 	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
 	}
+	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 
+	/* handle all the modes */
 	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
 		cs |= BCM2835_SPI_CS_REN;
-
 	if (spi->mode & SPI_CPOL)
 		cs |= BCM2835_SPI_CS_CPOL;
 	if (spi->mode & SPI_CPHA)
 		cs |= BCM2835_SPI_CS_CPHA;
 
-	if (!(spi->mode & SPI_NO_CS)) {
-		if (spi->mode & SPI_CS_HIGH) {
-			cs |= BCM2835_SPI_CS_CSPOL;
-			cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
-		}
-
-		cs |= spi->chip_select;
-	}
+	/* for gpio_cs set dummy CS so that no HW-CS get changed
+	 * we can not run this in bcm2835_spi_set_cs, as it does
+	 * not get called for cs_gpio cases, so we need to do it here
+	 */
+	if (gpio_is_valid(spi->cs_gpio) || (spi->mode & SPI_NO_CS))
+		cs |= BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
 
-	reinit_completion(&bs->done);
+	/* set transmit buffers and length */
 	bs->tx_buf = tfr->tx_buf;
 	bs->rx_buf = tfr->rx_buf;
-	bs->len = tfr->len;
+	bs->tx_len = tfr->len;
+	bs->rx_len = tfr->len;
 
-	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 	/*
 	 * Enable the HW block. This will immediately trigger a DONE (TX
 	 * empty) interrupt, upon which we will fill the TX FIFO with the
 	 * first TX bytes. Pre-filling the TX FIFO here to avoid the
 	 * interrupt doesn't work:-(
 	 */
+	cs |= BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD | BCM2835_SPI_CS_TA;
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
 
-	return 0;
+	/* signal that we need to wait for completion */
+	return 1;
 }
 
-static int bcm2835_spi_finish_transfer(struct spi_device *spi,
-				       struct spi_transfer *tfr,
-				       bool cs_change)
+static void bcm2835_spi_handle_err(struct spi_master *master,
+				   struct spi_message *msg)
 {
-	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
-	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
-
-	if (tfr->delay_usecs)
-		udelay(tfr->delay_usecs);
-
-	if (cs_change)
-		/* Clear TA flag */
-		bcm2835_wr(bs, BCM2835_SPI_CS, cs & ~BCM2835_SPI_CS_TA);
-
-	return 0;
+	bcm2835_spi_reset_hw(master);
 }
 
-static int bcm2835_spi_transfer_one(struct spi_master *master,
-				    struct spi_message *mesg)
+static void bcm2835_spi_set_cs(struct spi_device *spi, bool gpio_level)
 {
+	/*
+	 * we can assume that we are "native" as per spi_set_cs
+	 *   calling us ONLY when cs_gpio is not set
+	 * we can also assume that we are CS < 3 as per bcm2835_spi_setup
+	 *   we would not get called because of error handling there.
+	 * the level passed is the electrical level not enabled/disabled
+	 *   so it has to get translated back to enable/disable
+	 *   see spi_set_cs in spi.c for the implementation
+	 */
+
+	struct spi_master *master = spi->master;
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	struct spi_transfer *tfr;
-	struct spi_device *spi = mesg->spi;
-	int err = 0;
-	unsigned int timeout;
-	bool cs_change;
-
-	list_for_each_entry(tfr, &mesg->transfers, transfer_list) {
-		err = bcm2835_spi_start_transfer(spi, tfr);
-		if (err)
-			goto out;
-
-		timeout = wait_for_completion_timeout(
-			&bs->done,
-			msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS)
-			);
-		if (!timeout) {
-			err = -ETIMEDOUT;
-			goto out;
-		}
+	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+	bool enable;
 
-		cs_change = tfr->cs_change ||
-			list_is_last(&tfr->transfer_list, &mesg->transfers);
+	/* calculate the enable flag from the passed gpio_level */
+	enable = (spi->mode & SPI_CS_HIGH) ? gpio_level : !gpio_level;
 
-		err = bcm2835_spi_finish_transfer(spi, tfr, cs_change);
-		if (err)
-			goto out;
+	/* set flags for "reverse" polarity in the registers */
+	if (spi->mode & SPI_CS_HIGH) {
+		/* set the correct CS-bits */
+		cs |= BCM2835_SPI_CS_CSPOL;
+		cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
+	} else {
+		/* clean the CS-bits */
+		cs &= ~BCM2835_SPI_CS_CSPOL;
+		cs &= ~(BCM2835_SPI_CS_CSPOL0 << spi->chip_select);
+	}
 
-		mesg->actual_length += (tfr->len - bs->len);
+	/* select the correct chip_select depending on disabled/enabled */
+	if (enable) {
+		/* set cs correctly */
+		if (spi->mode & SPI_NO_CS) {
+			/* use the "undefined" chip-select */
+			cs |= BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
+		} else {
+			/* set the chip select */
+			cs &= ~(BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01);
+			cs |= spi->chip_select;
+		}
+	} else {
+		/* disable CSPOL which puts HW-CS into deselected state */
+		cs &= ~BCM2835_SPI_CS_CSPOL;
+		/* use the "undefined" chip-select as precaution */
+		cs |= BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01;
 	}
 
-out:
-	/* Clear FIFOs, and disable the HW block */
-	bcm2835_wr(bs, BCM2835_SPI_CS,
-		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
-	mesg->status = err;
-	spi_finalize_current_message(master);
+	/* finally set the calculated flags in SPI_CS */
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+}
 
-	return 0;
+static int bcm2835_spi_setup(struct spi_device *spi)
+{
+	/*
+	 * sanity checking the native-chipselects
+	 */
+	if (spi->mode & SPI_NO_CS)
+		return 0;
+	if (gpio_is_valid(spi->cs_gpio))
+		return 0;
+	if (spi->chip_select < 3)
+		return 0;
+
+	/* error in the case of native CS requested with CS-id > 2 */
+	dev_err(&spi->dev,
+		"setup: only three native chip-selects are supported\n"
+		);
+	return -EINVAL;
 }
 
 static int bcm2835_spi_probe(struct platform_device *pdev)
@@ -277,13 +312,14 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	master->mode_bits = BCM2835_SPI_MODE_BITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->num_chipselect = 3;
-	master->transfer_one_message = bcm2835_spi_transfer_one;
+	master->setup = bcm2835_spi_setup;
+	master->set_cs = bcm2835_spi_set_cs;
+	master->transfer_one = bcm2835_spi_transfer_one;
+	master->handle_err = bcm2835_spi_handle_err;
 	master->dev.of_node = pdev->dev.of_node;
 
 	bs = spi_master_get_devdata(master);
 
-	init_completion(&bs->done);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	bs->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(bs->regs)) {
@@ -314,7 +350,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	/* initialise the hardware */
+	/* initialise the hardware with the default polarities */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
