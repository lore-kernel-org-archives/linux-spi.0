From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: [PATCH] spi: qup: Depend on ARCH_QCOM
Date: Sun, 06 Apr 2014 13:45:33 +0200
Message-ID: <1396784733.30640.25.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 8fc1b0f87d9f ("ARM: qcom: Split Qualcomm support into legacy and
multiplatform") removed Kconfig symbol ARCH_MSM_DT. But that commit
left one (optional) dependency on ARCH_MSM_DT untouched.

Three Kconfig symbols used to depend on ARCH_MSM_DT: ARCH_MSM8X60,
ARCH_MSM8960, and ARCH_MSM8974. These three symbols now depend on
ARCH_QCOM. So it appears this driver needs to depend on ARCH_QCOM too.

Signed-off-by: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
---
Untested!

Note that this is basically guesswork: looking at commit 8fc1b0f87d9f it
appears to make sense to pick ARCH_QCOM here.

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index efe1960af2b3..60f2b41c7310 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -383,7 +383,7 @@ config SPI_RSPI
 
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
-	depends on ARCH_MSM_DT || (ARM && COMPILE_TEST)
+	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	help
 	  Qualcomm Universal Peripheral (QUP) core is an AHB slave that
 	  provides a common data path (an output FIFO and an input FIFO)
-- 
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
