From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 02/10] spi: dw: use plain struct device * at earlier ->probe()
Date: Wed, 14 Oct 2015 23:12:17 +0300
Message-ID: <1444853545-59868-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The name of the master device is set during registrationg which happens after
we issue the error message. Change it to plain struct device * to see which
device registration failed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 254ffdf..1799416 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -520,7 +520,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
 			dws->name, master);
 	if (ret < 0) {
-		dev_err(&master->dev, "can not get IRQ\n");
+		dev_err(dev, "can not get IRQ\n");
 		goto err_free_master;
 	}
 
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
