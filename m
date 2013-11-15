From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-mxs: fix reference leak to master in mxs_spi_remove()
Date: Fri, 15 Nov 2013 15:50:31 +0800
Message-ID: <CAPgLHd9tKB5CFE-2hDUMH-XkEK7mn6oC4MOi_LP+qfDh3_XqPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Once a spi_master_get() call succeeds, we need an additional
spi_master_put() call to free the memory, otherwise we will
leak a reference to master. Fix by removing the unnecessary
spi_master_get() call.

Fixes: 33e195acf268 ('spi: mxs: use devm_spi_register_master()')
Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index de33305..37b3e41 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -565,7 +565,7 @@ static int mxs_spi_remove(struct platform_device *pdev)
 	struct mxs_spi *spi;
 	struct mxs_ssp *ssp;
 
-	master = spi_master_get(platform_get_drvdata(pdev));
+	master = platform_get_drvdata(pdev);
 	spi = spi_master_get_devdata(master);
 	ssp = &spi->ssp;
 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
