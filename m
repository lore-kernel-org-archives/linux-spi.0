From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Map SPI OF client IRQ at probe time
Date: Fri, 9 Oct 2015 15:45:55 +0100
Message-ID: <1444401955-25200-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently the IRQs for SPI client devices, registered via device-tree,
are mapped when the client devices are registered. If the corresponding
irq-chip has not been probed yet, then the probing of the client device
will fail and will not be retried. Resolve this by mapping the IRQ at
probe time and allow the probe to be deferred if the IRQ is not yet
available.

If of_irq_get() returns an error that is not -EPROBE_DEFER, then assume
that the SPI client does not have an IRQ and set the IRQ number to zero
(which is equivalent to irq_of_parse_and_map()).

This is based on some inputs from Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.

Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38006cc6543d..4c638f328080 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -331,15 +331,24 @@ EXPORT_SYMBOL_GPL(spi_bus_type);
 static int spi_drv_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+	struct spi_device		*spi = to_spi_device(dev);
 	int ret;
 
 	ret = of_clk_set_defaults(dev->of_node, false);
 	if (ret)
 		return ret;
 
+	if (dev->of_node) {
+		spi->irq = of_irq_get(dev->of_node, 0);
+		if (spi->irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		if (spi->irq < 0)
+			spi->irq = 0;
+	}
+
 	ret = dev_pm_domain_attach(dev, true);
 	if (ret != -EPROBE_DEFER) {
-		ret = sdrv->probe(to_spi_device(dev));
+		ret = sdrv->probe(spi);
 		if (ret)
 			dev_pm_domain_detach(dev, true);
 	}
@@ -1494,9 +1503,6 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	}
 	spi->max_speed_hz = value;
 
-	/* IRQ */
-	spi->irq = irq_of_parse_and_map(nc, 0);
-
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
 	spi->dev.of_node = nc;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
