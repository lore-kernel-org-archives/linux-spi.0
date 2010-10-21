From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 03/12] davinci: add ssp config for tnetv107x evm board
Date: Thu, 21 Oct 2010 17:01:04 -0400
Message-ID: <1287694873-12904-4-git-send-email-cyril@ti.com>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gra
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287694873-12904-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds SSP configuration and pin muxing info for tnetv107x
evm boards.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 5afa8fc..401ad26 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -33,6 +33,7 @@
 #include <mach/edma.h>
 #include <mach/mux.h>
 #include <mach/cp_intc.h>
+#include <mach/ti_ssp.h>
 #include <mach/tnetv107x.h>
 
 #define EVM_MMC_WP_GPIO		21
@@ -99,6 +100,12 @@ static const short uart1_pins[] __initdata = {
 	-1
 };
 
+static const short ssp_pins[] __initdata = {
+	TNETV107X_SSP0_0, TNETV107X_SSP0_1, TNETV107X_SSP0_2,
+	TNETV107X_SSP1_0, TNETV107X_SSP1_1, TNETV107X_SSP1_2,
+	TNETV107X_SSP1_3, -1
+};
+
 static struct mtd_partition nand_partitions[] = {
 	/* bootloader (U-Boot, etc) in first 12 sectors */
 	{
@@ -196,17 +203,25 @@ static struct matrix_keypad_platform_data keypad_config = {
 	.no_autorepeat	= 0,
 };
 
+static struct ti_ssp_data ssp_config = {
+	.out_clock	= 250 * 1000,
+	.dev_data	= {
+	},
+};
+
 static struct tnetv107x_device_info evm_device_info __initconst = {
 	.serial_config		= &serial_config,
 	.mmc_config[1]		= &mmc_config,	/* controller 1 */
 	.nand_config[0]		= &nand_config,	/* chip select 0 */
 	.keypad_config		= &keypad_config,
+	.ssp_config		= &ssp_config,
 };
 
 static __init void tnetv107x_evm_board_init(void)
 {
 	davinci_cfg_reg_list(sdio1_pins);
 	davinci_cfg_reg_list(uart1_pins);
+	davinci_cfg_reg_list(ssp_pins);
 
 	tnetv107x_devices_init(&evm_device_info);
 }
-- 
1.7.0.4


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
