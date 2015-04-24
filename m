From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/4] devicetree: add binding documentation for the AR7100 SPI controller
Date: Fri, 24 Apr 2015 16:19:21 +0200
Message-ID: <1429885164-28501-2-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Mark Brown <broonie@kernel.org>, Alban Bedel <albeu@free.fr>,
	Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 .../devicetree/bindings/spi/spi-ath79.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-ath79.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-ath79.txt b/Documentation/devicetree/bindings/spi/spi-ath79.txt
new file mode 100644
index 0000000..f1ad9c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-ath79.txt
@@ -0,0 +1,24 @@
+Binding for Qualcomm Atheros AR7xxx/AR9xxx SPI controller
+
+Required properties:
+- compatible: has to be "qca,<soc-type>-spi", "qca,ar7100-spi" as fallback.
+- reg: Base address and size of the controllers memory area
+- clocks: phandle to the AHB clock.
+- clock-names: has to be "ahb".
+- #address-cells: <1>, as required by generic SPI binding.
+- #size-cells: <0>, also as required by generic SPI binding.
+
+Child nodes as per the generic SPI binding.
+
+Example:
+
+	spi@1F000000 {
+		compatible = "qca,ar9132-spi", "qca,ar7100-spi";
+		reg = <0x1F000000 0x10>;
+
+		clocks = <&pll 2>;
+		clock-names = "ahb";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.0.0
