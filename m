From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm-qspi: Enable the driver on BMIPS_GENERIC" to the spi tree
Date: Wed, 04 Jan 2017 18:37:46 +0000
Message-ID: <E1cOqRW-00028h-2T@debutante>
References: <20161230063001.944-2-jaedon.shin@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20161230063001.944-2-jaedon.shin@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm-qspi: Enable the driver on BMIPS_GENERIC

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 279e4af7b4bebc6a5bf2d0e5b3209f3dcea94a19 Mon Sep 17 00:00:00 2001
From: Jaedon Shin <jaedon.shin@gmail.com>
Date: Fri, 30 Dec 2016 15:30:00 +0900
Subject: [PATCH] spi: bcm-qspi: Enable the driver on BMIPS_GENERIC

The Broadcom BCM7XXX ARM and MIPS based SoCs share a similar hardware
block for SPI.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ec4aa252d6e8..c982a01022ba 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -162,7 +162,8 @@ config SPI_BCM63XX_HSSPI
 
 config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
-	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || \
+			BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
-- 
2.11.0
