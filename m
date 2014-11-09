From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH 3/3] ARM: dts: meson: add node for SPIFC
Date: Sun,  9 Nov 2014 10:25:13 +0100
Message-ID: <1415525113-25598-4-git-send-email-b.galvani@gmail.com>
References: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
Cc: linux-spi@vger.kernel.org, Carlo Caione <carlo@caione.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>,
	Beniamino Galvani <b.galvani@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This adds a node for the SPI Flash Controller to the Amlogic Meson
DTS.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/boot/dts/meson.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index e6539ea..d28b16e 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -106,5 +106,14 @@
 			clocks = <&clk81>;
 			status = "disabled";
 		};
+
+		spifc: spi@c1108c80 {
+			compatible = "amlogic,meson6-spifc";
+			reg = <0xc1108c80 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
 	};
 }; /* end of / */
-- 
1.9.1
