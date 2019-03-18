From: Mark Brown <broonie@kernel.org>
Subject: Applied "doc: lpspi: Document DT bindings for LPSPI clocks" to the spi tree
Date: Mon, 18 Mar 2019 14:52:18 +0000 (GMT)
Message-ID: <20190318145218.99E09112887B@debutante.sirena.org.uk>
References: <20190306063020.793-3-xiaoning.wang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306063020.793-3-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   doc: lpspi: Document DT bindings for LPSPI clocks

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From addb32866d99068307f8eddb282ebb325d18446f Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Wed, 6 Mar 2019 06:30:36 +0000
Subject: [PATCH] doc: lpspi: Document DT bindings for LPSPI clocks

Add introductions of clocks and clock-names strings.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt          | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 6cc3c6fe25a3..e71b81a41ac0 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -7,7 +7,11 @@ Required properties:
 - reg : address and length of the lpspi master registers
 - interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
-- clocks : lpspi clock specifier
+- clocks : lpspi clock specifier. Its number and order need to correspond to the
+	   value in clock-names.
+- clock-names : Corresponding to per clock and ipg clock in "clocks"
+		respectively. In i.MX7ULP, it only has per clk, so use CLK_DUMMY
+		to fill the "ipg" blank.
 - spi-slave : spi slave mode support. In slave mode, add this attribute without
 	      value. In master mode, remove it.
 
@@ -18,6 +22,8 @@ lpspi2: lpspi@40290000 {
 	reg = <0x40290000 0x10000>;
 	interrupt-parent = <&intc>;
 	interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks IMX7ULP_CLK_LPSPI2>;
+	clocks = <&clks IMX7ULP_CLK_LPSPI2>,
+		 <&clks IMX7ULP_CLK_DUMMY>;
+	clock-names = "per", "ipg";
 	spi-slave;
 };
-- 
2.20.1
