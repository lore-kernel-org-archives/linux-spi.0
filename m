From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 09/11] spi: orion: Use devm_clk_get()
Date: Mon, 09 Dec 2013 19:21:22 +0900
Message-ID: <001501cef4c8$68a7b160$39f71420$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Jason Cooper' <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	'Andrew Lunn' <andrew-g2DYL2Zd6BY@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_clk_get() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-orion.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 744841e..7f2121f 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -434,7 +434,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
 
-	spi->clk = clk_get(&pdev->dev, NULL);
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		status = PTR_ERR(spi->clk);
 		goto out;
@@ -465,7 +465,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 out_rel_clk:
 	clk_disable_unprepare(spi->clk);
-	clk_put(spi->clk);
 out:
 	spi_master_put(master);
 	return status;
@@ -481,7 +480,6 @@ static int orion_spi_remove(struct platform_device *pdev)
 	spi = spi_master_get_devdata(master);
 
 	clk_disable_unprepare(spi->clk);
-	clk_put(spi->clk);
 
 	return 0;
 }
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
