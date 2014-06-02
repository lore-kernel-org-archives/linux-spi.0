From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 18/18] [RFC] spi: rspi: Add DT support to DMA setup
Date: Mon,  2 Jun 2014 15:38:20 +0200
Message-ID: <1401716301-29612-19-git-send-email-geert+renesas@glider.be>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
The format of the DMA specifiers depends on the DT bindings for SHDMA,
which are still under development.
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt |  6 ++++
 drivers/spi/spi-rspi.c                             | 37 ++++++++++++++--------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index d57d82a74054..a274073bd41d 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -30,6 +30,9 @@ Required properties:
 
 Optional properties:
 - clocks           : Must contain a reference to the functional clock.
+- dmas             : Must contain a list of two references to DMA specifiers,
+		     one for transmission, and one for reception.
+- dma-names        : Must contain a list of two DMA names, "tx" and "rx".
 
 Pinctrl properties might be needed, too.  See
 Documentation/devicetree/bindings/pinctrl/renesas,*.
@@ -58,4 +61,7 @@ Examples:
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		dmas = <&dma0 R8A7791_DMA_QSPI_TX CHCR_TX_8BIT>,
+		       <&dma0 R8A7791_DMA_QSPI_RX CHCR_RX_8BIT>;
+		dma-names = "tx", "rx";
 	};
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 10112745bb17..16de9ad60d74 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -874,10 +874,11 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, shdma_chan_filter,
-				   (void *)(unsigned long)id);
+	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+				(void *)(unsigned long)id, dev,
+				dir == DMA_MEM_TO_DEV ? "tx" : "rx");
 	if (!chan) {
-		dev_warn(dev, "dma_request_channel failed\n");
+		dev_warn(dev, "dma_request_slave_channel_compat failed\n");
 		return NULL;
 	}
 
@@ -903,22 +904,30 @@ static int rspi_request_dma(struct device *dev, struct spi_master *master,
 			    const struct resource *res)
 {
 	const struct rspi_plat_data *rspi_pd = dev_get_platdata(dev);
+	unsigned int dma_tx_id, dma_rx_id;
+
+	if (dev->of_node) {
+		/* In the OF case we will get the slave IDs from the DT */
+		dma_tx_id = 0;
+		dma_rx_id = 0;
+	} else if (rspi_pd && rspi_pd->dma_tx_id && rspi_pd->dma_rx_id) {
+		dma_tx_id = rspi_pd->dma_tx_id;
+		dma_rx_id = rspi_pd->dma_rx_id;
+	} else {
+		/* The driver assumes no error. */
+		return 0;
+	}
 
-	if (!rspi_pd || !rspi_pd->dma_rx_id || !rspi_pd->dma_tx_id)
-		return 0;	/* The driver assumes no error. */
-
-	master->dma_rx = rspi_request_dma_chan(dev, DMA_DEV_TO_MEM,
-					       rspi_pd->dma_rx_id,
+	master->dma_tx = rspi_request_dma_chan(dev, DMA_MEM_TO_DEV, dma_tx_id,
 					       res->start + RSPI_SPDR);
-	if (!master->dma_rx)
+	if (!master->dma_tx)
 		return -ENODEV;
 
-	master->dma_tx = rspi_request_dma_chan(dev, DMA_MEM_TO_DEV,
-					       rspi_pd->dma_tx_id,
+	master->dma_rx = rspi_request_dma_chan(dev, DMA_DEV_TO_MEM, dma_rx_id,
 					       res->start + RSPI_SPDR);
-	if (!master->dma_tx) {
-		dma_release_channel(master->dma_rx);
-		master->dma_rx = NULL;
+	if (!master->dma_rx) {
+		dma_release_channel(master->dma_tx);
+		master->dma_tx = NULL;
 		return -ENODEV;
 	}
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
