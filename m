From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 3/6] spi/bcm63xx: hardcode busnum to 0
Date: Thu, 10 Sep 2015 16:11:41 +0200
Message-ID: <1441894304-22316-4-git-send-email-jogo@openwrt.org>
References: <1441894304-22316-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We always pass 0 as the spi bus number, so we might as well hard code
it.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index a997c64..c1364a8 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -32,6 +32,7 @@
 #define BCM63XX_SPI_MAX_PREPEND		15
 
 #define BCM63XX_SPI_MAX_CS		8
+#define BCM63XX_SPI_BUS_NUM		0
 
 struct bcm63xx_spi {
 	struct completion	done;
@@ -369,7 +370,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	master->bus_num = pdata->bus_num;
+	master->bus_num = BCM63XX_SPI_BUS_NUM;
 	master->num_chipselect = BCM63XX_SPI_MAX_CS;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
