From: cezary.gapinski@gmail.com
Subject: [PATCH v2 04/14] spi: fix typo in SPI_STM32 help text
Date: Mon, 24 Dec 2018 23:00:30 +0100
Message-ID: <1545688840-23992-5-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Fix typo from STMicroelectonics to STMicroelectronics.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f89cb1..ceb6b7e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -665,7 +665,7 @@ config SPI_STM32
 	tristate "STMicroelectronics STM32 SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
-	  SPI driver for STMicroelectonics STM32 SoCs.
+	  SPI driver for STMicroelectronics STM32 SoCs.
 
 	  STM32 SPI controller supports DMA and PIO modes. When DMA
 	  is not available, the driver automatically falls back to
-- 
2.7.4
