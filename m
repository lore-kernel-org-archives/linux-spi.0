From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Add spi resource define for w90p910 spi
	driver
Date: Wed, 22 Jul 2009 18:25:41 +0800
Message-ID: <4A66E925.5070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell-sourceforge <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-spi <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>,
	Russel
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Russell,

This is a spi resource define patch for w90p910 spi driver.


Signed-off-by: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-w90x900/mach-w90p910evb.c |   61 +++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/mach-w90p910evb.c b/arch/arm/mach-w90x900/mach-w90p910evb.c
index 3b9fa31..0a3be6e 100644
--- a/arch/arm/mach-w90x900/mach-w90p910evb.c
+++ b/arch/arm/mach-w90x900/mach-w90p910evb.c
@@ -20,7 +20,13 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -35,6 +41,8 @@
 
 #define W90P910_FLASH_BASE	0xA0000000
 #define W90P910_FLASH_SIZE	0x400000
+#define SPIOFFSET		0x200
+#define SPIOREG_SIZE		0x100
 
 static struct mtd_partition w90p910_flash_partitions[] = {
 	{
@@ -250,9 +258,59 @@ static struct platform_device w90p910_device_fmi = {
 	.resource	= w90p910_fmi_resource,
 };
 
+/* spi device */
+
+static struct resource w90p910_spi_resource[] = {
+	[0] = {
+		.start = W90X900_PA_I2C + SPIOFFSET,
+		.end   = W90X900_PA_I2C + SPIOFFSET + SPIOREG_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_SSP,
+		.end   = IRQ_SSP,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device w90p910_device_spi = {
+	.name		= "w90p910-spi",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(w90p910_spi_resource),
+	.resource	= w90p910_spi_resource,
+};
+
 static struct map_desc w90p910_iodesc[] __initdata = {
 };
 
+/* spi device, spi flash info */
+
+static struct mtd_partition w90p910_spi_flash_partitions[] = {
+	{
+		.name = "bootloader(spi)",
+		.size = 0x0100000,
+		.offset = 0,
+	},
+};
+
+static struct flash_platform_data w90p910_spi_flash_data = {
+	.name = "m25p80",
+	.parts =  w90p910_spi_flash_partitions,
+	.nr_parts = ARRAY_SIZE(w90p910_spi_flash_partitions),
+	.type = "w25x16",
+};
+
+static struct spi_board_info w90p910_spi_board_info[] __initdata = {
+	{
+		.modalias = "m25p80",
+		.max_speed_hz = 20000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.platform_data = &w90p910_spi_flash_data,
+		.mode = SPI_MODE_0,
+	},
+};
+
 /*Here should be your evb resourse,such as LCD*/
 
 static struct platform_device *w90p910evb_dev[] __initdata = {
@@ -265,6 +323,7 @@ static struct platform_device *w90p910evb_dev[] __initdata = {
 	&w90x900_device_kpi,
 	&w90x900_device_usbgadget,
 	&w90p910_device_fmi,
+	&w90p910_device_spi,
 };
 
 static void __init w90p910evb_map_io(void)
@@ -276,6 +335,8 @@ static void __init w90p910evb_map_io(void)
 static void __init w90p910evb_init(void)
 {
 	platform_add_devices(w90p910evb_dev, ARRAY_SIZE(w90p910evb_dev));
+	spi_register_board_info(w90p910_spi_board_info,
+					ARRAY_SIZE(w90p910_spi_board_info));
 }
 
 MACHINE_START(W90P910EVB, "W90P910EVB")
-- 
1.5.6.3

------------------------------------------------------------------------------
