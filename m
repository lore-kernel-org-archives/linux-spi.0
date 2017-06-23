From: Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/8] dt-bindings: spi: stm32: use SoC specific compatible
Date: Fri, 23 Jun 2017 14:55:43 +0200
Message-ID: <1498222550-19092-2-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This patch replaces st,stm32-spi compatible with st,stm32h7-spi SoC
specific compatible and updates the example accondingly.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 3958bf6..415378b 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,7 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32-spi".
+- compatible: Must be "st,stm32h7-spi".
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -38,7 +38,7 @@ Example:
 	spi2: spi@40003800 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "st,stm32-spi";
+		compatible = "st,stm32h7-spi";
 		reg = <0x40003800 0x400>;
 		interrupts = <36>;
 		clocks = <&rcc SPI2_CK>;
-- 
1.9.1
