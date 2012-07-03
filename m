From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH v2 06/12] ARM: kirkwood: use devicetree for SPI on dreamplug
Date: Tue,  3 Jul 2012 16:22:39 +0200
Message-ID: <1341325365-21393-7-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1341325365-21393-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>

Use the device tree for the SPI driver and partition layout.

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   29 +++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dreamplug.c |   41 ------------------------------
 2 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index a5376b8..d74d1ae 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -20,5 +20,34 @@
 			clock-frequency = <200000000>;
 			status = "ok";
 		};
+
+		spi@10600 {
+			status = "okay";
+
+			m25p40@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l1606e";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				mode = <0>;
+
+				partition@0 {
+					reg = <0x0 0x80000>;
+					label = "u-boot";
+				};
+
+				partition@100000 {
+					reg = <0x100000 0x10000>;
+					label = "u-boot env";
+				};
+
+				partition@180000 {
+					reg = <0x180000 0x10000>;
+					label = "dtb";
+				};
+			};
+		};
 	};
+
 };
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 55e357a..eb0e4d5 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/of.h>
@@ -36,42 +35,6 @@
 #include "common.h"
 #include "mpp.h"
 
-struct mtd_partition dreamplug_partitions[] = {
-	{
-		.name	= "u-boot",
-		.size	= SZ_512K,
-		.offset = 0,
-	},
-	{
-		.name	= "u-boot env",
-		.size	= SZ_64K,
-		.offset = SZ_512K + SZ_512K,
-	},
-	{
-		.name	= "dtb",
-		.size	= SZ_64K,
-		.offset = SZ_512K + SZ_512K + SZ_512K,
-	},
-};
-
-static const struct flash_platform_data dreamplug_spi_slave_data = {
-	.type		= "mx25l1606e",
-	.name		= "spi_flash",
-	.parts		= dreamplug_partitions,
-	.nr_parts	= ARRAY_SIZE(dreamplug_partitions),
-};
-
-static struct spi_board_info __initdata dreamplug_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &dreamplug_spi_slave_data,
-		.irq		= -1,
-		.max_speed_hz	= 50000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
-
 static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
@@ -137,10 +100,6 @@ void __init dreamplug_init(void)
 	 */
 	kirkwood_mpp_conf(dreamplug_mpp_config);
 
-	spi_register_board_info(dreamplug_spi_slave_info,
-				ARRAY_SIZE(dreamplug_spi_slave_info));
-	kirkwood_spi_init();
-
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
