From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: nuc900: remove redundant return value check of platform_get_resource()
Date: Fri, 20 Dec 2013 10:21:54 +0800
Message-ID: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-nuc900.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 43d340c..5040630 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -368,12 +368,6 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 	hw->bitbang.txrx_bufs      = nuc900_spi_txrx;
 
 	hw->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (hw->res == NULL) {
-		dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
-		err = -ENOENT;
-		goto err_pdata;
-	}
-
 	hw->regs = devm_ioremap_resource(&pdev->dev, hw->res);
 	if (IS_ERR(hw->regs)) {
 		err = PTR_ERR(hw->regs);

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
