From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 3/4] spi/bcm63xx: check return value of clk_prepare_enable
Date: Tue, 17 Dec 2013 21:42:09 +0100
Message-ID: <1387312930-22436-4-git-send-email-jogo@openwrt.org>
References: <1387312930-22436-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387312930-22436-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Ensure we notice if the clock cannot be enabled for any reason and pass
the error down.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index ae60731..0c8c68a 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -397,7 +397,10 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize hardware */
-	clk_prepare_enable(bs->clk);
+	ret = clk_prepare_enable(bs->clk);
+	if (ret)
+		goto out_err;
+
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
 	/* register and we are done */
@@ -450,8 +453,11 @@ static int bcm63xx_spi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	int ret;
 
-	clk_prepare_enable(bs->clk);
+	ret = clk_prepare_enable(bs->clk);
+	if (ret)
+		return ret;
 
 	spi_master_resume(master);
 
-- 
1.8.5.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
