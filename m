From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] davinci: spi: modify platform data
	for updated SPI driver
Date: Mon, 14 Jun 2010 10:55:01 -0500
Message-ID: <1276530901-4413-4-git-send-email-bniebuhr@efjohnson.com>
References: <1276530901-4413-1-git-send-email-bniebuhr@efjohnson.com>
	<1276530901-4413-2-git-send-email-bniebuhr@efjohnson.com>
	<1276530901-4413-3-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1276530901-4413-3-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |   10 ++++++++++
 arch/arm/mach-davinci/board-dm355-leopard.c |   10 ++++++++++
 arch/arm/mach-davinci/board-dm365-evm.c     |   10 ++++++++++
 arch/arm/mach-davinci/dm355.c               |    6 ------
 arch/arm/mach-davinci/dm365.c               |    6 ------
 5 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index a319101..2f4e2fd 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -32,6 +32,7 @@
 #include <mach/nand.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
+#include <mach/spi.h>
 
 /* NOTE:  this is geared for the standard config, with a socketed
  * 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors.  If you
@@ -300,10 +301,19 @@ static struct spi_eeprom at25640a = {
 	.flags		= EE_ADDR2,
 };
 
+static struct davinci_spi_config at25640a_spi_cfg = {
+	.parity_enable	= 0,
+	.intr_level	= 0,
+	.io_type	= SPI_IO_TYPE_DMA,
+	.wdelay		= 0,
+	.timer_disable	= 1,
+};
+
 static struct spi_board_info dm355_evm_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640a,
+		.controller_data = &at25640a_spi_cfg,
 		.max_speed_hz	= 10 * 1000 * 1000,	/* at 3v3 */
 		.bus_num	= 0,
 		.chip_select	= 0,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index f1d8132..04cd36d 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -29,6 +29,7 @@
 #include <mach/nand.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
+#include <mach/spi.h>
 
 /* NOTE:  this is geared for the standard config, with a socketed
  * 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors.  If you
@@ -222,10 +223,19 @@ static struct spi_eeprom at25640a = {
 	.flags		= EE_ADDR2,
 };
 
+struct davinci_spi_config at25640a_spi_cfg = {
+	.parity_enable	= 0,
+	.intr_level	= 0,
+	.io_type	= SPI_IO_TYPE_DMA,
+	.wdelay		= 0,
+	.timer_disable	= 1,
+};
+
 static struct spi_board_info dm355_leopard_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640a,
+		.controller_data = &at25640a_spi_cfg,
 		.max_speed_hz	= 10 * 1000 * 1000,	/* at 3v3 */
 		.bus_num	= 0,
 		.chip_select	= 0,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index fdb073e..a3621fa 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -39,6 +39,7 @@
 #include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/keyscan.h>
+#include <mach/spi.h>
 
 #include <media/tvp514x.h>
 
@@ -579,10 +580,19 @@ static struct spi_eeprom at25640 = {
 	.flags		= EE_ADDR2,
 };
 
+static struct davinci_spi_config at25640_spi_cfg = {
+	.parity_enable	= 0,
+	.intr_level	= 0,
+	.io_type	= SPI_IO_TYPE_DMA,
+	.wdelay		= 0,
+	.timer_disable	= 1,
+};
+
 static struct spi_board_info dm365_evm_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640,
+		.controller_data = &at25640_spi_cfg,
 		.max_speed_hz	= 10 * 1000 * 1000,
 		.bus_num	= 0,
 		.chip_select	= 0,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 3834781..34bb038 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -412,12 +412,6 @@ static struct resource dm355_spi0_resources[] = {
 static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
-	.clk_internal	= 1,
-	.cs_hold	= 1,
-	.intr_level	= 0,
-	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
-	.c2tdelay	= 0,
-	.t2cdelay	= 0,
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index a146849..0bd9f93 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -625,12 +625,6 @@ static u64 dm365_spi0_dma_mask = DMA_BIT_MASK(32);
 static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
-	.clk_internal	= 1,
-	.cs_hold	= 1,
-	.intr_level	= 0,
-	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
-	.c2tdelay	= 0,
-	.t2cdelay	= 0,
 };
 
 static struct resource dm365_spi0_resources[] = {
-- 
1.6.3.3


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
