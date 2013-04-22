From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 20/23] ARM: u300: add SPI PL022 to the device tree
Date: Mon, 22 Apr 2013 12:01:17 +0200
Message-ID: <1366624877-6932-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This registers the PL022 PrimeCell from the U300 device
tree. We make a new copy of the platform data for the
device tree boot path, as the old platform data is in an
older file which will be going away.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/ste-u300.dts |  7 +++++++
 arch/arm/mach-u300/core.c      | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index cdffeb9..979d96c 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -214,5 +214,12 @@
 			cd-inverted;
 			vmmc-supply = <&ab3100_ldo_g_reg>;
 		};
+
+		spi: ssp@c0006000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0xc0006000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <23>;
+		};
 	};
 };
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 98d4dbe..9467ffe 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -19,6 +19,7 @@
 #include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/amba/serial.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
@@ -703,6 +704,22 @@ MACHINE_END
 
 #ifdef CONFIG_OF
 
+static struct pl022_ssp_controller spi_plat_data = {
+	/* If you have several SPI buses this varies, we have only bus 0 */
+	.bus_id = 0,
+	/*
+	 * On the APP CPU GPIO 4, 5 and 6 are connected as generic
+	 * chip selects for SPI. (Same on U330, U335 and U365.)
+	 * TODO: make sure the GPIO driver can select these properly
+	 * and do padmuxing accordingly too.
+	 */
+	.num_chipselect = 3,
+	.enable_dma = 1,
+	.dma_filter = coh901318_filter_id,
+	.dma_rx_param = (void *) U300_DMA_SPI_RX,
+	.dma_tx_param = (void *) U300_DMA_SPI_TX,
+};
+
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,pinctrl-u300", U300_SYSCON_BASE,
@@ -719,6 +736,8 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
 		"uart1", &uart1_plat_data),
+	OF_DEV_AUXDATA("arm,primecell", U300_SPI_BASE,
+		"pl022", &spi_plat_data),
 	OF_DEV_AUXDATA("st,ddci2c", U300_I2C0_BASE,
 		"stu300.0", NULL),
 	OF_DEV_AUXDATA("st,ddci2c", U300_I2C1_BASE,
-- 
1.7.11.3
