From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: xilinx: Handle errors from platform_get_irq()" to the spi tree
Date: Fri, 15 Jul 2016 12:57:09 +0100
Message-ID: <E1bO1jx-0006zt-ID@debutante>
References: <1468573459-3071-1-git-send-email-lars@metafoo.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468573459-3071-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: xilinx: Handle errors from platform_get_irq()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4db9bf548bb00d84ba7dfd70f124de16386c0c55 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Date: Fri, 15 Jul 2016 11:04:18 +0200
Subject: [PATCH] spi: xilinx: Handle errors from platform_get_irq()

The Xilinx SPI driver can operate without an IRQ, but not every error
returned by platform_get_irq() means that no IRQ was specified. It will
also return an error if the IRQ specification is invalid or the IRQ
provider is not yet available (EPROBE_DEFER).

So instead of ignoring all errors only ignore ENXIO, which means no IRQ was
specified, and propagate all other errors to device driver core.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Acked-by: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121173cd..e62eb9ace825 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
