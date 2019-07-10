From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg" to the spi tree
Date: Wed, 10 Jul 2019 16:34:53 +0100 (BST)
Message-ID: <20190710153453.F057BD02D84@fitzroy.sirena.org.uk>
References: <20190709192631.16394-1-robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709192631.16394-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 43167bb1f6bb7efa73adc40d2dd700bb6546cc2c Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Jul 2019 13:26:31 -0600
Subject: [PATCH] spi: dt-bindings: spi-controller: remove unnecessary
 'maxItems: 1' from reg

Mixing array constraints like 'maxItems' and string or integer value
constraints like 'minimum' don't make sense. Also, with only value
constraints, it is implied we have a single value. So lets remove
'maxItems: 1'.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20190709192631.16394-1-robh@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 876c0623f322..a02e2fe2bfb2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -73,7 +73,6 @@ patternProperties:
           Compatible of the SPI device.
 
       reg:
-        maxItems: 1
         minimum: 0
         maximum: 256
         description:
-- 
2.20.1
