From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 05/11] spi: imx: Add support for loopback for ECSPI controllers
Date: Sat,  5 Dec 2015 17:57:03 +0100
Message-ID: <1449334629-4715-6-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449334629-4715-1-git-send-email-anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Support for ECSPI loopback for IMX51, IMX53 and IMX6Q using TEST register.

Signed-off-by: Mohsin Kazmi <mohsin_kazmi-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-imx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 363276d..3525616 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -246,6 +246,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_STAT		0x18
 #define MX51_ECSPI_STAT_RR		(1 <<  3)
 
+#define MX51_ECSPI_TEST			0x20
+#define MX51_ECSPI_LOOP			BIT(31)
+
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
 				      unsigned int *fres)
@@ -316,6 +319,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
 	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
 	u32 clk = config->speed_hz, delay;
+	u32 lpb = 0;
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -356,6 +360,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
+	if (config->mode & SPI_LOOP)
+		lpb |= MX51_ECSPI_LOOP;
+
+	if ((readl(spi_imx->base + MX51_ECSPI_TEST) & MX51_ECSPI_LOOP) != lpb)
+		writel(lpb, spi_imx->base + MX51_ECSPI_TEST);
+
 	/*
 	 * Wait until the changes in the configuration register CONFIGREG
 	 * propagate into the hardware. It takes exactly one tick of the
@@ -1128,6 +1138,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
 
+	spi_imx->devtype_data = of_id ? of_id->data :
+		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
+
 	for (i = 0; i < master->num_chipselect; i++) {
 		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
 		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
@@ -1154,10 +1167,10 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
-	init_completion(&spi_imx->xfer_done);
+	if (is_imx51_ecspi(spi_imx))
+		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
 
-	spi_imx->devtype_data = of_id ? of_id->data :
-		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
+	init_completion(&spi_imx->xfer_done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
