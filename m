From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] spi: Kconfig: Enable McSPI driver for K3 platforms
Date: Wed, 7 Nov 2018 16:09:26 +0530
Message-ID: <20181107103926.32550-3-vigneshr@ti.com>
References: <20181107103926.32550-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mark Rutland <mark.rutland@arm.com>, <linux-spi@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107103926.32550-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Enable McSPI driver to be built for K3 platforms, to support McSPI on
AM654 SoC of K3 family.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7d3a5c94727e..51e620264b62 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -435,7 +435,7 @@ config SPI_OMAP_UWIRE
 
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select SG_SPLIT
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
-- 
2.19.1
