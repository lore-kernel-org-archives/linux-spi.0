From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: spi-imx: use threaded interrupt
Date: Mon,  1 Sep 2014 16:35:06 +0200
Message-ID: <1409582106-2845-1-git-send-email-l.stach@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

The i.MX SPI driver fills/flushes the FIFOs in interrupt context. With
longer SPI messages this introduces big latencies in the system. Using
a threaded interrupt avoids this issue.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-imx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5daff2054ae4..5e40801e1c52 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -672,6 +672,15 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 {
 	struct spi_imx_data *spi_imx = dev_id;
 
+	spi_imx->devtype_data->intctrl(spi_imx, 0);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t spi_imx_isr_thread(int irq, void *dev_id)
+{
+	struct spi_imx_data *spi_imx = dev_id;
+
 	while (spi_imx->devtype_data->rx_available(spi_imx)) {
 		spi_imx->rx(spi_imx);
 		spi_imx->txfifo--;
@@ -679,6 +688,7 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 
 	if (spi_imx->count) {
 		spi_imx_push(spi_imx);
+		spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
 		return IRQ_HANDLED;
 	}
 
@@ -691,7 +701,6 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	spi_imx->devtype_data->intctrl(spi_imx, 0);
 	complete(&spi_imx->xfer_done);
 
 	return IRQ_HANDLED;
@@ -883,8 +892,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	ret = devm_request_irq(&pdev->dev, spi_imx->irq, spi_imx_isr, 0,
-			       dev_name(&pdev->dev), spi_imx);
+	ret = request_threaded_irq(spi_imx->irq, spi_imx_isr,
+			spi_imx_isr_thread, 0, dev_name(&pdev->dev), spi_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", spi_imx->irq, ret);
 		goto out_master_put;
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
