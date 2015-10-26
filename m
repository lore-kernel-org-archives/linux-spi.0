From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH v2 5/5] arm64: dts: mt8173: spi bus dts support multiple devices
Date: Mon, 26 Oct 2015 16:09:45 +0800
Message-ID: <1445846985-26229-6-git-send-email-leilk.liu@mediatek.com>
References: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	Leilk Liu <leilk.liu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445846985-26229-1-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch support multiple devices for MT8173 board.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 811cb76..e7a4416 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -393,7 +393,7 @@
 			pinmux = <MT8173_PIN_69_SPI_CK__FUNC_SPI_CK_0_>,
 				<MT8173_PIN_70_SPI_MI__FUNC_SPI_MI_0_>,
 				<MT8173_PIN_71_SPI_MO__FUNC_SPI_MO_0_>,
-				<MT8173_PIN_72_SPI_CS__FUNC_SPI_CS_0_>;
+				<MT8173_PIN_72_SPI_CS__FUNC_GPIO72>;
 		};
 	};
 };
@@ -401,6 +401,7 @@
 &spi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_pins_a>;
+	cs-gpios = <&pio 72 0>;
 	mediatek,pad-select = <0>;
 	status = "okay";
 };
-- 
1.8.1.1.dirty
