From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH v3 4/4] ARM: dts: meson: add node for SPIFC
Date: Sat, 22 Nov 2014 16:21:42 +0100
Message-ID: <1416669702-7841-5-git-send-email-b.galvani@gmail.com>
References: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
Cc: linux-spi@vger.kernel.org, Carlo Caione <carlo@caione.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>,
	Beniamino Galvani <b.galvani@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This adds a node for the SPI Flash Controller to the Amlogic Meson
DTS.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/meson.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index b91e430..e26d37a 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -135,5 +135,14 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
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
