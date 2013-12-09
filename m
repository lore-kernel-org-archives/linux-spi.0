From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 11/11] spi: bcm2835: Use devm_request_irq()
Date: Mon, 09 Dec 2013 19:25:00 +0900
Message-ID: <001701cef4c8$eaa87c30$bff97490$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Chris Boot' <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	'Laurent Navet' <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_request_irq() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 9025edd..8a89dd1 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -347,8 +347,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(bs->clk);
 
-	err = request_irq(bs->irq, bcm2835_spi_interrupt, 0,
-			dev_name(&pdev->dev), master);
+	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
+				dev_name(&pdev->dev), master);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
 		goto out_clk_disable;
@@ -361,13 +361,11 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
-		goto out_free_irq;
+		goto out_clk_disable;
 	}
 
 	return 0;
 
-out_free_irq:
-	free_irq(bs->irq, master);
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
 out_master_put:
@@ -380,8 +378,6 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 
-	free_irq(bs->irq, master);
-
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
