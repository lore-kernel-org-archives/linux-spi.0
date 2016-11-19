From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: [PATCH] spi: davinci: Allow device tree devices to use DMA
Date: Fri, 18 Nov 2016 22:41:04 -0600
Message-ID: <1479530464-12538-1-git-send-email-david@lechnology.com>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org,
        khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This makes SPI devices specified in a device tree use DMA when the master
controller has DMA configured.

Since device tree is supposed to only describe the hardware, adding a
configuration option to device tree to enable DMA per-device would not be
acceptable. So, this is the best we can do for now to get SPI devices
working with DMA when using device tree.

Unfortunately, this excludes the possibility of using one SPI device with
DMA and one without on the same master.

I have tested this on LEGO MINDSTORMS EV3 using the NOR flash. Reading the
flash memory would fail with -EIO when DMA is not enabled for the device.

Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d36c11b..c6cf73a 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -388,6 +388,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 static int davinci_spi_of_setup(struct spi_device *spi)
 {
 	struct davinci_spi_config *spicfg = spi->controller_data;
+	struct davinci_spi *dspi = spi_master_get_devdata(spi->master);
 	struct device_node *np = spi->dev.of_node;
 	u32 prop;
 
@@ -400,6 +401,9 @@ static int davinci_spi_of_setup(struct spi_device *spi)
 		if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
 			spicfg->wdelay = (u8)prop;
 		spi->controller_data = spicfg;
+		/* Use DMA for device if master supports it */
+		if (dspi->dma_rx)
+			spicfg->io_type = SPI_IO_TYPE_DMA;
 	}
 
 	return 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
