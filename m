From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: spi: spi-rockchip: add description for rk3308" to the spi tree
Date: Thu, 05 Mar 2020 14:36:42 +0000
Message-ID: <applied-20200304184203.9548-2-jbx6244@gmail.com>
References: <20200304184203.9548-2-jbx6244@gmail.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        Rob Herring <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200304184203.9548-2-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: spi: spi-rockchip: add description for rk3308

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

>From db7dd939acf369b3e9bfac2ae75307639785de9e Mon Sep 17 00:00:00 2001
From: Johan Jonker <jbx6244@gmail.com>
Date: Wed, 4 Mar 2020 19:42:02 +0100
Subject: [PATCH] dt-bindings: spi: spi-rockchip: add description for rk3308

The description below is already in use for rk3308.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3308-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3308 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200304184203.9548-2-jbx6244@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index bd1450c1274c..456896e2d514 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -29,6 +29,7 @@ properties:
             - rockchip,px30-spi
             - rockchip,rk3188-spi
             - rockchip,rk3288-spi
+            - rockchip,rk3308-spi
             - rockchip,rk3368-spi
             - rockchip,rk3399-spi
           - const: rockchip,rk3066-spi
-- 
2.20.1
