From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V3 4/4] dt-bindings: arm: imx: Add the i.MX8MP EVK board
Date: Tue, 11 Feb 2020 20:48:27 +0800
Message-ID: <1581425307-18567-4-git-send-email-Anson.Huang@nxp.com>
References: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
Cc: Linux-imx@nxp.com
To: robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, andrew.smirnov@gmail.com,
        manivannan.sadhasivam@linaro.org, marcel.ziswiler@toradex.com,
        rjones@gateworks.com, sebastien.szymanski@armadeus.com,
        aisheng.dong@nxp.com, gary.bisson@boundarydevices.com,
        angus@akkea.ca, pramod.kumar_1@nxp.com, rabeeh@solid-run.com,
        cosmin.stoica@nxp.com, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add board binding for i.MX8MP EVK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No change.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c5b0270..b8c8c72b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -324,6 +324,12 @@ properties:
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
           - const: fsl,imx8mn
 
+      - description: i.MX8MP based Boards
+        items:
+          - enum:
+              - fsl,imx8mp-evk            # i.MX8MP EVK Board
+          - const: fsl,imx8mp
+
       - description: i.MX8MQ based Boards
         items:
           - enum:
-- 
2.7.4
