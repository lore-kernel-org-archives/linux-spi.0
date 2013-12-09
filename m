From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 10/11] spi: txx9: Use devm_clk_get()
Date: Mon, 09 Dec 2013 19:23:12 +0900
Message-ID: <001601cef4c8$aa1f7d30$fe5e7790$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_clk_get() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-txx9.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 18c9bb2..ffbe03d 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -348,7 +348,7 @@ static int txx9spi_probe(struct platform_device *dev)
 	INIT_LIST_HEAD(&c->queue);
 	init_waitqueue_head(&c->waitq);
 
-	c->clk = clk_get(&dev->dev, "spi-baseclk");
+	c->clk = devm_clk_get(&dev->dev, "spi-baseclk");
 	if (IS_ERR(c->clk)) {
 		ret = PTR_ERR(c->clk);
 		c->clk = NULL;
@@ -415,10 +415,8 @@ exit_busy:
 exit:
 	if (c->workqueue)
 		destroy_workqueue(c->workqueue);
-	if (c->clk) {
+	if (c->clk)
 		clk_disable(c->clk);
-		clk_put(c->clk);
-	}
 	spi_master_put(master);
 	return ret;
 }
@@ -430,7 +428,6 @@ static int txx9spi_remove(struct platform_device *dev)
 
 	destroy_workqueue(c->workqueue);
 	clk_disable(c->clk);
-	clk_put(c->clk);
 	return 0;
 }
 
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
