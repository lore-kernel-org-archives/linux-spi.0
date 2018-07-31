From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 3/3] mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123
Date: Tue, 31 Jul 2018 16:38:55 +0200
Message-ID: <20180731143855.7131-4-alexandre.belloni@bootlin.com>
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

Ocelot PCB123 has a SPI NOR connected on its SPI bus.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
index 4ccd65379059..2266027759f9 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -26,6 +26,16 @@
 	status = "okay";
 };
 
+&spi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "macronix,mx25l25635f", "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
 &mdio0 {
 	status = "okay";
 };
-- 
2.18.0
