From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: modify davinci platform data for updated driver
Date: Fri, 12 Mar 2010 08:20:59 -0600
Message-ID: <1268403659-20348-3-git-send-email-bniebuhr@efjohnson.com>
References: <1268403659-20348-1-git-send-email-bniebuhr@efjohnson.com>
	<1268403659-20348-2-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1268403659-20348-2-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

These changes update the davinci platform data to match the modifications
that were done to the davinci spi controller driver.  The driver update
allowed per-device transfer settings, which are provided by this patch.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |   10 ++++++++++
 arch/arm/mach-davinci/board-dm355-leopard.c |   10 ++++++++++
 arch/arm/mach-davinci/board-dm365-evm.c     |   10 ++++++++++
 arch/arm/mach-davinci/board-dm646x-evm.c    |   12 ++++++++++++
 arch/arm/mach-davinci/dm355.c               |    7 -------
 arch/arm/mach-davinci/dm365.c               |    7 -------
 arch/arm/mach-davinci/dm646x.c              |    7 -------
 7 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index a0724fa..b1a21a4 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -40,6 +40,7 @@
 #include <mach/serial.h>
 #include <mach/nand.h>
 #include <mach/mmc.h>
+#include <mach/spi.h>
 
 #define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x01e10000
 #define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
@@ -445,10 +446,19 @@ static struct spi_eeprom at25640a = {
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
 		.max_speed_hz	= 30 * 1000 * 1000,	/* at 3v3 */
 		.bus_num	= 0,
 		.chip_select	= 0,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 84ad5d1..d87ff0b 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -36,6 +36,7 @@
 #include <mach/serial.h>
 #include <mach/nand.h>
 #include <mach/mmc.h>
+#include <mach/spi.h>
 
 #define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x01e10000
 #define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
@@ -232,10 +233,19 @@ static struct spi_eeprom at25640a = {
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
index ab3b0e2..8559c84 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -44,6 +44,7 @@
 #include <mach/nand.h>
 #include <mach/keyscan.h>
 #include <mach/gpio.h>
+#include <mach/spi.h>
 #include <linux/videodev2.h>
 #include <media/tvp514x.h>
 #include <media/tvp7002.h>
@@ -832,10 +833,19 @@ static struct spi_eeprom at25640 = {
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
 		.max_speed_hz	= 20 * 1000 * 1000,	/* at 3v3 */
 		.bus_num	= 0,
 		.chip_select	= 0,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 94271a6..5430b00 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -58,6 +58,7 @@
 #include <mach/nand.h>
 #include <mach/mmc.h>
 #include <mach/emac.h>
+#include <mach/spi.h>
 
 #include <mach/clock.h>
 #include "clock.h"
@@ -911,10 +912,21 @@ static struct spi_eeprom at25640a = {
 	.flags		= EE_ADDR2,
 };
 
+static struct davinci_spi_config at25640a_spi_cfg = {
+	.parity_enable	= 0,
+	.intr_level	= 0,
+	.io_type	= SPI_IO_TYPE_DMA,
+	.wdelay		= 0,
+	.timer_disable	= 0,
+	.c2t_delay	= 8,
+	.t2c_delay	= 8,
+};
+
 static struct spi_board_info dm646x_evm_spi_info[] __initconst = {
 	{
 		.modalias	= "at25",
 		.platform_data	= &at25640a,
+		.controller_data = &at25640a_spi_cfg,
 		.max_speed_hz	= 10 * 1000 * 1000,	/* at 3v3 */
 		.bus_num	= 0,
 		.chip_select	= 0,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 6925242..90d1fda 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -418,13 +418,6 @@ static struct resource dm355_spi0_resources[] = {
 static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
-	.clk_internal	= 1,
-	.cs_hold	= 1,
-	.intr_level	= 0,
-	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
-	.use_dma	= 1,	/* when 1, value in poll_mode is ignored */
-	.c2tdelay	= 0,
-	.t2cdelay	= 0,
 };
 
 static struct platform_device dm355_spi0_device = {
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index ed6c9c7..600dab5 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -621,13 +621,6 @@ static u64 dm365_spi0_dma_mask = DMA_BIT_MASK(32);
 static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
-	.clk_internal	= 1,
-	.cs_hold	= 1,
-	.intr_level	= 0,
-	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
-	.use_dma	= 1,	/* when 1, value in poll_mode is ignored */
-	.c2tdelay	= 0,
-	.t2cdelay	= 0,
 };
 
 static struct resource dm365_spi0_resources[] = {
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index efb4863..f9b49cb 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -387,13 +387,6 @@ static u64 dm646x_spi0_dma_mask = DMA_BIT_MASK(32);
 static struct davinci_spi_platform_data dm646x_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
-	.clk_internal	= 1,
-	.cs_hold	= 1,
-	.intr_level	= 0,
-	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
-	.use_dma	= 1,	/* when 1, value in poll_mode is ignored */
-	.c2tdelay	= 8,
-	.t2cdelay	= 8,
 };
 
 static struct resource dm646x_spi0_resources[] = {
-- 
1.6.3.3
