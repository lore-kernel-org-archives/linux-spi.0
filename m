From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] spi: tegra20-sflash: Convert to use master->max_speed_hz
Date: Mon, 10 Feb 2014 21:49:49 +0800
Message-ID: <1392040189.4191.3.camel@phoenix>
References: <1392040096.4191.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392040096.4191.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use master->max_speed_hz instead of tspi->spi_max_frequency, so spi core will
handle checking transfer speed.

In additional, since commit 052eb2d49006 'spi: core: Set max_speed_hz of
spi_device default to max_speed_hz of controller',
spi core will also set default spi->max_speed_hz if it is not set.
So remove tegra_sflash_setup().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-sflash.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 18037ab..5db73c0 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -120,7 +120,6 @@ struct tegra_sflash_data {
 	struct reset_control			*rst;
 	void __iomem				*base;
 	unsigned				irq;
-	u32					spi_max_frequency;
 	u32					cur_speed;
 
 	struct spi_device			*cur_spi;
@@ -314,15 +313,6 @@ static int tegra_sflash_start_transfer_one(struct spi_device *spi,
 	return tegra_sflash_start_cpu_based_transfer(tsd, t);
 }
 
-static int tegra_sflash_setup(struct spi_device *spi)
-{
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(spi->master);
-
-	/* Set speed to the spi max fequency if spi device has not set */
-	spi->max_speed_hz = spi->max_speed_hz ? : tsd->spi_max_frequency;
-	return 0;
-}
-
 static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -429,15 +419,6 @@ static irqreturn_t tegra_sflash_isr(int irq, void *context_data)
 	return handle_cpu_based_xfer(tsd);
 }
 
-static void tegra_sflash_parse_dt(struct tegra_sflash_data *tsd)
-{
-	struct device_node *np = tsd->dev->of_node;
-
-	if (of_property_read_u32(np, "spi-max-frequency",
-					&tsd->spi_max_frequency))
-		tsd->spi_max_frequency = 25000000; /* 25MHz */
-}
-
 static struct of_device_id tegra_sflash_of_match[] = {
 	{ .compatible = "nvidia,tegra20-sflash", },
 	{}
@@ -466,7 +447,6 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
-	master->setup = tegra_sflash_setup;
 	master->transfer_one_message = tegra_sflash_transfer_one_message;
 	master->auto_runtime_pm = true;
 	master->num_chipselect = MAX_CHIP_SELECT;
@@ -478,7 +458,9 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	tsd->dev = &pdev->dev;
 	spin_lock_init(&tsd->lock);
 
-	tegra_sflash_parse_dt(tsd);
+	if (of_property_read_u32(tsd->dev->of_node, "spi-max-frequency",
+				 &master->max_speed_hz))
+		master->max_speed_hz = 25000000; /* 25MHz */
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tsd->base = devm_ioremap_resource(&pdev->dev, r);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
