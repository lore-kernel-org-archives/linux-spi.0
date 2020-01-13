From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V2 1/7] dt-bindings: fsl-imx-sdma: Add i.MX8MM/i.MX8MN/i.MX8MP compatible string
Date: Mon, 13 Jan 2020 13:33:16 +0800
Message-ID: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
Cc: Linux-imx@nxp.com
To: robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add imx8mm/imx8mn/imx8mp sdma support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 9d8bbac..c9e9740 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -10,6 +10,9 @@ Required properties:
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
       "fsl,imx8mq-sdma"
+      "fsl,imx8mm-sdma"
+      "fsl,imx8mn-sdma"
+      "fsl,imx8mp-sdma"
   The -to variants should be preferred since they allow to determine the
   correct ROM script addresses needed for the driver to work without additional
   firmware.
-- 
2.7.4
