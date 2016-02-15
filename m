From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm2835aux: set up spi-mode before asserting cs-gpio" to the spi tree
Date: Mon, 15 Feb 2016 20:59:18 +0000
Message-ID: <E1aVQEo-000837-Fl@finisterre>
References: <1455444269-4797-2-git-send-email-stephanolbrich@gmx.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455444269-4797-2-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm2835aux: set up spi-mode before asserting cs-gpio

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b4e2adef62062cf716d1c81adc12ad6def516f72 Mon Sep 17 00:00:00 2001
From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Date: Sun, 14 Feb 2016 11:04:28 +0100
Subject: [PATCH] spi: bcm2835aux: set up spi-mode before asserting cs-gpio

When using reverse polarity for clock (spi-cpol) on a device
the clock line gets altered after chip-select has been asserted
resulting in an additional clock beat, which confuses hardware.

This happens due to the fact, the the hardware was initialized
and reset at the begin and end of each transfer which results
in default state for all lines except chip-select which is
handled by the spi-subsystem as gpio-cs is used.

To avoid this situation this patch moves the setup of polarity
(spi-cpol and spi-cpha) outside of the chip-select into
prepare_message, which is run prior to asserting chip-select.

Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Reviewed-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 57 +++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index e1b2fec..a6e25c6 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -218,9 +218,9 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 			BCM2835_AUX_SPI_CNTL1_IDLE);
 	}
 
-	/* and if rx_len is 0 then wake up completion and disable spi */
+	/* and if rx_len is 0 then disable interrupts and wake up completion */
 	if (!bs->rx_len) {
-		bcm2835aux_spi_reset_hw(bs);
+		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 		complete(&master->xfer_completion);
 	}
 
@@ -313,9 +313,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 		}
 	}
 
-	/* Transfer complete - reset SPI HW */
-	bcm2835aux_spi_reset_hw(bs);
-
 	/* and return without waiting for completion */
 	return 0;
 }
@@ -336,10 +333,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	 * resulting (potentially) in more interrupts when transferring
 	 * more than 12 bytes
 	 */
-	bs->cntl[0] = BCM2835_AUX_SPI_CNTL0_ENABLE |
-		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
-		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
-	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
 
 	/* set clock */
 	spi_hz = tfr->speed_hz;
@@ -354,17 +347,13 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	} else { /* the slowest we can go */
 		speed = BCM2835_AUX_SPI_CNTL0_SPEED_MAX;
 	}
+	/* mask out old speed from previous spi_transfer */
+	bs->cntl[0] &= ~(BCM2835_AUX_SPI_CNTL0_SPEED);
+	/* set the new speed */
 	bs->cntl[0] |= speed << BCM2835_AUX_SPI_CNTL0_SPEED_SHIFT;
 
 	spi_used_hz = clk_hz / (2 * (speed + 1));
 
-	/* handle all the modes */
-	if (spi->mode & SPI_CPOL)
-		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
-	if (spi->mode & SPI_CPHA)
-		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
-			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
-
 	/* set transmit buffers and length */
 	bs->tx_buf = tfr->tx_buf;
 	bs->rx_buf = tfr->rx_buf;
@@ -388,6 +377,40 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	return bcm2835aux_spi_transfer_one_irq(master, spi, tfr);
 }
 
+static int bcm2835aux_spi_prepare_message(struct spi_master *master,
+					  struct spi_message *msg)
+{
+	struct spi_device *spi = msg->spi;
+	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+
+	bs->cntl[0] = BCM2835_AUX_SPI_CNTL0_ENABLE |
+		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
+		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
+	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
+
+	/* handle all the modes */
+	if (spi->mode & SPI_CPOL)
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
+	if (spi->mode & SPI_CPHA)
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
+			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
+
+	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
+	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
+
+	return 0;
+}
+
+static int bcm2835aux_spi_unprepare_message(struct spi_master *master,
+					    struct spi_message *msg)
+{
+	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+
+	bcm2835aux_spi_reset_hw(bs);
+
+	return 0;
+}
+
 static void bcm2835aux_spi_handle_err(struct spi_master *master,
 				      struct spi_message *msg)
 {
@@ -416,6 +439,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = -1;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
 	master->handle_err = bcm2835aux_spi_handle_err;
+	master->prepare_message = bcm2835aux_spi_prepare_message;
+	master->unprepare_message = bcm2835aux_spi_unprepare_message;
 	master->dev.of_node = pdev->dev.of_node;
 
 	bs = spi_master_get_devdata(master);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
