From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCHv2] spi: dw: Initialize of_node to discover DT node children
Date: Wed, 8 Oct 2014 13:51:34 -0500
Message-ID: <1412794294-31248-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

The of_node element must be initialized to enable discovery of node
children which takes place in the of_register_spi_devices() function.

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
v2:  Remove #ifdef (CONFIG_OF). Remove other files.
---
 drivers/spi/spi-dw.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0dd0623..0159a70 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -671,6 +671,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->cleanup = dw_spi_cleanup;
 	master->transfer_one_message = dw_spi_transfer_one_message;
 	master->max_speed_hz = dws->max_freq;
+	master->dev.of_node = dev->of_node;
 
 	/* Basic HW init */
 	spi_hw_init(dws);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
