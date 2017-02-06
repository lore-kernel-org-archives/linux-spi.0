From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] spi: davinci: enable DMA when channels are defined in DT
Date: Mon,  6 Feb 2017 15:57:08 +0100
Message-ID: <20170206145708.24356-2-fparent@baylibre.com>
References: <20170206145708.24356-1-fparent@baylibre.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170206145708.24356-1-fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When booting with DT the SPI driver is always using
the SPI_IO_TYPE_INTR mode to transfer data even if DMA channels are
defined in the DT.

This commit changes the behaviour to select the SPI_IO_TYPE_DMA mode
if DMA channels are defined in the DT and will keep SPI_IO_TYPE_INTR
if the channels are not defined in it.

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index cb80c1d3f86a..b73072ae8adb 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -389,6 +389,7 @@ static int davinci_spi_of_setup(struct spi_device *spi)
 {
 	struct davinci_spi_config *spicfg = spi->controller_data;
 	struct device_node *np = spi->dev.of_node;
+	struct davinci_spi *dspi = spi_master_get_devdata(spi->master);
 	u32 prop;
 
 	if (spicfg == NULL && np) {
@@ -400,6 +401,9 @@ static int davinci_spi_of_setup(struct spi_device *spi)
 		if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
 			spicfg->wdelay = (u8)prop;
 		spi->controller_data = spicfg;
+
+		if (dspi->dma_rx && dspi->dma_tx)
+			spicfg->io_type = SPI_IO_TYPE_DMA;
 	}
 
 	return 0;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
