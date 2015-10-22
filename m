From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/7] spi: pxa2xx: Align a few defines
Date: Thu, 22 Oct 2015 16:44:43 +0300
Message-ID: <1445521485-2029-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add more indentation to define lines for making them aligned with the
longest one. They would look messy after adding more long defines.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 615f6c57a090..672963653d3b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -61,9 +61,9 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 				| QUARK_X1000_SSCR1_TFT		\
 				| SSCR1_SPH | SSCR1_SPO | SSCR1_LBM)
 
-#define GENERAL_REG_RXTO_HOLDOFF_DISABLE BIT(24)
-#define SPI_CS_CONTROL_SW_MODE	BIT(0)
-#define SPI_CS_CONTROL_CS_HIGH	BIT(1)
+#define GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
+#define SPI_CS_CONTROL_SW_MODE			BIT(0)
+#define SPI_CS_CONTROL_CS_HIGH			BIT(1)
 
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
