From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 1/5] MIPS: BCM63XX: expose the HSSPI clock
Date: Sat, 30 Nov 2013 12:42:02 +0100
Message-ID: <1385811726-6746-2-git-send-email-jogo@openwrt.org>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385811726-6746-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 arch/mips/bcm63xx/clk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 43da4ae..37a621a 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -226,6 +226,28 @@ static struct clk clk_spi = {
 };
 
 /*
+ * HSSPI clock
+ */
+static void hsspi_set(struct clk *clk, int enable)
+{
+	u32 mask;
+
+	if (BCMCPU_IS_6328())
+		mask = CKCTL_6328_HSSPI_EN;
+	else if (BCMCPU_IS_6362())
+		mask = CKCTL_6362_HSSPI_EN;
+	else
+		return;
+
+	bcm_hwclock_set(mask, enable);
+}
+
+static struct clk clk_hsspi = {
+	.set	= hsspi_set,
+};
+
+
+/*
  * XTM clock
  */
 static void xtm_set(struct clk *clk, int enable)
@@ -346,6 +368,8 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_usbd;
 	if (!strcmp(id, "spi"))
 		return &clk_spi;
+	if (!strcmp(id, "hsspi"))
+		return &clk_hsspi;
 	if (!strcmp(id, "xtm"))
 		return &clk_xtm;
 	if (!strcmp(id, "periph"))
-- 
1.8.4.rc3
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
