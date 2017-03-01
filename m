From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 1/3] spi/bcm63xx-hsspi: allow providing clock rate through a second clock
Date: Wed,  1 Mar 2017 10:08:12 +0100
Message-ID: <20170301090814.7097-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The HSSPI block actually has two clock inputs, one for gating the block,
and one for the PLL rate. To allow these to be represented as two clocks,
add support for retrieving the rate from a separate "pll" clock, if the
"hsspi" clock does not provide one.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes v1 -> v2:
 * Rewrote commmit message after confirmation from Florian
 * Added Florian's Ack

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
