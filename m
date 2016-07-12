From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] spi: xilinx: Handle errors from platform_get_irq()
Date: Tue, 12 Jul 2016 15:24:40 +0200
Message-ID: <1468329881-5894-1-git-send-email-lars@metafoo.de>
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
---
 drivers/spi/spi-xilinx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121..334f423 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -455,6 +455,9 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
 
 	xspi->irq = platform_get_irq(pdev, 0);
+	if (xspi->irq < 0 && xspi->irq != -ENXIO)
+		return xspi->irq;
+
 	if (xspi->irq >= 0) {
 		/* Register for SPI Interrupt */
 		ret = devm_request_irq(&pdev->dev, xspi->irq, xilinx_spi_irq, 0,
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
