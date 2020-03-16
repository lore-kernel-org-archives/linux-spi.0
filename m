From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 5.4 26/35] spi: spi_register_controller(): free bus id on error paths
Date: Sun, 15 Mar 2020 22:34:02 -0400
Message-ID: <20200316023411.1263-26-sashal@kernel.org>
References: <20200316023411.1263-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200316023411.1263-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

[ Upstream commit f9981d4f50b475d7dbb70f3022b87a3c8bba9fd6 ]

Some error paths leave the bus id allocated. As a result the IDR
allocation will fail after a deferred probe. Fix by freeing the bus id
always on error.

Signed-off-by: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Message-Id: <20200304111740.27915-1-aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 26b91ee0855dc..c186d3a944cd0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2452,7 +2452,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (ctlr->use_gpio_descriptors) {
 			status = spi_get_gpio_descs(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 			/*
 			 * A controller using GPIO descriptors always
 			 * supports SPI_CS_HIGH if need be.
@@ -2462,7 +2462,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			/* Legacy code path for GPIOs from DT */
 			status = of_spi_get_gpio_numbers(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 		}
 	}
 
@@ -2470,17 +2470,14 @@ int spi_register_controller(struct spi_controller *ctlr)
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
@@ -2496,11 +2493,7 @@ int spi_register_controller(struct spi_controller *ctlr)
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
@@ -2515,7 +2508,12 @@ int spi_register_controller(struct spi_controller *ctlr)
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
2.20.1
