From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] spi: tegra114: Convert to use master->max_speed_hz
Date: Mon, 10 Feb 2014 21:48:16 +0800
Message-ID: <1392040096.4191.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use master->max_speed_hz instead of tspi->spi_max_frequency, so spi core will
handle checking transfer speed.

In additional, since commit 052eb2d49006 'spi: core: Set max_speed_hz of
spi_device default to max_speed_hz of controller',
spi core will also set default spi->max_speed_hz if it is not set.
So remove the duplicate code in tegra_spi_setup.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra114.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 0930d60..2f8aba5 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -171,7 +171,6 @@ struct tegra_spi_data {
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned				irq;
-	u32					spi_max_frequency;
 	u32					cur_speed;
 
 	struct spi_device			*cur_spi;
@@ -762,9 +761,6 @@ static int tegra_spi_setup(struct spi_device *spi)
 
 	BUG_ON(spi->chip_select >= MAX_CHIP_SELECT);
 
-	/* Set speed to the spi max fequency if spi device has not set */
-	spi->max_speed_hz = spi->max_speed_hz ? : tspi->spi_max_frequency;
-
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
@@ -1018,16 +1014,6 @@ static irqreturn_t tegra_spi_isr(int irq, void *context_data)
 	return IRQ_WAKE_THREAD;
 }
 
-static void tegra_spi_parse_dt(struct platform_device *pdev,
-	struct tegra_spi_data *tspi)
-{
-	struct device_node *np = pdev->dev.of_node;
-
-	if (of_property_read_u32(np, "spi-max-frequency",
-				&tspi->spi_max_frequency))
-		tspi->spi_max_frequency = 25000000; /* 25MHz */
-}
-
 static struct of_device_id tegra_spi_of_match[] = {
 	{ .compatible = "nvidia,tegra114-spi", },
 	{}
@@ -1049,8 +1035,9 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	tspi = spi_master_get_devdata(master);
 
-	/* Parse DT */
-	tegra_spi_parse_dt(pdev, tspi);
+	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
+				 &master->max_speed_hz))
+		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
