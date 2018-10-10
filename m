From: Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 3/7] arm64: dts: rockchip: add rk3399 SPI DMAs
Date: Wed, 10 Oct 2018 11:00:34 +0200
Message-ID: <20181010090038.20834-4-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add spi dma channels as specified by the rk3399 TRM.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index c88e603396f6..c11b5ae6f1ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -653,6 +653,8 @@
 		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 10>, <&dmac_peri 11>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
 		#address-cells = <1>;
@@ -666,6 +668,8 @@
 		clocks = <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 12>, <&dmac_peri 13>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
 		#address-cells = <1>;
@@ -679,6 +683,8 @@
 		clocks = <&cru SCLK_SPI2>, <&cru PCLK_SPI2>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 14>, <&dmac_peri 15>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
 		#address-cells = <1>;
@@ -692,6 +698,8 @@
 		clocks = <&cru SCLK_SPI4>, <&cru PCLK_SPI4>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_peri 18>, <&dmac_peri 19>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi4_clk &spi4_tx &spi4_rx &spi4_cs0>;
 		#address-cells = <1>;
@@ -705,6 +713,8 @@
 		clocks = <&cru SCLK_SPI5>, <&cru PCLK_SPI5>;
 		clock-names = "spiclk", "apb_pclk";
 		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH 0>;
+		dmas = <&dmac_bus 8>, <&dmac_bus 9>;
+		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
-- 
2.19.1
