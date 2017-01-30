From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: fix device-node leaks
Date: Mon, 30 Jan 2017 17:47:05 +0100
Message-ID: <20170130164705.21727-1-johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Make sure to release the device-node reference taken in
of_register_spi_device() on errors and when deregistering the device.

Fixes: 284b01897340 ("spi: Add OF binding support for SPI busses")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..730e3c9794db 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -621,8 +621,10 @@ void spi_unregister_device(struct spi_device *spi)
 	if (!spi)
 		return;
 
-	if (spi->dev.of_node)
+	if (spi->dev.of_node) {
 		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
+		of_node_put(spi->dev.of_node);
+	}
 	if (ACPI_COMPANION(&spi->dev))
 		acpi_device_clear_enumerated(ACPI_COMPANION(&spi->dev));
 	device_unregister(&spi->dev);
@@ -1603,11 +1605,13 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	if (rc) {
 		dev_err(&master->dev, "spi_device register error %s\n",
 			nc->full_name);
-		goto err_out;
+		goto err_of_node_put;
 	}
 
 	return spi;
 
+err_of_node_put:
+	of_node_put(nc);
 err_out:
 	spi_dev_put(spi);
 	return ERR_PTR(rc);
-- 
2.10.2
