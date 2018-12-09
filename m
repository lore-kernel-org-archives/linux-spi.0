From: cezary.gapinski@gmail.com
Subject: [PATCH 5/5] spi: stm32: add description about STM32F4 bindings
Date: Sun,  9 Dec 2018 14:53:56 +0100
Message-ID: <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add description that STM32F4 can be used in compatible property.
Master Inter-Data Idleness optional property cannot be used in STM32F4.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 1b3fa2c1..d82755c 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,9 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32h7-spi".
+- compatible: Should be one of:
+  "st,stm32h7-spi"
+  "st,stm32f4-spi"
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -30,8 +32,9 @@ Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
 
 Optional properties:
-- st,spi-midi-ns: (Master Inter-Data Idleness) minimum time delay in
-		  nanoseconds inserted between two consecutive data frames.
+- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
+		  delay in nanoseconds inserted between two consecutive data
+		  frames.
 
 
 Example:
-- 
2.7.4
