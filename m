From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] spi: sirf: Use SIMPLE_DEV_PM_OPS macro
Date: Wed, 26 Feb 2014 10:32:48 +0900
Message-ID: <003a01cf3292$a85069d0$f8f13d70$%han@samsung.com>
References: <003801cf3292$0b03b4c0$210b1e40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Barry Song' <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	'Qipan Li' <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	'Zhiwu Song' <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <003801cf3292$0b03b4c0$210b1e40$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-sirf.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 5210b94..dc962a1 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -718,9 +718,8 @@ static int spi_sirfsoc_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops spi_sirfsoc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(spi_sirfsoc_suspend, spi_sirfsoc_resume)
-};
+static SIMPLE_DEV_PM_OPS(spi_sirfsoc_pm_ops, spi_sirfsoc_suspend,
+			 spi_sirfsoc_resume);
 
 static const struct of_device_id spi_sirfsoc_of_match[] = {
 	{ .compatible = "sirf,prima2-spi", },
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
