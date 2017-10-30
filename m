From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 2/3] spi: document odd controller reference handling
Date: Mon, 30 Oct 2017 11:35:26 +0100
Message-ID: <20171030103527.13535-2-johan@kernel.org>
References: <20171030103527.13535-1-johan@kernel.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
        Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171030103527.13535-1-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Document the fact that a reference to the controller is dropped as part
of deregistration.

This is an odd pattern as the reference is typically taken in
__spi_alloc_controller() rather than spi_register_controller(). Most
controller drivers gets it right these days and notably the
device-managed interface relies on this behaviour.

Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3ff0ee88c467..b33a727a0158 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2200,7 +2200,7 @@ static void devm_spi_unregister(struct device *dev, void *res)
  * Context: can sleep
  *
  * Register a SPI device as with spi_register_controller() which will
- * automatically be unregister
+ * automatically be unregistered and freed.
  *
  * Return: zero on success, else a negative error code.
  */
@@ -2241,6 +2241,8 @@ static int __unregister(struct device *dev, void *null)
  * only ones directly touching chip registers.
  *
  * This must be called from context that can sleep.
+ *
+ * Note that this function also drops a reference to the controller.
  */
 void spi_unregister_controller(struct spi_controller *ctlr)
 {
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
