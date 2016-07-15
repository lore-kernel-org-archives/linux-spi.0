From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH v2 1/2] spi: xilinx: Handle errors from platform_get_irq()
Date: Fri, 15 Jul 2016 11:04:18 +0200
Message-ID: <1468573459-3071-1-git-send-email-lars@metafoo.de>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Xilinx SPI driver can operate without an IRQ, but not every error
returned by platform_get_irq() means that no IRQ was specified. It will
also return an error if the IRQ specification is invalid or the IRQ
provider is not yet available (EPROBE_DEFER).

So instead of ignoring all errors only ignore ENXIO, which means no IRQ was
specified, and propagate all other errors to device driver core.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Acked-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes since v1:
	* Fix error path handling
---
 drivers/spi/spi-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121..e62eb9a 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -455,7 +455,10 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
 	xspi->irq = platform_get_irq(pdev, 0);
-	if (xspi->irq >= 0) {
+	if (xspi->irq < 0 && xspi->irq != -ENXIO) {
+		ret = xspi->irq;
+		goto put_master;
+	} else if (xspi->irq >= 0) {
 		/* Register for SPI Interrupt */
 		ret = devm_request_irq(&pdev->dev, xspi->irq, xilinx_spi_irq, 0,
 				dev_name(&pdev->dev), xspi);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
