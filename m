From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: sirf: request and free cs gpio in setup and cleanup callbacks
Date: Sun,  3 May 2015 10:30:12 +0000
Message-ID: <1430649012-1694-1-git-send-email-21cnbao@gmail.com>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	swingboard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

move spi controller's gpio request work out from probe() to spi device
register stage, so after spi device register spi controller can deactive
device's gpio chipselect. old code can't do it because gpio request has
not be done until device register is finised in spi_bitbang_start.
and add cleanup function to free CS gpio.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 -v2: rebase on v4.1-rc1

 drivers/spi/spi-sirf.c | 55 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index a50ee9b..a69ccb7 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -631,14 +631,47 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static int spi_sirfsoc_setup(struct spi_device *spi)
 {
 	struct sirfsoc_spi *sspi;
+	int ret = 0;
 
 	sspi = spi_master_get_devdata(spi->master);
 
 	if (spi->cs_gpio == -ENOENT)
 		sspi->hw_cs = true;
-	else
+	else {
 		sspi->hw_cs = false;
-	return spi_sirfsoc_setup_transfer(spi, NULL);
+		if (!spi_get_ctldata(spi)) {
+			void *cs = kmalloc(sizeof(int), GFP_KERNEL);
+			if (!cs) {
+				ret = -ENOMEM;
+				goto exit;
+			}
+			ret = gpio_is_valid(spi->cs_gpio);
+			if (!ret) {
+				dev_err(&spi->dev, "no valid gpio\n");
+				ret = -ENOENT;
+				goto exit;
+			}
+			ret = gpio_request(spi->cs_gpio, DRIVER_NAME);
+			if (ret) {
+				dev_err(&spi->dev, "failed to request gpio\n");
+				goto exit;
+			}
+			spi_set_ctldata(spi, cs);
+		}
+	}
+	writel(readl(sspi->base + SIRFSOC_SPI_CTRL) | SIRFSOC_SPI_CS_IO_MODE,
+			sspi->base + SIRFSOC_SPI_CTRL);
+	spi_sirfsoc_chipselect(spi, BITBANG_CS_INACTIVE);
+exit:
+	return ret;
+}
+
+static void spi_sirfsoc_cleanup(struct spi_device *spi)
+{
+	if (spi_get_ctldata(spi)) {
+		gpio_free(spi->cs_gpio);
+		kfree(spi_get_ctldata(spi));
+	}
 }
 
 static int spi_sirfsoc_probe(struct platform_device *pdev)
@@ -647,7 +680,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *mem_res;
 	int irq;
-	int i, ret;
+	int ret;
 
 	ret = device_reset(&pdev->dev);
 	if (ret) {
@@ -685,6 +718,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	sspi->bitbang.setup_transfer = spi_sirfsoc_setup_transfer;
 	sspi->bitbang.txrx_bufs = spi_sirfsoc_transfer;
 	sspi->bitbang.master->setup = spi_sirfsoc_setup;
+	sspi->bitbang.master->cleanup = spi_sirfsoc_cleanup;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(12) |
@@ -733,21 +767,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
 		goto free_dummypage;
-	for (i = 0; master->cs_gpios && i < master->num_chipselect; i++) {
-		if (master->cs_gpios[i] == -ENOENT)
-			continue;
-		if (!gpio_is_valid(master->cs_gpios[i])) {
-			dev_err(&pdev->dev, "no valid gpio\n");
-			ret = -EINVAL;
-			goto free_dummypage;
-		}
-		ret = devm_gpio_request(&pdev->dev,
-				master->cs_gpios[i], DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request gpio\n");
-			goto free_dummypage;
-		}
-	}
 	dev_info(&pdev->dev, "registerred, bus number = %d\n", master->bus_num);
 
 	return 0;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
