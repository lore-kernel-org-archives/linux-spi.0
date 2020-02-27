From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] spi: pxa2xx: Introduce is_mmp2_ssp() helper
Date: Thu, 27 Feb 2020 18:25:56 +0200
Message-ID: <20200227162556.3152-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Introduce is_mmp2_ssp() helper to be consistent with the rest
helper function to distinguish SSP type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 19d43c7ed1a0..b9db6bbd03e0 100644
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
2.25.0
