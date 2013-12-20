From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: txx9: drop clk_put for devm_clk_get in txx9spi_probe()
Date: Fri, 20 Dec 2013 10:15:45 +0800
Message-ID: <CAPgLHd_94fMwOm1Z-=4ojrhH35WHve4piJkEC5Fh8k8OZcTfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

devm_clk_get() is used so there is no reason to explicitly
call clk_put() in txx9spi_probe() functions.

Fixes: 18e34d568efa ('spi: txx9: Use devm_clk_get()')
Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-txx9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index ffbe03d..6191ced 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -356,7 +356,6 @@ static int txx9spi_probe(struct platform_device *dev)
 	}
 	ret = clk_enable(c->clk);
 	if (ret) {
-		clk_put(c->clk);
 		c->clk = NULL;
 		goto exit;
 	}

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
