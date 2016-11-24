From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 1/3] spi: imx: replace schedule() with cond_resched()
Date: Thu, 24 Nov 2016 19:04:42 +0800
Message-ID: <1479985484-6641-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>,
        <frank.li-3arQi8VN3Tc@public.gmane.org>, <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It's more rational that just do the schedule when necessary
other than do it every time. Thus, it's better to replace
schedule() with cond_resched() in fsl_lpspi_txfifo_empty(),
which contributes to saving cpu time.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index bcb7b28..901bef4 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -178,7 +178,7 @@ static int fsl_lpspi_txfifo_empty(struct fsl_lpspi_data *fsl_lpspi)
 			dev_dbg(fsl_lpspi->dev, "txfifo empty timeout\n");
 			return -ETIMEDOUT;
 		}
-		schedule();
+		cond_resched();
 
 	} while (txcnt);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
