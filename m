From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: coldfire-qspi: Prevent NULL pointer dereference
Date: Sun, 09 Mar 2014 14:11:10 +0800
Message-ID: <1394345470.15686.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If pdata->cs_control is NULL, we will hit NULL pointer dereference in
mcfqspi_cs_select() and mcfqspi_cs_deselect(). Thus add NULL test for
pdata->cs_control in probe().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index c29bbb0..b01616c 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -133,13 +133,13 @@ static void mcfqspi_cs_deselect(struct mcfqspi *mcfqspi, u8 chip_select,
 
 static int mcfqspi_cs_setup(struct mcfqspi *mcfqspi)
 {
-	return (mcfqspi->cs_control && mcfqspi->cs_control->setup) ?
+	return (mcfqspi->cs_control->setup) ?
 		mcfqspi->cs_control->setup(mcfqspi->cs_control) : 0;
 }
 
 static void mcfqspi_cs_teardown(struct mcfqspi *mcfqspi)
 {
-	if (mcfqspi->cs_control && mcfqspi->cs_control->teardown)
+	if (mcfqspi->cs_control->teardown)
 		mcfqspi->cs_control->teardown(mcfqspi->cs_control);
 }
 
@@ -366,6 +366,11 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	if (!pdata->cs_control) {
+		dev_dbg(&pdev->dev, "pdata->cs_control is NULL\n");
+		return -EINVAL;
+	}
+
 	master = spi_alloc_master(&pdev->dev, sizeof(*mcfqspi));
 	if (master == NULL) {
 		dev_dbg(&pdev->dev, "spi_alloc_master failed\n");
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
