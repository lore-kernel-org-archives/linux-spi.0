From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: rspi: use platform drvdata correctly in rspi_remove()
Date: Fri, 15 Nov 2013 15:44:02 +0800
Message-ID: <CAPgLHd9kYK9p9K=6DycGJXHF4J-vygD4v4puOoZLbCuF6LaLFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

We had set the platform drvdata in rspi_probe() as a type of
struct rspi_data, but use it as struct spi_master in rspi_remove()
Fix by remove the unnecessary spi_master_[get|put]() since rspi->master
is no longer used after spi_unregister_master().

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 58449ad..9e829ce 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -885,14 +885,13 @@ static void rspi_release_dma(struct rspi_data *rspi)
 
 static int rspi_remove(struct platform_device *pdev)
 {
-	struct rspi_data *rspi = spi_master_get(platform_get_drvdata(pdev));
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	spi_unregister_master(rspi->master);
 	rspi_release_dma(rspi);
 	free_irq(platform_get_irq(pdev, 0), rspi);
 	clk_put(rspi->clk);
 	iounmap(rspi->addr);
-	spi_master_put(rspi->master);
 
 	return 0;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
