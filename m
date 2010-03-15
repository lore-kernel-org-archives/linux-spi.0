From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 2/3] ep93xx: added chip revision reading
	function
Date: Mon, 15 Mar 2010 18:26:11 +0200
Message-ID: <3d93e748eb068963a9378b454ba9cd117cbbc737.1268669236.git.mika.westerberg@iki.fi>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<774b9c08b6e9484a2ca5084b8b6019aa18dddd99.1268669236.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <774b9c08b6e9484a2ca5084b8b6019aa18dddd99.1268669236.git.mika.westerberg-X3B1VOXEql0@public.gmane.org>
In-Reply-To: <cover.1268669236.git.mika.westerberg-X3B1VOXEql0@public.gmane.org>
References: <cover.1268669236.git.mika.westerberg-X3B1VOXEql0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Added a new function: ep93xx_chip_revision() which reads chip revision from the
sysconfig register.

Signed-off-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
---
 arch/arm/mach-ep93xx/core.c                  |   26 ++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/platform.h |   11 +++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..2e496c9 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -64,6 +64,32 @@ void __init ep93xx_map_io(void)
 	iotable_init(ep93xx_io_desc, ARRAY_SIZE(ep93xx_io_desc));
 }
 
+/**
+ * ep93xx_chip_revision() - returns EP93xx chip revision
+ *
+ * Returns EP93xx chip revision number read from sysconfig register. Possible
+ * values can be one of the following:
+ *
+ * %EP93XX_CHIP_REV_A
+ * %EP93XX_CHIP_REV_B
+ * %EP93XX_CHIP_REV_C
+ * %EP93XX_CHIP_REV_D0
+ * %EP93XX_CHIP_REV_D1
+ * %EP93XX_CHIP_REV_E0
+ * %EP93XX_CHIP_REV_E1
+ * %EP93XX_CHIP_REV_E2
+ *
+ * and in future maybe something else. See also <mach/platform.h>.
+ */
+u8 ep93xx_chip_revision(void)
+{
+	u32 v;
+
+	v = __raw_readl(EP93XX_SYSCON_SYSCFG);
+	v &= EP93XX_SYSCON_SYSCFG_REV_MASK;
+	v >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
+	return (u8)v;
+}
 
 /*************************************************************************
  * Timer handling for EP93xx
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index c6dc14d..8603837 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -33,6 +33,17 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 	ep93xx_devcfg_set_clear(0x00, bits);
 }
 
+#define EP93XX_CHIP_REV_A      0
+#define EP93XX_CHIP_REV_B      1
+#define EP93XX_CHIP_REV_C      2
+#define EP93XX_CHIP_REV_D0     3
+#define EP93XX_CHIP_REV_D1     4
+#define EP93XX_CHIP_REV_E0     5
+#define EP93XX_CHIP_REV_E1     6
+#define EP93XX_CHIP_REV_E2     7
+
+u8 ep93xx_chip_revision(void);
+
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 			 struct i2c_board_info *devices, int num);
-- 
1.5.6.5


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
