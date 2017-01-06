From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: [RESEND] spi: davinci: Allow device tree devices to use DMA
Date: Thu,  5 Jan 2017 21:26:17 -0600
Message-ID: <1483673177-31516-1-git-send-email-david@lechnology.com>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org,
        khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This allows SPI devices specified in a device tree to use DMA when the
master controller.

Since device tree is supposed to only describe the hardware, adding such
a configuration option to device tree would not be acceptable. So, this
is the best we can do for now to get SPI devices working with DMA.

Unfortunately, this excludes the possibility of using one SPI device with
DMA and one without on the same master.

Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
---

When I originally submitted this patch, there was some discussion as to whether
dspi->dma_rx should be changed to return an error rather than being null.

However, I prefer it the way it is and don't see a compelling reason to change
it.

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
