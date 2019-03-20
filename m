From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: snps,dw-apb-ssi: Add optional clock bindings documentation" to the spi tree
Date: Wed, 20 Mar 2019 17:30:07 +0000 (GMT)
Message-ID: <20190320173007.BD6281126E4C@debutante.sirena.org.uk>
References: <1553010727-23157-3-git-send-email-gareth.williams.jx@renesas.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553010727-23157-3-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: snps,dw-apb-ssi: Add optional clock bindings documentation

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

>From 2f324ac7cf8c50aa079cf30445b99a1b98ea2728 Mon Sep 17 00:00:00 2001
From: Gareth Williams <gareth.williams.jx@renesas.com>
Date: Tue, 19 Mar 2019 15:52:06 +0000
Subject: [PATCH] dt-bindings: snps,dw-apb-ssi: Add optional clock bindings
 documentation

Add documentation to the Synopsys SPI dt-bindings to support an
optional interface clock that may be used for register access.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bcd8f960afb9..f54c8c36395e 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,15 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- clocks : phandle for the core clock used to generate the external SPI clock.
+- clocks : phandles for the clocks, see the description of clock-names below.
+   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
+   is optional. If a single clock is specified but no clock-name, it is the
+   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
 
 Optional properties:
+- clock-names : Contains the names of the clocks:
+    "ssi_clk", for the core clock used to generate the external SPI clock.
+    "pclk", the interface clock, required for register access.
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
-- 
2.20.1
