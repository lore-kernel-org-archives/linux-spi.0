From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] docs: dt: fix several broken doc references
Date: Sun, 23 Feb 2020 09:59:53 +0100
Message-ID: <0e530494349b37eb2eab4a8eccf56626e0b18e6d.1582448388.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Piotr Sroka <piotrs@cadence.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?=
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kerne
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There are several DT doc references that require manual fixes.
I found 3 cases fixed on this patch:

	- directory named "binding/" instead of "bindings/";
	- .txt to .yaml renames;
	- file renames (still on txt format);

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/mtd/cadence-nand-controller.txt       | 2 +-
 .../devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt      | 2 +-
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt      | 2 +-
 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt  | 2 +-
 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml       | 2 +-
 MAINTAINERS                                                   | 4 ++--
 .../devicetree/bindings/net/wireless/siliabs,wfx.txt          | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
index f3893c4d3c6a..d2eada5044b2 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
@@ -27,7 +27,7 @@ Required properties of NAND chips:
   - reg: shall contain the native Chip Select ids from 0 to max supported by
     the cadence nand flash controller
 
-See Documentation/devicetree/bindings/mtd/nand.txt for more details on
+See Documentation/devicetree/bindings/mtd/nand-controller.yaml for more details on
 generic bindings.
 
 Example:
diff --git a/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt b/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
index 48a7f916c5e4..88b57b0ca1f4 100644
--- a/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
+++ b/Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt
@@ -45,7 +45,7 @@ Optional properties:
   switch queue
 
 - resets: a single phandle and reset identifier pair. See
-  Documentation/devicetree/binding/reset/reset.txt for details.
+  Documentation/devicetree/bindings/reset/reset.txt for details.
 
 - reset-names: If the "reset" property is specified, this property should have
   the value "switch" to denote the switch reset line.
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index 944743dd9212..c42b91e525fa 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -36,7 +36,7 @@ SAI subnodes required properties:
   - clock-names: Must contain "sai_ck".
 	Must also contain "MCLK", if SAI shares a master clock,
 	with a SAI set as MCLK clock provider.
-  - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
+  - dmas: see Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
   - dma-names: identifier string for each DMA request line
 	"tx": if sai sub-block is configured as playback DAI
 	"rx": if sai sub-block is configured as capture DAI
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
index 33826f2459fa..ca9101777c44 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
@@ -10,7 +10,7 @@ Required properties:
   - clock-names: must contain "kclk"
   - interrupts: cpu DAI interrupt line
   - dmas: DMA specifiers for audio data DMA and iec control flow DMA
-    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt
+    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
   - dma-names: two dmas have to be defined, "rx" and "rx-ctrl"
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index f0d979664f07..e49ecbf715ba 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -49,7 +49,7 @@ properties:
   dmas:
     description: |
       DMA specifiers for tx and rx dma. DMA fifo mode must be used. See
-      the STM32 DMA bindings Documentation/devicetree/bindings/dma/stm32-dma.txt.
+      the STM32 DMA bindings Documentation/devicetree/bindings/dma/st,stm32-dma.yaml.
     items:
       - description: rx DMA channel
       - description: tx DMA channel
diff --git a/MAINTAINERS b/MAINTAINERS
index d81701ea3336..6b30a58bd77b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4480,7 +4480,7 @@ L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/platform/sunxi/sun6i-csi/
-F:	Documentation/devicetree/bindings/media/sun6i-csi.txt
+F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
 
 CW1200 WLAN driver
 M:	Solomon Peachy <pizza@shaftnet.org>
@@ -15955,7 +15955,7 @@ F:	drivers/*/stm32-*timer*
 F:	drivers/pwm/pwm-stm32*
 F:	include/linux/*/stm32-*tim*
 F:	Documentation/ABI/testing/*timer-stm32
-F:	Documentation/devicetree/bindings/*/stm32-*timer*
+F:	Documentation/devicetree/bindings/*/*stm32-*timer*
 F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
 
 STMMAC ETHERNET DRIVER
diff --git a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
index ffec79c14786..17db67559f5e 100644
--- a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
+++ b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
@@ -94,5 +94,5 @@ Some properties are recognized either by SPI and SDIO versions:
    Must contains 64 hexadecimal digits. Not supported in current version.
 
 WFx driver also supports `mac-address` and `local-mac-address` as described in
-Documentation/devicetree/binding/net/ethernet.txt
+Documentation/devicetree/bindings/net/ethernet.txt
 
-- 
2.24.1
