From: Alexey Klimov <alexey.klimov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH RESEND 1/1] Revert "spi/doc: spi_master_put must be followed up by kfree"
Date: Sun,  6 Sep 2015 01:46:54 +0300
Message-ID: <1441493214-12994-1-git-send-email-alexey.klimov@linaro.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alexey Klimov <alexey.klimov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Actually, spi_master_put() after spi_alloc_master() must _not_ be followed
by kfree(). The memory is already freed with the call to spi_master_put()
through spi_master_class, which registers a release function. Calling both
spi_master_put() and kfree() results in often nasty (and delayed) crashes
elsewhere in the kernel, often in the networking stack.

This reverts commit eb4af0f5349235df2e4a5057a72fc8962d00308a.

Link to patch and concerns: https://lkml.org/lkml/2012/9/3/269
or
http://lkml.iu.edu/hypermail/linux/kernel/1209.0/00790.html

Alexey Klimov: This revert becomes valid after
94c69f765f1b4a658d96905ec59928e3e3e07e6a when spi-imx.c
has been fixed and there is no need to call kfree() so comment
for spi_alloc_master() should be fixed.

Cc: Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Signed-off-by: Alexey Klimov <alexey.klimov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3abb390..a5f53de 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1610,8 +1610,7 @@ static struct class spi_master_class = {
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
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
