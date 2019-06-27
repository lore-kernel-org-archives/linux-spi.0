From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH] dt-bindings: spi: stm32-qspi: add dma properties
Date: Thu, 27 Jun 2019 09:43:58 +0200
Message-ID: <1561621439-7305-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
To: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds description of dma properties (optional).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
index adeeb63..bfc038b 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
@@ -19,8 +19,11 @@ Required properties:
 - reg: chip-Select number (QSPI controller may connect 2 flashes)
 - spi-max-frequency: max frequency of spi bus
 
-Optional property:
+Optional properties:
 - spi-rx-bus-width: see ./spi-bus.txt for the description
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names: DMA request names should include "tx" and "rx" if present.
 
 Example:
 
-- 
2.7.4
