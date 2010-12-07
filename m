From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 07/12] davinci: add tnetv107x evm regulators
Date: Tue,  7 Dec 2010 09:51:57 -0500
Message-ID: <1291733522-3626-8-git-send-email-cyril@ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org,
	Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	rpurdie@rpsys
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1291733522-3626-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds regulator and spi board info definitions for the tps6524x
power management IC found on tnetv107x evm boards.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   85 +++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 1a656e8..ca23516 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -26,6 +26,9 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -254,7 +257,89 @@ static struct tnetv107x_device_info evm_device_info __initconst = {
 	.ssp_config		= &ssp_config,
 };
 
+static struct regulator_consumer_supply usb_consumers[] = {
+	REGULATOR_SUPPLY("vbus", "musb_hdrc.1"),
+};
+
+static struct regulator_consumer_supply lcd_consumers[] = {
+	REGULATOR_SUPPLY("vlcd", "tps6116x"),
+};
+
+static struct regulator_init_data regulators[] = {
+	{
+		.constraints		= {
+			.name		= "DCDC1",
+			.min_uV		= 1000000,
+			.max_uV		= 1000000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "DCDC2",
+			.min_uV		= 1800000,
+			.max_uV		= 1800000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "DCDC3",
+			.min_uV		= 3300000,
+			.max_uV		= 3300000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "LDO1",
+			.min_uV		= 4800000,
+			.max_uV		= 4800000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "LDO1",
+			.min_uV		= 3300000,
+			.max_uV		= 3300000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.num_consumer_supplies	= ARRAY_SIZE(usb_consumers),
+		.consumer_supplies	= usb_consumers,
+		.constraints		= {
+			.name		= "USB",
+			.min_uA		= 200000,
+			.max_uA		= 1000000,
+			.valid_ops_mask	= REGULATOR_CHANGE_CURRENT |
+					  REGULATOR_CHANGE_STATUS,
+		},
+	},
+	{
+		.num_consumer_supplies	= ARRAY_SIZE(lcd_consumers),
+		.consumer_supplies	= lcd_consumers,
+		.constraints		= {
+			.name		= "LCD",
+			.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		},
+	},
+};
+
 static struct spi_board_info spi_info[] __initconst = {
+	{
+		.modalias	= "tps6524x",
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_0,
+		.platform_data	= regulators,
+	},
 };
 
 static __init void tnetv107x_evm_board_init(void)
-- 
1.7.1


------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
