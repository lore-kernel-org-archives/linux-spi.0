From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/11] spi: ath79: Use devm_*() functions
Date: Mon, 09 Dec 2013 19:14:58 +0900
Message-ID: <000f01cef4c7$837d0180$8a770480$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Gabor Juhos' <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-ath79.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 821bf7a..31534b5 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -243,21 +243,21 @@ static int ath79_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
-	sp->base = ioremap(r->start, resource_size(r));
+	sp->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
 	if (!sp->base) {
 		ret = -ENXIO;
 		goto err_put_master;
 	}
 
-	sp->clk = clk_get(&pdev->dev, "ahb");
+	sp->clk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sp->clk)) {
 		ret = PTR_ERR(sp->clk);
-		goto err_unmap;
+		goto err_put_master;
 	}
 
 	ret = clk_enable(sp->clk);
 	if (ret)
-		goto err_clk_put;
+		goto err_put_master;
 
 	rate = DIV_ROUND_UP(clk_get_rate(sp->clk), MHZ);
 	if (!rate) {
@@ -280,10 +280,6 @@ err_disable:
 	ath79_spi_disable(sp);
 err_clk_disable:
 	clk_disable(sp->clk);
-err_clk_put:
-	clk_put(sp->clk);
-err_unmap:
-	iounmap(sp->base);
 err_put_master:
 	spi_master_put(sp->bitbang.master);
 
@@ -297,8 +293,6 @@ static int ath79_spi_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&sp->bitbang);
 	ath79_spi_disable(sp);
 	clk_disable(sp->clk);
-	clk_put(sp->clk);
-	iounmap(sp->base);
 	spi_master_put(sp->bitbang.master);
 
 	return 0;
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
