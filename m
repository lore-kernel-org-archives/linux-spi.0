From: Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 3/8] dt-bindings: spi: stm32: fix example with st,spi-midi-ns property
Date: Fri, 23 Jun 2017 14:55:45 +0200
Message-ID: <1498222550-19092-4-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch aligns example with the optional property description.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 415378b..25d2ed6 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -55,6 +55,6 @@ Example:
 			compatible = "spidev";
 			reg = <0>;
 			spi-max-frequency = <4000000>;
-			st,spi-midi = <4000>;
+			st,spi-midi-ns = <4000>;
 		};
 	};
-- 
1.9.1
