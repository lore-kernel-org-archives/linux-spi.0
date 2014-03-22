From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] spi: clps711x: Remove <mach/hardware.h> dependency
Date: Sat, 22 Mar 2014 10:57:35 +0400
Message-ID: <1395471455-10576-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch removes <mach/hardware.h> dependency. This is performed
by replace hard coded used memory regions and interrupt to getting
these values from resources passed to the driver. For the system-wide
registers we now able to use SYSCON driver.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 86 ++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 373b4bd..d623500 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -16,14 +16,21 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/clps711x.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_data/spi-clps711x.h>
 
-#include <mach/hardware.h>
-
 #define DRIVER_NAME	"spi-clps711x"
 
+#define SYNCIO_FRMLEN(x)	((x) << 8)
+#define SYNCIO_TXFRMEN		(1 << 14)
+
 struct spi_clps711x_data {
+	void __iomem		*syncio;
+	struct regmap		*syscon;
+	struct regmap		*syscon1;
 	struct clk		*spi_clk;
 	u32			max_speed_hz;
 
@@ -48,31 +55,29 @@ static void spi_clps711x_setup_xfer(struct spi_device *spi,
 
 	/* Setup SPI frequency divider */
 	if (!xfer->speed_hz || (xfer->speed_hz >= hw->max_speed_hz))
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(3), SYSCON1);
+		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
+				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(3));
 	else if (xfer->speed_hz >= (hw->max_speed_hz / 2))
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(2), SYSCON1);
+		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
+				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(2));
 	else if (xfer->speed_hz >= (hw->max_speed_hz / 8))
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(1), SYSCON1);
+		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
+				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(1));
 	else
-		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
-			    SYSCON1_ADCKSEL(0), SYSCON1);
+		regmap_update_bits(hw->syscon1, SYSCON_OFFSET,
+				   SYSCON1_ADCKSEL_MASK, SYSCON1_ADCKSEL(0));
 }
 
 static int spi_clps711x_prepare_message(struct spi_master *master,
 					struct spi_message *msg)
 {
+	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
 
-	/* Setup edge for transfer */
-	if (spi->mode & SPI_CPHA)
-		clps_writew(clps_readw(SYSCON3) | SYSCON3_ADCCKNSEN, SYSCON3);
-	else
-		clps_writew(clps_readw(SYSCON3) & ~SYSCON3_ADCCKNSEN, SYSCON3);
-
-	return 0;
+	/* Setup mode for transfer */
+	return regmap_update_bits(hw->syscon, SYSCON_OFFSET, SYSCON3_ADCCKNSEN,
+				  (spi->mode & SPI_CPHA) ?
+				  SYSCON3_ADCCKNSEN : 0);
 }
 
 static int spi_clps711x_transfer_one(struct spi_master *master,
@@ -91,7 +96,8 @@ static int spi_clps711x_transfer_one(struct spi_master *master,
 
 	/* Initiate transfer */
 	data = hw->tx_buf ? *hw->tx_buf++ : 0;
-	clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN, SYNCIO);
+	writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN, hw->syncio);
+
 	return 1;
 }
 
@@ -102,15 +108,15 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 	u8 data;
 
 	/* Handle RX */
-	data = clps_readb(SYNCIO);
+	data = readb(hw->syncio);
 	if (hw->rx_buf)
 		*hw->rx_buf++ = data;
 
 	/* Handle TX */
 	if (--hw->len > 0) {
 		data = hw->tx_buf ? *hw->tx_buf++ : 0;
-		clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
-			    SYNCIO);
+		writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
+		       hw->syncio);
 	} else
 		spi_finalize_current_transfer(master);
 
@@ -119,10 +125,11 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 
 static int spi_clps711x_probe(struct platform_device *pdev)
 {
-	int i, ret;
-	struct spi_master *master;
 	struct spi_clps711x_data *hw;
 	struct spi_clps711x_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct spi_master *master;
+	struct resource *res;
+	int i, irq, ret;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "No platform data supplied\n");
@@ -134,6 +141,10 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	master = spi_alloc_master(&pdev->dev, sizeof(*hw));
 	if (!master)
 		return -ENOMEM;
@@ -175,18 +186,35 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 
+	hw->syscon = syscon_regmap_lookup_by_pdevname("syscon.3");
+	if (IS_ERR(hw->syscon)) {
+		ret = PTR_ERR(hw->syscon);
+		goto err_out;
+	}
+
+	hw->syscon1 = syscon_regmap_lookup_by_pdevname("syscon.1");
+	if (IS_ERR(hw->syscon1)) {
+		ret = PTR_ERR(hw->syscon1);
+		goto err_out;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hw->syncio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hw->syncio)) {
+		ret = PTR_ERR(hw->syncio);
+		goto err_out;
+	}
+
 	/* Disable extended mode due hardware problems */
-	clps_writew(clps_readw(SYSCON3) & ~SYSCON3_ADCCON, SYSCON3);
+	regmap_update_bits(hw->syscon, SYSCON_OFFSET, SYSCON3_ADCCON, 0);
 
 	/* Clear possible pending interrupt */
-	clps_readl(SYNCIO);
+	readl(hw->syncio);
 
-	ret = devm_request_irq(&pdev->dev, IRQ_SSEOTI, spi_clps711x_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, spi_clps711x_isr, 0,
 			       dev_name(&pdev->dev), master);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't request IRQ\n");
+	if (ret)
 		goto err_out;
-	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (!ret) {
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
