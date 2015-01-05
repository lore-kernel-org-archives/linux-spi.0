From: nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 3/3] spi:spi-gpio: fixed space coding styple issue
Date: Mon,  5 Jan 2015 17:31:03 +0530
Message-ID: <1420459263-2190-1-git-send-email-nizamhaider786@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Nizam Haider <nizamhaider786-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

fixed a coding style issue

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
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
