From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Map SPI OF client IRQ at probe time" to the spi tree
Date: Mon, 12 Oct 2015 17:59:33 +0100
Message-ID: <E1ZlgRh-00051m-1m@finisterre>
References: <1444401955-25200-1-git-send-email-jonathanh@nvidia.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
	Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444401955-25200-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Map SPI OF client IRQ at probe time

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 44af7927316e83eb8865933f7c836dcc85f8eb74 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Fri, 9 Oct 2015 15:45:55 +0100
Subject: [PATCH] spi: Map SPI OF client IRQ at probe time

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3abb390..40c9afa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -270,15 +270,24 @@ EXPORT_SYMBOL_GPL(spi_bus_type);
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
@@ -1433,9 +1442,6 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	}
 	spi->max_speed_hz = value;
 
-	/* IRQ */
-	spi->irq = irq_of_parse_and_map(nc, 0);
-
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
 	spi->dev.of_node = nc;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
