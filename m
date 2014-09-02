From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/4] spi: oc-tiny: remove unnecessary #ifdef CONFIG_OF
Date: Tue, 02 Sep 2014 12:25:23 +0900
Message-ID: <002c01cfc65d$87e0d270$97a27750$%han@samsung.com>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Thomas Chou' <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>,
	'Axel Lin' <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
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
 drivers/spi/spi-oc-tiny.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 8998d11c7238..baac441fa6f6 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -338,13 +338,11 @@ static int tiny_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id tiny_spi_match[] = {
 	{ .compatible = "opencores,tiny-spi-rtlsvn2", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tiny_spi_match);
-#endif /* CONFIG_OF */
 
 static struct platform_driver tiny_spi_driver = {
 	.probe = tiny_spi_probe,
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
