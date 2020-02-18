From: Shobhit Srivastava <shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] spi: pxa2xx: Enable SSP controller for CS toggle
Date: Tue, 18 Feb 2020 19:19:06 +0530
Message-ID: <20200218191752.1.I5dcc25df7fd0fda29d57f5127337348e4c447852@changeid>
References: <20200218134906.25458-1-shobhit.srivastava@intel.com>
Cc: furquan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, evgreen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
        andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        robert.jarzmik-GANU6spQydw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200218134906.25458-1-shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In some circumstances on Intel LPSS controllers, toggling the LPSS
CS control register doesn't actually cause the CS line to toggle.
This ruins SPI transactions that either rely on delay_usecs,
or toggle the CS line without sending any data.
This seems to be because the SSP controller is in disabled state.
As per the spec, the controller needs to be enabled for CS change
to take effect.
This issue is not seen in cases where there is data to be
transferred because then the SSCR0 gets enabled via
pxa2xx_configure_sscr0().

Signed-off-by: Shobhit Srivastava <shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 drivers/spi/spi-pxa2xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4c7a71f0fb3e..414afc72ef44 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -370,7 +370,7 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
 	const struct lpss_config *config;
-	u32 value;
+	u32 value, sscr0;
 
 	config = lpss_get_config(drv_data);
 
@@ -382,7 +382,18 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 		value &= ~LPSS_CS_CONTROL_CS_HIGH;
 	else
 		value |= LPSS_CS_CONTROL_CS_HIGH;
+
+	/* To propagate CS value to output, the controller should
+	 * be enabled. This is needed for devices that just do
+	 * CS assert, wait and CS deassert without sending any data.
+	 */
+	sscr0 = pxa2xx_spi_read(drv_data, SSCR0);
+	pxa2xx_spi_write(drv_data, SSCR0, sscr0 | SSCR0_SSE);
+
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
+
+	/* Restore the original SSCR0 config*/
+	 pxa2xx_spi_write(drv_data, SSCR0, sscr0);
 }
 
 static void cs_assert(struct spi_device *spi)
-- 
2.17.1
