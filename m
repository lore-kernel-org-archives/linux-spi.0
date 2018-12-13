From: Mark Brown <broonie@kernel.org>
Subject: Applied "doc: lpspi: Document DT bindings for LPSPI slave mode" to the spi tree
Date: Thu, 13 Dec 2018 12:09:16 +0000 (GMT)
Message-ID: <20181213120916.1C82111254D1@debutante.sirena.org.uk>
References: <20181207024924.6315-5-xiaoning.wang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207024924.6315-5-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   doc: lpspi: Document DT bindings for LPSPI slave mode

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

>From 62f82df488ce16f7068c7285820b2b7f7dcd7597 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Fri, 7 Dec 2018 02:50:41 +0000
Subject: [PATCH] doc: lpspi: Document DT bindings for LPSPI slave mode

Add introductions of interrupt-parent and spi-slave.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 8d178a4503cf..6cc3c6fe25a3 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -5,8 +5,11 @@ Required properties:
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX7ULP soc
   - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX8QXP soc
 - reg : address and length of the lpspi master registers
+- interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
+- spi-slave : spi slave mode support. In slave mode, add this attribute without
+	      value. In master mode, remove it.
 
 Examples:
 
@@ -16,4 +19,5 @@ lpspi2: lpspi@40290000 {
 	interrupt-parent = <&intc>;
 	interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clks IMX7ULP_CLK_LPSPI2>;
+	spi-slave;
 };
-- 
2.19.0.rc2
