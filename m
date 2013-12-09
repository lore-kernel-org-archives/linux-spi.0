From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/11] spi: bcm63xx-hsspi: Use devm_clk_get()
Date: Mon, 09 Dec 2013 19:20:45 +0900
Message-ID: <001401cef4c8$52cf31b0$f86d9510$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Jonas Gorski' <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_clk_get() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index bc8d848..9742e11 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -342,16 +342,14 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	clk = clk_get(dev, "hsspi");
+	clk = devm_clk_get(dev, "hsspi");
 
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
 	rate = clk_get_rate(clk);
-	if (!rate) {
-		ret = -EINVAL;
-		goto out_put_clk;
-	}
+	if (!rate)
+		return -EINVAL;
 
 	clk_prepare_enable(clk);
 
@@ -409,9 +407,6 @@ out_put_master:
 	spi_master_put(master);
 out_disable_clk:
 	clk_disable_unprepare(clk);
-out_put_clk:
-	clk_put(clk);
-
 	return ret;
 }
 
@@ -426,7 +421,6 @@ static int bcm63xx_hsspi_remove(struct platform_device *pdev)
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
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
