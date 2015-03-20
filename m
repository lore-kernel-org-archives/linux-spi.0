From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH V2] SPI: BCM2835: fix all checkpath --strict messages
Date: Fri, 20 Mar 2015 15:26:11 +0100
Message-ID: <78137BE7-37A4-4144-BBCC-CBEDA70DD31A@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <550BA8FE.7030001@wwwdotorg.org> <7727F65E-D8BC-4299-A359-56FA449C3379@martin.sperl.org> <20150320134053.GN2869@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150320134053.GN2869-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The following errors/warnings issued by checkpatch.pl --strict have been fixed:
drivers/spi/spi-bcm2835.c:182: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:191: CHECK: braces {} should be used on all arms of this statement
drivers/spi/spi-bcm2835.c:234: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:256: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:271: CHECK: Alignment should match open parenthesis
drivers/spi/spi-bcm2835.c:346: CHECK: Alignment should match open parenthesis
total: 0 errors, 0 warnings, 6 checks, 403 lines checked

In 2 locations the arguments had to get split/moved to the next line so that the
line width stays below 80 chars.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

Changelog:
  v2: minimized changes where possible

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 419a782..779d3a8 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -179,7 +179,7 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 }
 
 static int bcm2835_spi_start_transfer(struct spi_device *spi,
-		struct spi_transfer *tfr)
+				      struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
 	unsigned long spi_hz, clk_hz, cdiv;
@@ -196,8 +196,9 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
 
 		if (cdiv >= 65536)
 			cdiv = 0; /* 0 is the slowest we can go */
-	} else
+	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
+	}
 
 	if (spi->mode & SPI_CPOL)
 		cs |= BCM2835_SPI_CS_CPOL;
@@ -231,7 +232,8 @@ static int bcm2835_spi_start_transfer(struct spi_device *spi,
 }
 
 static int bcm2835_spi_finish_transfer(struct spi_device *spi,
-		struct spi_transfer *tfr, bool cs_change)
+				       struct spi_transfer *tfr,
+				       bool cs_change)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(spi->master);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
@@ -253,7 +255,7 @@ static int bcm2835_spi_finish_transfer(struct spi_device *spi,
 }
 
 static int bcm2835_spi_transfer_one(struct spi_master *master,
-		struct spi_message *mesg)
+				    struct spi_message *mesg)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	struct spi_transfer *tfr;
@@ -267,8 +269,10 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 		if (err)
 			goto out;
 
-		timeout = wait_for_completion_timeout(&bs->done,
-				msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS));
+		timeout = wait_for_completion_timeout(
+			&bs->done,
+			msecs_to_jiffies(BCM2835_SPI_TIMEOUT_MS)
+			);
 		if (!timeout) {
 			err = -ETIMEDOUT;
 			goto out;
@@ -343,7 +347,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	clk_prepare_enable(bs->clk);
 
 	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
-				dev_name(&pdev->dev), master);
+			       dev_name(&pdev->dev), master);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_clk_disable;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
