From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 2/5] MIPS: BCM63XX: setup the HSSPI clock rate
Date: Sat, 30 Nov 2013 12:42:03 +0100
Message-ID: <1385811726-6746-3-git-send-email-jogo@openwrt.org>
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

Properly set up the HSSPI clock rate depending on the SoC's PLL rate.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 arch/mips/bcm63xx/clk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 37a621a..6375652 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -390,3 +390,21 @@ void clk_put(struct clk *clk)
 }
 
 EXPORT_SYMBOL(clk_put);
+
+#define HSSPI_PLL_HZ_6328	133333333
+#define HSSPI_PLL_HZ_6362	400000000
+
+static int __init bcm63xx_clk_init(void)
+{
+	switch (bcm63xx_get_cpu_id()) {
+	case BCM6328_CPU_ID:
+		clk_hsspi.rate = HSSPI_PLL_HZ_6328;
+		break;
+	case BCM6362_CPU_ID:
+		clk_hsspi.rate = HSSPI_PLL_HZ_6362;
+		break;
+	}
+
+	return 0;
+}
+arch_initcall(bcm63xx_clk_init);
-- 
1.8.4.rc3
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
