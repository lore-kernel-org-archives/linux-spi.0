From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/4] spi: xtensa-xtfpga: remove unnecessary #ifdef CONFIG_OF
Date: Tue, 02 Sep 2014 12:26:02 +0900
Message-ID: <002d01cfc65d$9fa78d90$def6a8b0$%han@samsung.com>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Max Filippov' <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002a01cfc65d$2dc86640$895932c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove unnecessary #ifdef CONFIG_OF, because this is already
handled by the of_match_ptr macro.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-xtensa-xtfpga.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 41e158187f9d..553b5e189273 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -146,13 +146,11 @@ static int xtfpga_spi_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:" XTFPGA_SPI_NAME);
 
-#ifdef CONFIG_OF
 static const struct of_device_id xtfpga_spi_of_match[] = {
 	{ .compatible = "cdns,xtfpga-spi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, xtfpga_spi_of_match);
-#endif
 
 static struct platform_driver xtfpga_spi_driver = {
 	.probe = xtfpga_spi_probe,
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
