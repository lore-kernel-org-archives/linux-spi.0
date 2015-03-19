From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] SPI: BCM2835: fix all checkpath --strict messages
Date: Thu, 19 Mar 2015 09:01:50 +0000
Message-ID: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, warren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 419a782..e1dea40 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -178,8 +178,9 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int bcm2835_spi_start_transfer(struct spi_device *spi,
-		struct spi_transfer *tfr)
+static int bcm2835_spi_start_transfer(
+	struct spi_device *spi,
+	struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
 	unsigned long spi_hz, clk_hz, cdiv;
@@ -196,8 +197,9 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
 
 		if (cdiv >= 65536)
 			cdiv = 0; /* 0 is the slowest we can go */
-	} else
+	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
+	}
 
 	if (spi->mode & SPI_CPOL)
 		cs |= BCM2835_SPI_CS_CPOL;
@@ -230,8 +232,9 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static int bcm2835_spi_finish_transfer(struct spi_device *spi,
-		struct spi_transfer *tfr, bool cs_change)
+static int bcm2835_spi_finish_transfer(
+	struct spi_device *spi,
+	struct spi_transfer *tfr, bool cs_change)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
@@ -252,8 +255,9 @@ static int bcm2835_spi_finish_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static int bcm2835_spi_transfer_one(struct spi_master *master,
-		struct spi_message *mesg)
+static int bcm2835_spi_transfer_one(
+	struct spi_master *master,
+	struct spi_message *mesg)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	struct spi_transfer *tfr;
@@ -267,8 +271,9 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 		if (err)
 			goto out;
 
-		timeout = wait_for_completion_timeout(&bs->done,
-				msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS));
+		timeout = wait_for_completion_timeout(
+			&bs->done,
+			msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS));
 		if (!timeout) {
 			err = -ETIMEDOUT;
 			goto out;
@@ -342,8 +347,9 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(bs->clk);
 
-	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
-				dev_name(&pdev->dev), master);
+	err = devm_request_irq(
+		&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
+		dev_name(&pdev->dev), master);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_clk_disable;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
