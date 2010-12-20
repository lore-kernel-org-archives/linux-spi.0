From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: [PATCHv3 4/4] mc13xxx: Add i2c and spi drivers to Kconfig and Makefile
Date: Mon, 20 Dec 2010 14:50:55 +1100
Message-ID: <1292817055-17715-5-git-send-email-marc@cpdesign.com.au>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1292817055-17715-1-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
---
 drivers/mfd/Kconfig  |   22 ++++++++++++++--------
 drivers/mfd/Makefile |    2 ++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3a1493b..6980cf2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -424,20 +424,26 @@ config MFD_PCF50633
 	  facilities, and registers devices for the various functions
 	  so that function-specific drivers can bind to them.
 
-config MFD_MC13783
-	tristate
-
 config MFD_MC13XXX
-	tristate "Support Freescale MC13783 and MC13892"
-	depends on SPI_MASTER
+	tristate "Support Freescale MC13XXX"
+	depends on SPI_MASTER || I2C
 	select MFD_CORE
-	select MFD_MC13783
 	help
 	  Support for the Freescale (Atlas) PMIC and audio CODECs
 	  MC13783 and MC13892.
-	  This driver provides common support for accessing  the device,
+	  This driver provides common support for accessing the device,
 	  additional drivers must be enabled in order to use the
-	  functionality of the device.
+	  functionality of these devices.
+
+config MFD_MC13XXX_SPI
+	tristate "Support for MC13XXX via SPI"
+	depends on SPI_MASTER
+	select MFD_MC13XXX
+
+config MFD_MC13XXX_I2C
+	tristate "Support for MC13XXX via I2C"
+	depends on I2C
+	select MFD_MC13XXX
 
 config PCF50633_ADC
 	tristate "Support for NXP PCF50633 ADC"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f54b365..b7d774f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -42,6 +42,8 @@ obj-$(CONFIG_TWL4030_CODEC)	+= twl4030-codec.o
 obj-$(CONFIG_TWL6030_PWM)	+= twl6030-pwm.o
 
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
+obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
+obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
-- 
1.7.1


------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
