From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RESEND PATCH] spi: of: do explicitly request modules for
 of-registered devices
Date: Wed, 25 Mar 2015 13:32:22 -0700
Message-ID: <20150325203222.GA8845@dtor-ws>
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
results in an ugly complaint from request_module() warning about potential
deadlock (because request_module tries to wait for async works to
complete, the caller is also an async work in this case).

While we could try to switch to using request_module_nowait(), other buses,
as well as SPI itself when not using device tree, do not try to load
modules explicitly, but rather rely on the standard infrastructure (such as
udev) to execute module loading. There is no reason why SPI OF-described
devices should be treated differently.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Mark,

I chatted with Grant who I believe added the code originally and he said
he does not recall a good reason for it to actually be there.

Thanks!

 drivers/spi/spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c64a3e5..102a9e6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/kmod.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/cache.h>
@@ -1359,7 +1358,6 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
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
