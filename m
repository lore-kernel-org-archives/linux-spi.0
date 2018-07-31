From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 2/3] mips: dts: mscc: Add spi on Ocelot
Date: Tue, 31 Jul 2018 16:38:54 +0200
Message-ID: <20180731143855.7131-3-alexandre.belloni@bootlin.com>
References: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
Cc: James Hogan <jhogan@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Paul Burton <paul.burton@mips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for the SPI controller

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index 4f33dbc67348..f7616a476247 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -91,6 +91,17 @@
 			status = "disabled";
 		};
 
+		spi: spi@101000 {
+			compatible = "mscc,ocelot-spi", "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x101000 0x100>, <0x3c 0x18>;
+			interrupts = <9>;
+			clocks = <&ahb_clk>;
+
+			status = "disabled";
+		};
+
 		switch@1010000 {
 			compatible = "mscc,vsc7514-switch";
 			reg = <0x1010000 0x10000>,
-- 
2.18.0
