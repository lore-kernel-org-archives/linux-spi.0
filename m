From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 08/57] drivers: spi: Use bus_find_device_by_of_node helper
Date: Mon,  3 Jun 2019 16:49:34 +0100
Message-ID: <1559577023-558-9-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Switch to using the bus_find_device_by_of_node helper

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944..ecdd602 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3538,16 +3538,11 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF)
-static int __spi_of_device_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /* must call put_device() when done with returned spi_device device */
 struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 {
-	struct device *dev = bus_find_device(&spi_bus_type, NULL, node,
-						__spi_of_device_match);
+	struct device *dev = bus_find_device_by_of_node(&spi_bus_type, NULL, node);
+
 	return dev ? to_spi_device(dev) : NULL;
 }
 EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
-- 
2.7.4
