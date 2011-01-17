From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v8 06/11] davinci: add ssp config for tnetv107x evm board
Date: Mon, 17 Jan 2011 14:15:20 -0500
Message-ID: <1295291725-32509-7-git-send-email-cyril@ti.com>
References: <1295291725-32509-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: c-park-l0cyMroinI0@public.gmane.org, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1295291725-32509-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
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
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index a6db854..ef526b1 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -99,6 +99,12 @@ static const short uart1_pins[] __initdata = {
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
@@ -196,17 +202,25 @@ static struct matrix_keypad_platform_data keypad_config = {
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
1.7.1


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
