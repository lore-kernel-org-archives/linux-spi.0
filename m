From: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: 0002-Spi-spi-gpio-fixed-spaces-coding-style-issue.patch
Date: Sun, 4 Jan 2015 01:27:40 +0530
Message-ID: <20150103195740.GB20435@suse.suse>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XF85m9dhOBO43t/C"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--XF85m9dhOBO43t/C
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-Spi-spi-gpio-fixed-spaces-coding-style-issue.patch"

>From 00454f12a304489125bbdfbc2f50de3c2b9d49d3 Mon Sep 17 00:00:00 2001
From: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 4 Jan 2015 00:24:38 +0530
Subject: [PATCH 2/2] Spi: spi-gpio: fixed spaces coding style issue

Fixed a coding style issue.

Signed-off-by: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index aee4e75..702b0b8 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -92,7 +92,7 @@ struct spi_gpio {
 
 /*----------------------------------------------------------------------*/
 
-static inline struct spi_gpio * __pure
+static inline struct spi_gpio *__pure
 spi_to_spi_gpio(const struct spi_device *spi)
 {
 	const struct spi_bitbang	*bang;
@@ -103,7 +103,7 @@ spi_to_spi_gpio(const struct spi_device *spi)
 	return spi_gpio;
 }
 
-static inline struct spi_gpio_platform_data * __pure
+static inline struct spi_gpio_platform_data *__pure
 spi_to_pdata(const struct spi_device *spi)
 {
 	return &spi_to_spi_gpio(spi)->pdata;
-- 
1.8.1.4


--XF85m9dhOBO43t/C--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
