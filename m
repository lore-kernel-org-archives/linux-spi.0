From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH 10/11] ARM64: dts: ls1046a: Remove fsl,
 qspi-has-second-chip as it is not used
Date: Wed, 30 May 2018 15:14:39 +0200
Message-ID: <1527686082-15142-11-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, yogeshnarayan.gaur@nxp.com,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, broonie@kernel.org,
 Will Deacon <will.deacon@arm.com>, Minghuan Lian <Minghuan.Lian@nxp.com>,
 miquel.raynal@bootlin.com, david.wolfe@nxp.com, richard@nod.at,
 marek.vasut@gmail.com, Frieder Schrempf <frieder.schrempf@exceet.de>,
 devicetree@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, han.xu@nxp.com,
 linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
 Yuantian Tang <andy.tang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, prabhakar.kushwaha@nxp.com,
 fabio.estevam@nxp.com, Ran Wang <ran.wang_1@nxp.com>, dwmw2@infradead.org
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
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

After switching to the new FSL QSPI driver the property
'fsl,qspi-has-second-chip' is not needed anymore.

The driver now uses the 'reg' property to determine the bus and
the chipselect.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 136ebfa..871189e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -247,7 +247,6 @@
 			clock-names = "qspi_en", "qspi";
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
 			big-endian;
-			fsl,qspi-has-second-chip;
 			status = "disabled";
 		};
 
-- 
2.7.4
