From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 2/2] spi: bcm2835: make use of new bits_per_word_mask core
	feature
Date: Tue, 26 Mar 2013 20:37:58 -0600
Message-ID: <1364351878-26089-2-git-send-email-swarren@wwwdotorg.org>
References: <1364351878-26089-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364351878-26089-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This driver only supports bits_per_word==8, so inform the SPI core of
this. Remove all the open-coded validation that's no longer needed.

Signed-off-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
This only converts one driver, but if the concept is acceptable, I'll try
to take a look at other drivers and convert them too.

 drivers/spi/spi-bcm2835.c |   36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 346601e..89c0b50 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -182,23 +182,6 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int bcm2835_spi_check_transfer(struct spi_device *spi,
-		struct spi_transfer *tfr)
-{
-	/* tfr==NULL when called from bcm2835_spi_setup() */
-	u32 bpw = tfr ? tfr->bits_per_word : spi->bits_per_word;
-
-	switch (bpw) {
-	case 8:
-		break;
-	default:
-		dev_err(&spi->dev, "unsupported bits_per_word=%d\n", bpw);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int bcm2835_spi_start_transfer(struct spi_device *spi,
 		struct spi_transfer *tfr)
 {
@@ -273,19 +256,6 @@ static int bcm2835_spi_finish_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static int bcm2835_spi_setup(struct spi_device *spi)
-{
-	int ret;
-
-	ret = bcm2835_spi_check_transfer(spi, NULL);
-	if (ret) {
-		dev_err(&spi->dev, "setup: invalid message\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int bcm2835_spi_transfer_one(struct spi_master *master,
 		struct spi_message *mesg)
 {
@@ -297,10 +267,6 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bool cs_change;
 
 	list_for_each_entry(tfr, &mesg->transfers, transfer_list) {
-		err = bcm2835_spi_check_transfer(spi, tfr);
-		if (err)
-			goto out;
-
 		err = bcm2835_spi_start_transfer(spi, tfr);
 		if (err)
 			goto out;
@@ -348,9 +314,9 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	master->mode_bits = BCM2835_SPI_MODE_BITS;
+	master->bits_per_word_mask = BIT(8 - 1);
 	master->bus_num = -1;
 	master->num_chipselect = 3;
-	master->setup = bcm2835_spi_setup;
 	master->transfer_one_message = bcm2835_spi_transfer_one;
 	master->dev.of_node = pdev->dev.of_node;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
