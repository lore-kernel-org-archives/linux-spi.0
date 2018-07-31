From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: document Microsemi integration" to the spi tree
Date: Tue, 31 Jul 2018 15:41:42 +0100 (BST)
Message-ID: <20180731144142.D81C811242BD@debutante.sirena.org.uk>
References: <20180731143855.7131-2-alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731143855.7131-2-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: document Microsemi integration

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

>From f09757ab401ff332030f8e3a41cec6a44e6d9461 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 31 Jul 2018 16:38:53 +0200
Subject: [PATCH] spi: dw: document Microsemi integration

The integration of the Designware SPI controller on Microsemi SoCs requires
an extra register set to be able to give the IP control of the SPI
interface.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 204b311e0400..642d3fb1ef85 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -1,8 +1,10 @@
 Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
-- compatible : "snps,dw-apb-ssi"
-- reg : The register base for the controller.
+- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
+  "jaguar2"
+- reg : The register base for the controller. For "mscc,<soc>-spi", a second
+  register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- 
2.18.0
