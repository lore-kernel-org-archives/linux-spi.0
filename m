From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/5] spi: pxa2xx: Move is_lpss_ssp() tests to caller
Date: Thu, 18 Dec 2014 15:04:20 +0200
Message-ID: <1418907863-11116-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1418907863-11116-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418907863-11116-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Move is_lpss_ssp() tests from functions to caller. Although this aims to
improve readability it also saves a few code bytes on x86.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e6741ad79b9d..3e4ab91df649 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -251,9 +251,6 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	unsigned offset = 0x400;
 	u32 value, orig;
 
-	if (!is_lpss_ssp(drv_data))
-		return;
-
 	/*
 	 * Perform auto-detection of the LPSS SSP private registers. They
 	 * can be either at 1k or 2k offset from the base address.
@@ -302,9 +299,6 @@ static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 {
 	u32 value;
 
-	if (!is_lpss_ssp(drv_data))
-		return;
-
 	value = __lpss_ssp_read_priv(drv_data, SPI_CS_CONTROL);
 	if (enable)
 		value &= ~SPI_CS_CONTROL_CS_HIGH;
@@ -332,7 +326,8 @@ static void cs_assert(struct driver_data *drv_data)
 		return;
 	}
 
-	lpss_ssp_cs_control(drv_data, true);
+	if (is_lpss_ssp(drv_data))
+		lpss_ssp_cs_control(drv_data, true);
 }
 
 static void cs_deassert(struct driver_data *drv_data)
@@ -352,7 +347,8 @@ static void cs_deassert(struct driver_data *drv_data)
 		return;
 	}
 
-	lpss_ssp_cs_control(drv_data, false);
+	if (is_lpss_ssp(drv_data))
+		lpss_ssp_cs_control(drv_data, false);
 }
 
 int pxa2xx_spi_flush(struct driver_data *drv_data)
@@ -1415,7 +1411,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (!is_quark_x1000_ssp(drv_data))
 		write_SSPSP(0, drv_data->ioaddr);
 
-	lpss_ssp_setup(drv_data);
+	if (is_lpss_ssp(drv_data))
+		lpss_ssp_setup(drv_data);
 
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
