From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Document Octal mode as valid SPI bus width" to the spi tree
Date: Fri,  3 Jan 2020 01:05:52 +0000 (GMT)
Message-ID: <applied-20200102102118.23318-1-vigneshr@ti.com>
References: <20200102102118.23318-1-vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102102118.23318-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Document Octal mode as valid SPI bus width

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 09b6636cea4f8e419d7cca4155e8695e462535a6 Mon Sep 17 00:00:00 2001
From: Vignesh Raghavendra <vigneshr@ti.com>
Date: Thu, 2 Jan 2020 15:51:18 +0530
Subject: [PATCH] spi: Document Octal mode as valid SPI bus width

SPI core supports Octal SPI controllers which have 8 IO lines.
Therefore document 8 as a valid option for spi-tx{rx}-bus-width

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20200102102118.23318-1-vigneshr@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 732339275848..1e0ca6ccf64b 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -111,7 +111,7 @@ patternProperties:
       spi-rx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MISO.
@@ -123,7 +123,7 @@ patternProperties:
       spi-tx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MOSI.
-- 
2.20.1
