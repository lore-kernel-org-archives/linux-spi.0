From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] spi/bcm63xx-hsspi: allow providing clock rate through a second clock
Date: Wed, 22 Feb 2017 14:19:38 +0100
Message-ID: <20170222131940.31085-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of requiring the hsspi clock to have a rate, allow using a second
clock for providing the Hz rate, which is probably more correct anyway.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 55789f7cda92..79096d17ebde 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -351,8 +351,16 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	rate = clk_get_rate(clk);
-	if (!rate)
-		return -EINVAL;
+	if (!rate) {
+		struct clk *pll_clk = devm_clk_get(dev, "pll");
+
+		if (IS_ERR(pll_clk))
+			return PTR_ERR(pll_clk);
+
+		rate = clk_get_rate(pll_clk);
+		if (!rate)
+			return -EINVAL;
+	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
