From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Introduce is_mmp2_ssp() helper" to the spi tree
Date: Fri, 28 Feb 2020 18:25:19 +0000
Message-ID: <applied-20200227162556.3152-1-andriy.shevchenko@linux.intel.com>
References: <20200227162556.3152-1-andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200227162556.3152-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Introduce is_mmp2_ssp() helper

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

>From 41c9884170c54013edd2481978cae917f94d40b4 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 27 Feb 2020 18:25:56 +0200
Subject: [PATCH] spi: pxa2xx: Introduce is_mmp2_ssp() helper

Introduce is_mmp2_ssp() helper to be consistent with the rest
helper function to distinguish SSP type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Link: https://lore.kernel.org/r/20200227162556.3152-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 8e8e18023ded..aa93bbf0e1d4 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -185,6 +185,11 @@ static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
 	return drv_data->ssp_type == QUARK_X1000_SSP;
 }
 
+static bool is_mmp2_ssp(const struct driver_data *drv_data)
+{
+	return drv_data->ssp_type == MMP2_SSP;
+}
+
 static u32 pxa2xx_spi_get_ssrc1_change_mask(const struct driver_data *drv_data)
 {
 	switch (drv_data->ssp_type) {
@@ -463,8 +468,8 @@ int pxa2xx_spi_flush(struct driver_data *drv_data)
 
 static void pxa2xx_spi_off(struct driver_data *drv_data)
 {
-	/* On MMP, disabling SSE seems to corrupt the rx fifo */
-	if (drv_data->ssp_type == MMP2_SSP)
+	/* On MMP, disabling SSE seems to corrupt the Rx FIFO */
+	if (is_mmp2_ssp(drv_data))
 		return;
 
 	pxa2xx_spi_write(drv_data, SSCR0,
@@ -1070,7 +1075,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
 	    != (cr1 & change_mask)) {
 		/* stop the SSP, and update the other bits */
-		if (drv_data->ssp_type != MMP2_SSP)
+		if (!is_mmp2_ssp(drv_data))
 			pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
 		if (!pxa25x_ssp_comp(drv_data))
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
@@ -1084,7 +1089,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
-	if (drv_data->ssp_type == MMP2_SSP) {
+	if (is_mmp2_ssp(drv_data)) {
 		u8 tx_level = (pxa2xx_spi_read(drv_data, SSSR)
 					& SSSR_TFL_MASK) >> 8;
 
-- 
2.20.1
