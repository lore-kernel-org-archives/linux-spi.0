From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Remove redundant call to lpss_ssp_setup() in probe
Date: Fri, 20 Nov 2015 13:55:21 +0200
Message-ID: <1448020521-94914-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 8b136baa5892 ("spi: pxa2xx: Detect number of enabled Intel LPSS SPI
chip select signals") added a block where lpss_ssp_setup() gets called
again for Intel LPSS SPI host controllers before checking number of chip
selects from the capabilities register.

There is no point in calling the function twice in probe so remove the
first call.

Reported-by: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b25dc71b0ea9..ab9914ad8365 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1567,9 +1567,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (!is_quark_x1000_ssp(drv_data))
 		pxa2xx_spi_write(drv_data, SSPSP, 0);
 
-	if (is_lpss_ssp(drv_data))
-		lpss_ssp_setup(drv_data);
-
 	if (is_lpss_ssp(drv_data)) {
 		lpss_ssp_setup(drv_data);
 		config = lpss_get_config(drv_data);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
