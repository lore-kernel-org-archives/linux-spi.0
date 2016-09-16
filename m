From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: bcm-qspi: Fix error return code in bcm_qspi_probe()
Date: Fri, 16 Sep 2016 14:00:19 +0000
Message-ID: <1474034419-26936-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 8fff43e..ef0c466 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1206,12 +1206,14 @@ int bcm_qspi_probe(struct platform_device *pdev,
 
 	if (!num_ints) {
 		dev_err(&pdev->dev, "no IRQs registered, cannot init driver\n");
+		ret = -EINVAL;
 		goto qspi_probe_err;
 	}
 
 	qspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(qspi->clk)) {
 		dev_warn(dev, "unable to get clock\n");
+		ret = PTR_ERR(qspi->clk);
 		goto qspi_probe_err;
 	}

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
