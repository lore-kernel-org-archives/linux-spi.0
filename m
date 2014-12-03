From: Iain Baron <iain.baron-YmHWzhjmega9Zq0HfjR8jw@public.gmane.org>
Subject: [PATCH] spi-altera: Fix NULL pointer dereference in spi_bitbang_transfer_one
Date: Wed,  3 Dec 2014 11:25:49 +0000
Message-ID: <1417605949-11447-1-git-send-email-iain.baron@newtons4th.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Iain Baron <iain.baron-YmHWzhjmega9Zq0HfjR8jw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi-altera.c is missing a bitbang setup_transfer callback to setup
the clock and wordsize for the SPI transfer.  This triggers a NULL
pointer dereference in spi_bitbang_transfer_one.
Provide the missing callback, which simply returns success, because
the parameters are not configurable at runtime for this hardware.

Signed-off-by: Iain Baron <iain.baron-YmHWzhjmega9Zq0HfjR8jw@public.gmane.org>
---
 drivers/spi/spi-altera.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 595b62c..6b63f60 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -198,6 +198,12 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static int altera_spi_setup_transfer(struct spi_device *spi,
+				struct spi_transfer *t)
+{
+	return 0;
+}
+
 static int altera_spi_probe(struct platform_device *pdev)
 {
 	struct altera_spi_platform_data *platp = dev_get_platdata(&pdev->dev);
@@ -224,6 +230,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		return err;
 	hw->bitbang.chipselect = altera_spi_chipsel;
 	hw->bitbang.txrx_bufs = altera_spi_txrx;
+	hw->bitbang.setup_transfer = altera_spi_setup_transfer;
 
 	/* find and map our resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
