From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 3/4] spi: dw: Add basic runtime PM support
Date: Wed, 18 Sep 2019 09:04:35 +0100
Message-ID: <1568793876-9009-4-git-send-email-gareth.williams.jx@renesas.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Enable runtime PM so that the clock used to access the registers in the
peripheral is turned on using a clock domain.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
v2:
 - set spi_controller.auto_runtime_pm instead of using
   pm_runtime_get_sync.
 - Added pm_runtime_disable calls to dw_spi_remove_host and the error
   condition of dw_spi_add_host.
---
 drivers/spi/spi-dw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e07..54ed6eb 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
@@ -493,10 +494,13 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->dev.of_node = dev->of_node;
 	master->dev.fwnode = dev->fwnode;
 	master->flags = SPI_MASTER_GPIO_SS;
+	master->auto_runtime_pm = true;
 
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
+	pm_runtime_enable(dev);
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
@@ -525,6 +529,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, master);
 err_free_master:
+	pm_runtime_disable(dev);
 	spi_controller_put(master);
 	return ret;
 }
@@ -539,6 +544,9 @@ void dw_spi_remove_host(struct dw_spi *dws)
 
 	spi_shutdown_chip(dws);
 
+	if (dws->master)
+		pm_runtime_disable(&dws->master->dev);
+
 	free_irq(dws->irq, dws->master);
 }
 EXPORT_SYMBOL_GPL(dw_spi_remove_host);
-- 
2.7.4
