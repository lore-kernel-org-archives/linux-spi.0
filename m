From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH] spi: erase pointer to drvdata on removal
Date: Thu,  1 Nov 2012 14:05:36 -0400
Message-ID: <1351793136-14126-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

As for i2c-core, let the SPI core handle the removal of the device's
drvdata, after a remove() or a probe() failure.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/spi/spi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 84c2861..fe636fe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -233,15 +233,25 @@ EXPORT_SYMBOL_GPL(spi_bus_type);
 static int spi_drv_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+	struct spi_device		*sdev = to_spi_device(dev);
+	int				status;
 
-	return sdrv->probe(to_spi_device(dev));
+	status = sdrv->probe(sdev);
+	if (status)
+		spi_set_drvdata(sdev, NULL);
+	return status;
 }
 
 static int spi_drv_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+	struct spi_device		*sdev = to_spi_device(dev);
+	int				status;
 
-	return sdrv->remove(to_spi_device(dev));
+	status = sdrv->remove(sdev);
+	if (status == 0)
+		spi_set_drvdata(sdev, NULL);
+	return status;
 }
 
 static void spi_drv_shutdown(struct device *dev)
-- 
1.7.11.7
