From: Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [Patch v4 3/3] dt-bindings: Enhance binding to extend example for flash entry
Date: Tue, 13 Aug 2019 15:53:11 +0530
Message-ID: <1565691791-26167-3-git-send-email-Ashish.Kumar@nxp.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-next@vger.kernel.org, Ashish Kumar <Ashish.Kumar@nxp.com>
To: linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add example for adding flash entry on various boards' dts
using flash manufacture spansion/cypress.

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
---
v4:
-Add new patch to series.
v3:
Not present
v2:
Not present
 
 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 2c2a3e9..7ba0472 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -35,7 +35,11 @@ qspi0: quadspi@40044000 {
 	clock-names = "qspi_en", "qspi";
 
 	flash0: s25fl128s@0 {
-		....
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s", "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
 	};
 };
 
-- 
2.7.4
