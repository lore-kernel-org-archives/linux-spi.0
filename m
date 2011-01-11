From: <yong.shen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] ARM i.MX SPI driver changes for i.MX53 support
Date: Tue, 11 Jan 2011 17:21:53 +0800
Message-ID: <1294737713-24015-2-git-send-email-yong.shen@freescale.com>
References: <1294737713-24015-1-git-send-email-yong.shen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yong Shen <yong.shen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <yong.shen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1294737713-24015-1-git-send-email-yong.shen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Yong Shen <yong.shen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

1. Change the Kconfig to include i.MX53
2. add devtype entry for i.MX53

Signed-off-by: Yong Shen <yong.shen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/Kconfig   |    4 ++--
 drivers/spi/spi_imx.c |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 78f9fd0..04965e2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -153,10 +153,10 @@ config SPI_IMX_VER_0_4
 	def_bool y if ARCH_MX31
 
 config SPI_IMX_VER_0_7
-	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51
+	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51 || ARCH_MX53
 
 config SPI_IMX_VER_2_3
-	def_bool y if ARCH_MX51
+	def_bool y if ARCH_MX51 || ARCH_MX53
 
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 55a38e2..9b8a733 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -747,6 +747,12 @@ static struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx51-ecspi",
 		.driver_data = SPI_IMX_VER_2_3,
 	}, {
+		.name = "imx53-cspi",
+		.driver_data = SPI_IMX_VER_0_7,
+	}, {
+		.name = "imx53-ecspi",
+		.driver_data = SPI_IMX_VER_2_3,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.7.1



------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
