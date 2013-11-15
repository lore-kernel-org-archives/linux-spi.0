From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: txx9: fix reference leak to master in txx9spi_remove()
Date: Fri, 15 Nov 2013 15:49:29 +0800
Message-ID: <CAPgLHd8PwrTi+Mq-mjKxY8CkpYCxzRBfnLoeum9YygoEyx=fyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Once a spi_master_get() call succeeds, we need an additional
spi_master_put() call to free the memory, otherwise we will
leak a reference to master. Fix by removing the unnecessary
spi_master_get() call.

Fixes: 2fe7e4add3e5 ('spi: txx9: use devm_spi_register_master()')
Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-txx9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 637cce2..18c9bb2 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -425,7 +425,7 @@ exit:
 
 static int txx9spi_remove(struct platform_device *dev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(dev));
+	struct spi_master *master = platform_get_drvdata(dev);
 	struct txx9spi *c = spi_master_get_devdata(master);
 
 	destroy_workqueue(c->workqueue);

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
