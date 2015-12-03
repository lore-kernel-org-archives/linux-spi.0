From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/7] spi: lm70llp: remove multiple blank lines
Date: Thu,  3 Dec 2015 18:29:53 +0530
Message-ID: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

checkpatch complains about multiple blank lines.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---
 drivers/spi/spi-lm70llp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index ba72347..eb4b421 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -23,11 +23,9 @@
 #include <linux/sysfs.h>
 #include <linux/workqueue.h>
 
-
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 
-
 /*
  * The LM70 communicates with a host processor using a 3-wire variant of
  * the SPI/Microwire bus interface. This driver specifically supports an
@@ -88,7 +86,6 @@ struct spi_lm70llp {
 /* REVISIT : ugly global ; provides "exclusive open" facility */
 static struct spi_lm70llp *lm70llp;
 
-
 /*-------------------------------------------------------------------*/
 
 static inline struct spi_lm70llp *spidev_to_pp(struct spi_device *spi)
@@ -319,7 +316,6 @@ static void spi_lm70llp_detach(struct parport *p)
 	lm70llp = NULL;
 }
 
-
 static struct parport_driver spi_lm70llp_drv = {
 	.name =		DRVNAME,
 	.attach =	spi_lm70llp_attach,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
