From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] spi: of: do not try load modules for of-registered devices
Date: Fri, 16 Jan 2015 00:08:05 -0800
Message-ID: <20150116080805.GA8206@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Grant Likely <grant.likely@linaro.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Trying to register an SPI device asynchronously (via async_schedule() call)
results in an ugly warning from request_module() warning about potential
deadlock (because request_module tries to wait for async works to
complete). While we could try to switch to request_module_nowait(), other
buses, as well as SPI itself when not using device tree, do not try to load
modules, but rather rely on the standard infrastructure (udev) to execute
module loading, and we should be doing the same.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 66a70e9..e1b15d5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/kmod.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/cache.h>
@@ -1320,7 +1319,6 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	spi->dev.of_node = nc;
 
 	/* Register the new device */
-	request_module("%s%s", SPI_MODULE_PREFIX, spi->modalias);
 	rc = spi_add_device(spi);
 	if (rc) {
 		dev_err(&master->dev, "spi_device register error %s\n",
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
