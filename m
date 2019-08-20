From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix the number of CS lines documented as an example" to the spi tree
Date: Tue, 20 Aug 2019 13:54:59 +0100 (BST)
Message-ID: <20190820125459.867A42742ABD@ypsilon.sirena.org.uk>
References: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
Cc: broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Fix the number of CS lines documented as an example

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

>From 7f01494fd85f3ac40635bc2a7bf005b607084c96 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 20 Aug 2019 17:20:00 +0530
Subject: [PATCH] spi: Fix the number of CS lines documented as an example

The number of CS lines is mentioned as 2 in the spi-controller binding
but however in the example, 4 cs-gpios are used. Hence fix that to
mention 4.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20190820115000.32041-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index a02e2fe2bfb2..732339275848 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -31,7 +31,7 @@ properties:
       If that property is used, the number of chip selects will be
       increased automatically with max(cs-gpios, hardware chip selects).
 
-      So if, for example, the controller has 2 CS lines, and the
+      So if, for example, the controller has 4 CS lines, and the
       cs-gpios looks like this
         cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
 
-- 
2.20.1
