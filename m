From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 19/20] DT bindings: spi: document tx/rx clock delay properties
Date: Thu, 4 Apr 2019 17:14:18 -0700
Message-ID: <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Tegra SPI controller has TX and RX trimmers to tuning the delay of
SPI master clock with respect to the data.

TX and RX tap values are based on the platform validation across the
PVT and the trimmer values vary based on the trace lengths to the
corresponding SPI devices.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/spi/nvidia,tegra114-spi.txt  | 20 ++++++++++++++++++++
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
2.7.4
