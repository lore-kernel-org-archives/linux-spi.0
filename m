From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Date: Thu,  4 Oct 2018 14:18:40 +0530
Message-ID: <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 1 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 901ca346..817175a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -42,6 +42,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <20000000>;
 		reg = <0>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <1>;
 	};
 
 	mt35xu512aba1: flash@1 {
@@ -51,6 +53,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <20000000>;
 		reg = <1>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <1>;
 	};
 };
 
-- 
2.7.4
