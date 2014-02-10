From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] spi: tegra20-slink: Convert to use master->max_speed_hz
Date: Mon, 10 Feb 2014 21:51:13 +0800
Message-ID: <1392040273.4191.5.camel@phoenix>
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
So remove the duplicate code in tegra_slink_setup.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 8d62710..9a060aa 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -170,7 +170,6 @@ struct tegra_slink_data {
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned				irq;
-	u32					spi_max_frequency;
 	u32					cur_speed;
 
 	struct spi_device			*cur_spi;
@@ -762,8 +761,6 @@ static int tegra_slink_setup(struct spi_device *spi)
 
 	BUG_ON(spi->chip_select >= MAX_CHIP_SELECT);
 
-	/* Set speed to the spi max fequency if spi device has not set */
-	spi->max_speed_hz = spi->max_speed_hz ? : tspi->spi_max_frequency;
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
@@ -998,15 +995,6 @@ static irqreturn_t tegra_slink_isr(int irq, void *context_data)
 	return IRQ_WAKE_THREAD;
 }
 
-static void tegra_slink_parse_dt(struct tegra_slink_data *tspi)
-{
-	struct device_node *np = tspi->dev->of_node;
-
-	if (of_property_read_u32(np, "spi-max-frequency",
-					&tspi->spi_max_frequency))
-		tspi->spi_max_frequency = 25000000; /* 25MHz */
-}
-
 static const struct tegra_slink_chip_data tegra30_spi_cdata = {
 	.cs_hold_time = true,
 };
@@ -1061,7 +1049,9 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tspi->chip_data = cdata;
 	spin_lock_init(&tspi->lock);
 
-	tegra_slink_parse_dt(tspi);
+	if (of_property_read_u32(tspi->dev->of_node, "spi-max-frequency",
+				 &master->max_speed_hz))
+		master->max_speed_hz = 25000000; /* 25MHz */
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
