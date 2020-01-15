From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 3/4] dt-binding: spi: add NPCM PSPI reset binding
Date: Wed, 15 Jan 2020 18:23:00 +0200
Message-ID: <20200115162301.235926-4-tmaimon77@gmail.com>
References: <20200115162301.235926-1-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200115162301.235926-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add NPCM Peripheral SPI reset binding documentation,
Removing unnecessary aliases use.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt    | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
index 1fd9a4406a1d..b98203ca656d 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -12,6 +12,7 @@ Required properties:
  - clock-names: Should be "clk_apb5".
  - pinctrl-names : a pinctrl state named "default" must be defined.
  - pinctrl-0 : phandle referencing pin configuration of the device.
+ - resets : phandle to the reset control for this device.
  - cs-gpios: Specifies the gpio pins to be used for chipselects.
             See: Documentation/devicetree/bindings/spi/spi-bus.txt
 
@@ -19,16 +20,6 @@ Optional properties:
 - clock-frequency : Input clock frequency to the PSPI block in Hz.
 		    Default is 25000000 Hz.
 
-Aliases:
-- All the SPI controller nodes should be represented in the aliases node using
-  the following format 'spi{n}' withe the correct numbered in "aliases" node.
-
-Example:
-
-aliases {
-	spi0 = &spi0;
-};
-
 spi0: spi@f0200000 {
 	compatible = "nuvoton,npcm750-pspi";
 	reg = <0xf0200000 0x1000>;
@@ -39,5 +30,6 @@ spi0: spi@f0200000 {
 	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clk NPCM7XX_CLK_APB5>;
 	clock-names = "clk_apb5";
+	resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>
 	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
 };
-- 
2.22.0
