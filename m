From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rockchip: add compatible string for rv1108 spi" to the spi tree
Date: Mon, 14 Aug 2017 17:45:18 +0100
Message-ID: <E1dhIUQ-0005k7-1c@finisterre>
References: <1501663563-12482-1-git-send-email-andy.yan@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501663563-12482-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: rockchip: add compatible string for rv1108 spi

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

>From 6b860e69e873be247d19174ab6b24d0b5741bf8c Mon Sep 17 00:00:00 2001
From: Andy Yan <andy.yan@rock-chips.com>
Date: Mon, 14 Aug 2017 16:34:22 +0800
Subject: [PATCH] spi: rockchip: add compatible string for rv1108 spi

The spi on rv1108 is the same as other rockchip based
socs, add compatible string for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
 drivers/spi/spi-rockchip.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 83da4931d832..6e3ffacbba32 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -6,6 +6,7 @@ and display controllers using the SPI communication interface.
 Required Properties:
 
 - compatible: should be one of the following.
+    "rockchip,rv1108-spi" for rv1108 SoCs.
     "rockchip,rk3036-spi" for rk3036 SoCS.
     "rockchip,rk3066-spi" for rk3066 SoCs.
     "rockchip,rk3188-spi" for rk3188 SoCs.
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 34f6440a5255..474033e2149e 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -914,6 +914,7 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
+	{ .compatible = "rockchip,rv1108-spi", },
 	{ .compatible = "rockchip,rk3036-spi", },
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
-- 
2.13.2
