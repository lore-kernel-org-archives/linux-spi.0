From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fix typo in SPI_STM32 help text" to the spi tree
Date: Mon,  7 Jan 2019 18:59:12 +0000 (GMT)
Message-ID: <20190107185912.DFAAB1127491@debutante.sirena.org.uk>
References: <1545688840-23992-5-git-send-email-cezary.gapinski@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org
To: Cezary Gapinski <cezary.gapinski@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545688840-23992-5-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fix typo in SPI_STM32 help text

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bb35c9f91a8dec397e76f332dd93637e396e9054 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:30 +0100
Subject: [PATCH] spi: fix typo in SPI_STM32 help text

Fix typo from STMicroelectonics to STMicroelectronics.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ba68fe1913cb..dc67eda1788a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -676,7 +676,7 @@ config SPI_STM32
 	tristate "STMicroelectronics STM32 SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
-	  SPI driver for STMicroelectonics STM32 SoCs.
+	  SPI driver for STMicroelectronics STM32 SoCs.
 
 	  STM32 SPI controller supports DMA and PIO modes. When DMA
 	  is not available, the driver automatically falls back to
-- 
2.20.1
