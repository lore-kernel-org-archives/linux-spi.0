From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Use dummy buffers provided by SPI core" to the spi tree
Date: Tue, 29 Mar 2016 00:42:23 -0700
Message-ID: <E1akoIB-0007qM-H4@finisterre>
References: <1458746964-9335-3-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458746964-9335-3-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Use dummy buffers provided by SPI core

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

>From 8c3ad488fe0e4478b3b29b9501074c5fb1bfda0d Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 24 Mar 2016 15:35:44 +0200
Subject: [PATCH] spi: pxa2xx: Use dummy buffers provided by SPI core

Dummy buffer is used for half duplex transfers that don't have TX or RX
buffer set. Instead of own dummy buffer management here let the SPI core to
handle it by setting the SPI_MASTER_MUST_RX and SPI_MASTER_MUST_TX flags.
Then core makes sure both transfer buffers are set.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c | 10 +---------
 drivers/spi/spi-pxa2xx.c     |  1 +
 drivers/spi/spi-pxa2xx.h     |  1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 624cb06bd2e1..a18a03d0afb7 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -53,11 +53,7 @@ static int pxa2xx_spi_map_dma_buffer(struct driver_data *drv_data,
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		size_t bytes = min_t(size_t, len, SZ_2K);
 
-		if (buf)
-			sg_set_buf(sg, pbuf, bytes);
-		else
-			sg_set_buf(sg, drv_data->dummy, bytes);
-
+		sg_set_buf(sg, pbuf, bytes);
 		pbuf += bytes;
 		len -= bytes;
 	}
@@ -312,10 +308,6 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	drv_data->dummy = devm_kzalloc(dev, SZ_2K, GFP_KERNEL);
-	if (!drv_data->dummy)
-		return -ENOMEM;
-
 	drv_data->tx_chan = dma_request_slave_channel_compat(mask,
 				pdata->dma_filter, pdata->tx_param, dev, "tx");
 	if (!drv_data->tx_chan)
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 47bdbd350a24..86c155aea0cf 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1562,6 +1562,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
 	master->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
 	master->auto_runtime_pm = true;
+	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
 
 	drv_data->ssp_type = ssp->type;
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 85017f9ca67c..e6b09000ff14 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -56,7 +56,6 @@ struct driver_data {
 	struct sg_table tx_sgt;
 	int rx_nents;
 	int tx_nents;
-	void *dummy;
 	atomic_t dma_running;
 
 	/* Current message transfer state info */
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
