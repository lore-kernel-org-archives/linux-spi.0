From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Add spi multi-function pin api for
	w90p910
Date: Wed, 22 Jul 2009 18:29:37 +0800
Message-ID: <4A66EA11.2000803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell-sourceforge <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-spi <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	linux-arm-kernel <linux-arm
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

Add spi multi-function pin api for w90p910 spi driver.

Signed-off-by: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 arch/arm/mach-w90x900/mfp-w90p910.c |   38 +++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/mfp-w90p910.c b/arch/arm/mach-w90x900/mfp-w90p910.c
index 8aec34b..e68dbcf 100644
--- a/arch/arm/mach-w90x900/mfp-w90p910.c
+++ b/arch/arm/mach-w90x900/mfp-w90p910.c
@@ -34,6 +34,12 @@
 #define GPSELEI0	(0x01 << 26)
 #define GPSELEI1	(0x01 << 27)
 
+#define GPIOG0TO1	(0x03 << 14)
+#define GPIOG2TO3	(0x03 << 16)
+#define ENSPI		(0x0a << 14)
+#define ENI2C0		(0x01 << 14)
+#define ENI2C1		(0x01 << 16)
+
 static DECLARE_MUTEX(mfp_sem);
 
 void mfp_set_groupf(struct device *dev)
@@ -118,3 +124,35 @@ void mfp_set_groupi(struct device *dev)
 }
 EXPORT_SYMBOL(mfp_set_groupi);
 
+void mfp_set_groupg(struct device *dev)
+{
+	unsigned long mfpen;
+	const char *dev_id;
+
+	BUG_ON(!dev);
+
+	down(&mfp_sem);
+
+	dev_id = dev_name(dev);
+
+	mfpen = __raw_readl(REG_MFSEL);
+
+	if (strcmp(dev_id, "w90p910-spi") == 0) {
+		mfpen &= ~(GPIOG0TO1 | GPIOG2TO3);
+		mfpen |= ENSPI;/*enable spi*/
+	} else if (strcmp(dev_id, "w90p910-i2c0") == 0) {
+		mfpen &= ~(GPIOG0TO1);
+		mfpen |= ENI2C0;/*enable i2c0*/
+	} else if (strcmp(dev_id, "w90p910-i2c1") == 0) {
+		mfpen &= ~(GPIOG2TO3);
+		mfpen &= ~ENI2C1;/*enable i2c1*/
+	} else {
+		mfpen &= ~(GPIOG0TO1 | GPIOG2TO3);/*GPIOG[3:0]*/
+	}
+
+	__raw_writel(mfpen, REG_MFSEL);
+
+	up(&mfp_sem);
+}
+EXPORT_SYMBOL(mfp_set_groupg);
+
-- 
1.5.6.3

------------------------------------------------------------------------------
