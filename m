From: Zhiqiang Hou <Zhiqiang.Hou-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 0/2] arm64: dts: Add ls1088a DSPI device tree nodes
Date: Wed, 1 Nov 2017 11:40:13 +0800
Message-ID: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hou Zhiqiang <Zhiqiang.Hou-3arQi8VN3Tc@public.gmane.org>
To: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <prabhakar.kushwaha-3arQi8VN3Tc@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou-3arQi8VN3Tc@public.gmane.org>

LS1088A reuse LS2085A DSPI driver, this patchset just adds device tree
nodes and adds compatible entry to documentation.

Hou Zhiqiang (2):
  arm64: dts: ls1088a: add DT nodes for DSPI support
  Documentation: fsl: dspi: Add a compatible string for ls1088a DSPI

 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  | 28 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 13 ++++++++++
 3 files changed, 42 insertions(+)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
