From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 07/11] spi: bcm63xx: Use devm_clk_get()
Date: Mon, 09 Dec 2013 19:20:15 +0900
Message-ID: <001301cef4c8$40d2b3b0$c2781b10$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Jonas Gorski' <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	'Florian Fainelli' <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_clk_get() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 469ecd8..f44a9eb 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -345,22 +345,19 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "no irq\n");
-		ret = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
-	clk = clk_get(dev, "spi");
+	clk = devm_clk_get(dev, "spi");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "no clock for device\n");
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 
 	master = spi_alloc_master(dev, sizeof(*bs));
 	if (!master) {
 		dev_err(dev, "out of memory\n");
-		ret = -ENOMEM;
-		goto out_clk;
+		return -ENOMEM;
 	}
 
 	bs = spi_master_get_devdata(master);
@@ -427,9 +424,6 @@ out_clk_disable:
 	clk_disable_unprepare(clk);
 out_err:
 	spi_master_put(master);
-out_clk:
-	clk_put(clk);
-out:
 	return ret;
 }
 
@@ -443,7 +437,6 @@ static int bcm63xx_spi_remove(struct platform_device *pdev)
 
 	/* HW shutdown */
 	clk_disable_unprepare(bs->clk);
-	clk_put(bs->clk);
 
 	return 0;
 }
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
