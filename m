From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] spi: qup: Fix build error due to a typo
Date: Sun, 23 Feb 2014 13:27:16 +0800
Message-ID: <1393133236.32087.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix below build error when CONFIG_PM_RUNTIME=y:

C [M]  drivers/spi/spi-qup.o
drivers/spi/spi-qup.c: In function 'spi_qup_pm_suspend_runtime':
drivers/spi/spi-qup.c:712:12: error: 'QUP_CLOCK_AUTO_GATE' undeclared (first use in this function)
drivers/spi/spi-qup.c:712:12: note: each undeclared identifier is reported only once for each function it appears in
drivers/spi/spi-qup.c: In function 'spi_qup_pm_resume_runtime':
drivers/spi/spi-qup.c:725:13: error: 'QUP_CLOCK_AUTO_GATE' undeclared (first use in this function)
make[2]: *** [drivers/spi/spi-qup.o] Error 1
make[1]: *** [drivers/spi] Error 2
make: *** [drivers] Error 2

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-qup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index dec339d..886edb4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -709,7 +709,7 @@ static int spi_qup_pm_suspend_runtime(struct device *device)
 
 	/* Enable clocks auto gaiting */
 	config = readl(controller->base + QUP_CONFIG);
-	config |= QUP_CLOCK_AUTO_GATE;
+	config |= QUP_CONFIG_CLOCK_AUTO_GATE;
 	writel_relaxed(config, controller->base + QUP_CONFIG);
 	return 0;
 }
@@ -722,7 +722,7 @@ static int spi_qup_pm_resume_runtime(struct device *device)
 
 	/* Disable clocks auto gaiting */
 	config = readl_relaxed(controller->base + QUP_CONFIG);
-	config &= ~QUP_CLOCK_AUTO_GATE;
+	config &= ~QUP_CONFIG_CLOCK_AUTO_GATE;
 	writel_relaxed(config, controller->base + QUP_CONFIG);
 	return 0;
 }
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
