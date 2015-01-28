From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Fix unconditional call of lpss_ssp_setup in pxa2xx_spi_resume
Date: Wed, 28 Jan 2015 10:09:42 +0200
Message-ID: <1422432582-12287-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 7566bcc76b15 ("spi: pxa2xx: Move is_lpss_ssp() tests to caller") did
not check LPSS before calling lpss_ssp_setup() in pxa2xx_spi_resume().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6ea22d121a5b..6f72ad01e041 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1488,7 +1488,8 @@ static int pxa2xx_spi_resume(struct device *dev)
 		clk_prepare_enable(ssp->clk);
 
 	/* Restore LPSS private register bits */
-	lpss_ssp_setup(drv_data);
+	if (is_lpss_ssp(drv_data))
+		lpss_ssp_setup(drv_data);
 
 	/* Start the queue running */
 	status = spi_master_resume(drv_data->master);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
