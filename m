From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/4] clk: sunxi: Add support for PLL6 on the A31
Date: Thu, 16 Jan 2014 18:11:22 +0100
Message-ID: <1389892285-11745-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBF5H4CLAKGQE7J7ZUVI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1389892285-11745-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

The A31 has a slightly different PLL6 clock. Add support for this new clock in
our driver.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 45 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index c2cb762..954845c 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -11,6 +11,7 @@ Required properties:
 	"allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
 	"allwinner,sun4i-pll5-clk" - for the PLL5 clock
 	"allwinner,sun4i-pll6-clk" - for the PLL6 clock
+	"allwinner,sun6i-a31-pll6-clk" - for the PLL6 clock on A31
 	"allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
 	"allwinner,sun4i-axi-clk" - for the AXI clock
 	"allwinner,sun4i-axi-gates-clk" - for the AXI gates
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 659e4ea..990ad5d 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -249,7 +249,38 @@ static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
 	*n = DIV_ROUND_UP(div, (*k+1));
 }
 
+/**
+ * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6
+ * PLL6 rate is calculated as follows
+ * rate = parent_rate * n * (k + 1) / 2
+ * parent_rate is always 24Mhz
+ */
+
+static void sun6i_a31_get_pll6_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div;
+
+	/*
+	 * We always have 24MHz / 2, so we can just say that our
+	 * parent clock is 12MHz.
+	 */
+	parent_rate = parent_rate / 2;
+
+	/* Normalize value to a parent_rate multiple (24M / 2) */
+	div = *freq / parent_rate;
+	*freq = parent_rate * div;
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	*k = div / 32;
+	if (*k > 3)
+		*k = 3;
 
+	*n = DIV_ROUND_UP(div, (*k+1));
+}
 
 /**
  * sun4i_get_apb1_factors() - calculates m, p factors for APB1
@@ -416,6 +447,13 @@ static struct clk_factors_config sun4i_pll5_config = {
 	.kwidth = 2,
 };
 
+static struct clk_factors_config sun6i_a31_pll6_config = {
+	.nshift	= 8,
+	.nwidth = 5,
+	.kshift = 4,
+	.kwidth = 2,
+};
+
 static struct clk_factors_config sun4i_apb1_config = {
 	.mshift = 0,
 	.mwidth = 5,
@@ -457,6 +495,12 @@ static const struct factors_data sun4i_pll5_data __initconst = {
 	.getter = sun4i_get_pll5_factors,
 };
 
+static const struct factors_data sun6i_a31_pll6_data __initconst = {
+	.enable = 31,
+	.table = &sun6i_a31_pll6_config,
+	.getter = sun6i_a31_get_pll6_factors,
+};
+
 static const struct factors_data sun4i_apb1_data __initconst = {
 	.table = &sun4i_apb1_config,
 	.getter = sun4i_get_apb1_factors,
@@ -972,6 +1016,7 @@ free_clkdata:
 static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-pll1-clk", .data = &sun4i_pll1_data,},
 	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
+	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun4i-apb1-clk", .data = &sun4i_apb1_data,},
 	{.compatible = "allwinner,sun4i-mod0-clk", .data = &sun4i_mod0_data,},
 	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
-- 
1.8.4.2
