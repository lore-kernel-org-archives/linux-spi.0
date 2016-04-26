From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Do not detect number of enabled chip selects on Intel SPT
Date: Tue, 26 Apr 2016 10:08:26 +0300
Message-ID: <1461654506-4040-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org#4.4+
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Certain Intel Sunrisepoint PCH variants report zero chip selects in SPI
capabilities register even they have one per port. Detection in
pxa2xx_spi_probe() sets master->num_chipselect to 0 leading to -EINVAL
from spi_register_master() where chip select count is validated.

Fix this by not using SPI capabilities register on Sunrisepoint. They don't
have more than one chip select so use the default value 1 instead of
detection.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.4+
Fixes: 8b136baa5892 ("spi: pxa2xx: Detect number of enabled Intel LPSS
SPI chip select signals")
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0ce82db8e484..66c36b1aab0c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -126,7 +126,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.reg_general = -1,
 		.reg_ssp = 0x20,
 		.reg_cs_ctrl = 0x24,
-		.reg_capabilities = 0xfc,
+		.reg_capabilities = -1,
 		.rx_threshold = 1,
 		.tx_threshold_lo = 32,
 		.tx_threshold_hi = 56,
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
