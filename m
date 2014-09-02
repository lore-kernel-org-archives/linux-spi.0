From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/4] spi: altera: remove unnecessary #ifdef CONFIG_OF
Date: Tue, 02 Sep 2014 12:22:51 +0900
Message-ID: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Thomas Chou' <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>,
	'Axel Lin' <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove unnecessary #ifdef CONFIG_OF, because this is already
handled by the of_match_ptr macro.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-altera.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 5b5709a5c957..588d428f47c8 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -268,14 +268,12 @@ static int altera_spi_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id altera_spi_match[] = {
 	{ .compatible = "ALTR,spi-1.0", },
 	{ .compatible = "altr,spi-1.0", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, altera_spi_match);
-#endif /* CONFIG_OF */
 
 static struct platform_driver altera_spi_driver = {
 	.probe = altera_spi_probe,
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
