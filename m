From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
Date: Sun, 10 Jun 2012 12:31:57 +0200
Message-ID: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	Michael Walle <micheal-QKn5cuLxLXY@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>

Populate the devices with auxdata to set the device names which are used by
clkdev to lookup the clocks.

Signed-off-by: Michael Walle <micheal-QKn5cuLxLXY@public.gmane.org>
Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
 arch/arm/boot/dts/kirkwood.dtsi   |    9 +++++++++
 arch/arm/mach-kirkwood/board-dt.c |    8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 8eab7c4..7d282ab 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -42,6 +42,15 @@
 			interrupts = <53>;
 		};
 
+		spi@10600 {
+			compatible = "marvell,orion-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			reg = <0x10600 0x28>;
+			status = "disabled";
+		};
+
 		nand@3000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index fa51586..0942139 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 	{ }
 };
 
+struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
+	{},
+};
+
 static void __init kirkwood_dt_init(void)
 {
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
@@ -69,7 +74,8 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("raidsonic,ib-nas62x0"))
 		ib62x0_init();
 
-	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
+	of_platform_populate(NULL, kirkwood_dt_match_table,
+			     kirkwood_auxdata_lookup, NULL);
 }
 
 static const char *kirkwood_dt_board_compat[] = {
-- 
1.7.10
