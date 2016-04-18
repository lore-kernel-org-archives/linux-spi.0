From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: cadence: mark pm functions __maybe_unused" to the spi tree
Date: Mon, 18 Apr 2016 14:11:03 +0100
Message-ID: <E1as8xD-00025Y-TB@debutante>
References: <1460839171-1252854-1-git-send-email-arnd@arndb.de>
Cc: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>,
	Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460839171-1252854-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: cadence: mark pm functions __maybe_unused

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 148b1eb93c9b54e61d7937b5a5760030276240ab Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Sat, 16 Apr 2016 22:39:21 +0200
Subject: [PATCH] spi: cadence: mark pm functions __maybe_unused

The newly added runtime PM support for the cadence spi driver
causes harmless warnings when PM is disabled:

drivers/spi/spi-cadence.c:681:12: warning: 'cnds_runtime_suspend' defined but not used
drivers/spi/spi-cadence.c:652:12: warning: 'cnds_runtime_resume' defined but not used

This adds __maybe_unused annotations to the respective functions
to shut up the warnings, while leaving the code in place for
compile testing and avoiding ugly #ifdefs.

Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
