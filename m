From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: cadence: mark pm functions __maybe_unused
Date: Sat, 16 Apr 2016 22:39:21 +0200
Message-ID: <1460839171-1252854-1-git-send-email-arnd@arndb.de>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>,
	Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The newly added runtime PM support for the cadence spi driver
causes harmless warnings when PM is disabled:

drivers/spi/spi-cadence.c:681:12: warning: 'cnds_runtime_suspend' defined but not used
drivers/spi/spi-cadence.c:652:12: warning: 'cnds_runtime_resume' defined but not used

This adds __maybe_unused annotations to the respective functions
to shut up the warnings, while leaving the code in place for
compile testing and avoiding ugly #ifdefs.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
---
 drivers/spi/spi-cadence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 8a0bd62a5088..1c57ce64abba 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -651,7 +651,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int cnds_runtime_resume(struct device *dev)
+static int __maybe_unused cnds_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
@@ -680,7 +680,7 @@ static int cnds_runtime_resume(struct device *dev)
  *
  * Return:	Always 0
  */
-static int cnds_runtime_suspend(struct device *dev)
+static int __maybe_unused cnds_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
