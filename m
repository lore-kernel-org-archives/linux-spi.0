From: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v1] spi: imx: use pio mode for i.mx6dl
Date: Tue, 3 Feb 2015 10:25:53 +0800
Message-ID: <1422930353-4339-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <Fabio.Estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<hs-ynQEQJNshbs@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For TKT238285 hardware issue which may cause txfifo store data twice can only
be caught on i.mx6dl, we use pio mode instead of DMA mode on i.mx6dl.

Signed-off-by: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 961b97d..fe1b769 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -823,6 +823,10 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	struct dma_slave_config slave_config = {};
 	int ret;
 
+	/* use pio mode for i.mx6dl chip TKT238285 */
+	if (of_machine_is_compatible("fsl,imx6dl"))
+		return 0;
+
 	/* Prepare for TX DMA: */
 	master->dma_tx = dma_request_slave_channel(dev, "tx");
 	if (!master->dma_tx) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
