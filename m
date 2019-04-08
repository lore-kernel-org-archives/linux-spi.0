From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: document tx/rx clock delay properties" to the spi tree
Date: Mon,  8 Apr 2019 14:31:19 +0700 (+07)
Message-ID: <20190408073119.3BF84441D3B@finisterre.ee.mobilebroadband>
References: <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: document tx/rx clock delay properties

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

>From 7558f978f9b66a2bc284a0e8c0764b88305bc29f Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:18 -0700
Subject: [PATCH] spi: document tx/rx clock delay properties

Tegra SPI controller has TX and RX trimmers to tuning the delay of
SPI master clock with respect to the data.

TX and RX tap values are based on the platform validation across the
PVT and the trimmer values vary based on the trace lengths to the
corresponding SPI devices.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/nvidia,tegra114-spi.txt      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 9ba7c5a273b4..db8e0d71c5bc 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -23,6 +23,18 @@ Required properties:
 Recommended properties:
 - spi-max-frequency: Definition as per
                      Documentation/devicetree/bindings/spi/spi-bus.txt
+Optional properties:
+- nvidia,tx-clk-tap-delay: Delays the clock going out to the external device
+  with this tap value. This property is used to tune the outgoing data from
+  Tegra SPI master with respect to outgoing Tegra SPI master clock.
+  Tap values vary based on the platform design trace lengths from Tegra SPI
+  to corresponding slave devices. Valid tap values are from 0 thru 63.
+- nvidia,rx-clk-tap-delay: Delays the clock coming in from the external device
+  with this tap value. This property is used to adjust the Tegra SPI master
+  clock with respect to the data from the SPI slave device.
+  Tap values vary based on the platform design trace lengths from Tegra SPI
+  to corresponding slave devices. Valid tap values are from 0 thru 63.
+
 Example:
 
 spi@7000d600 {
@@ -38,4 +50,12 @@ spi@7000d600 {
 	reset-names = "spi";
 	dmas = <&apbdma 16>, <&apbdma 16>;
 	dma-names = "rx", "tx";
+	<spi-client>@<bus_num> {
+		...
+		...
+		nvidia,rx-clk-tap-delay = <0>;
+		nvidia,tx-clk-tap-delay = <16>;
+		...
+	};
+
 };
-- 
2.20.1
