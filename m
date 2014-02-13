From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sun6i: Fix define for SUN6I_TFR_CTL_CS_MASK
Date: Thu, 13 Feb 2014 10:18:15 +0800
Message-ID: <1392257895.3964.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Current code in sun6i_spi_set_cs() actually clears CPHA and CPOL bits which is
obvious wrong. The define for SUN6I_TFR_CTL_CS_MASK is wrong. Fix it.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sun6i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 94d38d0..dacc8d6 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -36,8 +36,8 @@
 #define SUN6I_TFR_CTL_CPHA			BIT(0)
 #define SUN6I_TFR_CTL_CPOL			BIT(1)
 #define SUN6I_TFR_CTL_SPOL			BIT(2)
-#define SUN6I_TFR_CTL_CS_MASK			0x3
-#define SUN6I_TFR_CTL_CS(cs)			(((cs) & SUN6I_TFR_CTL_CS_MASK) << 4)
+#define SUN6I_TFR_CTL_CS_MASK			0x30
+#define SUN6I_TFR_CTL_CS(cs)			(((cs) << 4) & SUN6I_TFR_CTL_CS_MASK)
 #define SUN6I_TFR_CTL_CS_MANUAL			BIT(6)
 #define SUN6I_TFR_CTL_CS_LEVEL			BIT(7)
 #define SUN6I_TFR_CTL_DHB			BIT(8)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
