From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: spi-fsl-dspi: Drop extra spi_master_put in device remove function
Date: Sat, 20 Aug 2016 15:25:32 +0000
Message-ID: <1471706732-25944-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The call sequence spi_alloc_master/spi_register_master/spi_unregister_master
is complete; it reduces the device reference count to zero, which and results
in device memory being freed. The subsequent call to spi_master_put is
unnecessary and results in an access to free memory. Drop it.

Fixes: 9298bc727385 ("spi: spi-fsl-dspi: Remove spi-bitbang")
Signed-off-by: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d57baf6..0c87186 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -758,7 +758,6 @@ static int dspi_remove(struct platform_device *pdev)
 	/* Disconnect from the SPI framework */
 	clk_disable_unprepare(dspi->clk);
 	spi_unregister_master(dspi->master);
-	spi_master_put(dspi->master);
 
 	return 0;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
