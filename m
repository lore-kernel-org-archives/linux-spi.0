From: aaro.koskinen@nokia.com
Subject: [PATCH] spi: spi_register_controller(): free bus id on error paths
Date: Wed,  4 Mar 2020 13:17:40 +0200
Message-ID: <20200304111740.27915-1-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Some error paths leave the bus id allocated. As a result the IDR
allocation will fail after a deferred probe. Fix by freeing the bus id
always on error.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/spi/spi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38b4c78df506..755221bc3745 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2639,7 +2639,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (ctlr->use_gpio_descriptors) {
 			status = spi_get_gpio_descs(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 			/*
 			 * A controller using GPIO descriptors always
 			 * supports SPI_CS_HIGH if need be.
@@ -2649,7 +2649,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			/* Legacy code path for GPIOs from DT */
 			status = of_spi_get_gpio_numbers(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 		}
 	}
 
@@ -2657,17 +2657,14 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 * Even if it's just one always-selected device, there must
 	 * be at least one chipselect.
 	 */
-	if (!ctlr->num_chipselect)
-		return -EINVAL;
+	if (!ctlr->num_chipselect) {
+		status = -EINVAL;
+		goto free_bus_id;
+	}
 
 	status = device_add(&ctlr->dev);
-	if (status < 0) {
-		/* free bus id */
-		mutex_lock(&board_lock);
-		idr_remove(&spi_master_idr, ctlr->bus_num);
-		mutex_unlock(&board_lock);
-		goto done;
-	}
+	if (status < 0)
+		goto free_bus_id;
 	dev_dbg(dev, "registered %s %s\n",
 			spi_controller_is_slave(ctlr) ? "slave" : "master",
 			dev_name(&ctlr->dev));
@@ -2683,11 +2680,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		status = spi_controller_initialize_queue(ctlr);
 		if (status) {
 			device_del(&ctlr->dev);
-			/* free bus id */
-			mutex_lock(&board_lock);
-			idr_remove(&spi_master_idr, ctlr->bus_num);
-			mutex_unlock(&board_lock);
-			goto done;
+			goto free_bus_id;
 		}
 	}
 	/* add statistics */
@@ -2702,7 +2695,12 @@ int spi_register_controller(struct spi_controller *ctlr)
 	/* Register devices from the device tree and ACPI */
 	of_register_spi_devices(ctlr);
 	acpi_register_spi_devices(ctlr);
-done:
+	return status;
+
+free_bus_id:
+	mutex_lock(&board_lock);
+	idr_remove(&spi_master_idr, ctlr->bus_num);
+	mutex_unlock(&board_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
-- 
2.11.0
