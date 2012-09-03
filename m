From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Revert "spi/doc: spi_master_put must be followed up by kfree"
Date: Mon,  3 Sep 2012 13:26:26 -0700
Message-ID: <1346703986-7849-1-git-send-email-linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Actually, spi_master_put() after spi_alloc_master() must _not_ be followed
by kfree(). The memory is already freed with the call to spi_master_put()
through spi_master_class, which registers a release function. Calling both
spi_master_put() and kfree() results in often nasty (and delayed) crashes
elsewhere in the kernel, often in the networking stack.

This reverts commit eb4af0f5349235df2e4a5057a72fc8962d00308a.

Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/spi/spi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2d9b5bb..6470750 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1082,8 +1082,7 @@ static struct class spi_master_class = {
  *
  * The caller is responsible for assigning the bus number and initializing
  * the master's methods before calling spi_register_master(); and (after errors
- * adding the device) calling spi_master_put() and kfree() to prevent a memory
- * leak.
+ * adding the device) calling spi_master_put() to prevent a memory leak.
  */
 struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 {
-- 
1.7.9.7
