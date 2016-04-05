From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: cadance: Fix the Documentation" to the spi tree
Date: Tue, 05 Apr 2016 11:51:53 -0700
Message-ID: <E1anW4v-0000QV-65@finisterre>
References: <1459879674-13012-4-git-send-email-shubhraj@xilinx.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459879674-13012-4-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: cadance: Fix the Documentation

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

>From b4037360e66b90755ed73022976f10108bc82045 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Date: Tue, 5 Apr 2016 23:37:51 +0530
Subject: [PATCH] spi: cadance: Fix the Documentation

cdns_spi_chipselect has parameter is_high however the comment
describes it as is_on.
Also fixes the below warning.
drivers/spi/spi-cadence.c:182: warning: No description found for
parameter 'is_high'
drivers/spi/spi-cadence.c:182: warning: Excess function parameter 'is_on'
description in 'cdns_spi_chipselect'

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 2915b257921d..8a6fee934364 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -169,7 +169,7 @@ static void cdns_spi_init_hw(struct cdns_spi *xspi)
 /**
  * cdns_spi_chipselect - Select or deselect the chip select line
  * @spi:	Pointer to the spi_device structure
- * @is_on:	Select(0) or deselect (1) the chip select line
+ * @is_high:	Select(0) or deselect (1) the chip select line
  */
 static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 {
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
