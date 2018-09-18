From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi working in slave mode
Date: Tue, 18 Sep 2018 11:34:35 +0200
Message-ID: <20180918093437.26799-2-lukma@denx.de>
References: <20180918093437.26799-1-lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This commit provides the description of new property: "fsl,spi-slave-mode"
which enables support for DSPI driver working in slave mode.

As the new compatible shall be used with SPI bus equipped with master
device a new "spidev" based node has been introduced to avoid confusion.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index 18eeafe359d8..b30af19a2bc5 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -26,6 +26,7 @@ Optional SPI properties for slave nodes:
 - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
   signal and deactivating chip select, at the end of a transfer.
 - bus-num : the slave chip chipselect signal number.
+- fsl,spi-slave-mode: if present, controller runs in slave mode.
 
 Example:
 
@@ -56,6 +57,13 @@ dspi0@4002c000 {
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <50>;
 	};
+
+	spidev3@1 {
+		compatible = "fsl,vf610-dspi";
+		spi-max-frequency = <30000000>;
+		reg = <1>;
+		fsl,spi-slave-mode;
+	};
 };
 
 
-- 
2.11.0
