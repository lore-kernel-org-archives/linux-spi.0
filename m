From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] [RESEND] spi: qup: Depend on ARCH_QCOM
Date: Mon, 07 Apr 2014 16:15:45 +0200
Message-ID: <1396880145.12738.6.camel@x220>
References: <1396784733.30640.25.camel@x220>
	 <20140407130853.GG14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>,
	David Brown <davidb@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140407130853.GG14763@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Commit 8fc1b0f87d9f ("ARM: qcom: Split Qualcomm support into legacy and
multiplatform") removed Kconfig symbol ARCH_MSM_DT. But that commit
left one (optional) dependency on ARCH_MSM_DT untouched.

Three Kconfig symbols used to depend on ARCH_MSM_DT: ARCH_MSM8X60,
ARCH_MSM8960, and ARCH_MSM8974. These three symbols now depend on
ARCH_QCOM. So it appears this driver needs to depend on ARCH_QCOM too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Resending, because Mark suggested to include the Qualcomm people (who
know what's going on with these symbols).

Still untested!

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
