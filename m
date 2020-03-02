From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 1/6] doc: spi-fsl-dspi: Add specific compatibles for all Layerscape SoCs
Date: Mon,  2 Mar 2020 02:19:53 +0200
Message-ID: <20200302001958.11105-2-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Make the second compatible string optional for LS1012A, LS1088A and
LS2080A. Old versions of the spi-fsl-dspi.c driver still need to probe
on the old, generic compatible string for these controllers (such as
"fsl,ls1021a-v1.0-dspi") which provides less functionality.

Document the device tree bindings for LS1043A and LS1046A, whose
bindings are already in use in fsl-ls1043a.dtsi and fsl-ls1046a.dtsi.

Introduce new compatible strings for LS1028A and LX2160A. There will be
no second compatible string for these.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../devicetree/bindings/spi/spi-fsl-dspi.txt    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 162e024b95a0..99b94cfe1623 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -1,12 +1,17 @@
 ARM Freescale DSPI controller
 
 Required properties:
-- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi",
-		"fsl,ls2085a-dspi"
-		or
-		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
-		"fsl,ls1012a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
-		"fsl,ls1088a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
+- compatible : must be one of:
+	"fsl,vf610-dspi",
+	"fsl,ls1021a-v1.0-dspi",
+	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1028a-dspi",
+	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
+	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
+	"fsl,ls2085a-dspi",
+	"fsl,lx2160a-dspi",
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain SPI controller interrupt
 - clocks: from common clock binding: handle to dspi clock.
-- 
2.17.1
