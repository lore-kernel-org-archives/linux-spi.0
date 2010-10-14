From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 07/12] davinci: add tnetv107x evm regulators
Date: Thu, 14 Oct 2010 14:38:50 -0400
Message-ID: <1287081535-2864-8-git-send-email-cyril@ti.com>
References: <1287081535-2864-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org,
        dbrownell@users
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287081535-2864-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
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

This patch adds regulator and spi board info definitions for the tps6524x
power management IC found on tnetv107x evm boards.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   91 +++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 52378bf..2f13544 100644
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
@@ -260,7 +263,95 @@ static struct platform_device spi_master_device = {
 	.dev.platform_data = &spi_master_data,
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
+			.min_uA		= 400000,
+			.max_uA		= 1500000,
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
+			.min_uV		= 5000000,
+			.max_uV		= 5000000,
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
+			.min_uV		= 5000000,
+			.max_uV		= 5000000,
+			.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		},
+	},
+};
+
 static struct spi_board_info spi_info[] __initconst = {
+	{
+		.modalias	= "tps6524x",
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_0,
+		.platform_data	= regulators,
+	},
 };
 
 static __init void tnetv107x_evm_board_init(void)
-- 
1.7.0.4
