From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings documentation" to the spi tree
Date: Wed, 20 Mar 2019 17:30:09 +0000 (GMT)
Message-ID: <20190320173009.E92E61126E4C@debutante.sirena.org.uk>
References: <1553010727-23157-2-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-spi@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553010727-23157-2-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings documentation

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

>From 57a9f6e7eefa697349ff4823f178fd56abe27345 Mon Sep 17 00:00:00 2001
From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 19 Mar 2019 15:52:05 +0000
Subject: [PATCH] dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings
 documentation

The Synopsys SSI driver uses a mandatory clock that is not documented,
so detail it in the device tree bindings. Also correct the spelling of
"pins" in the "Optional Properties" section for the driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 2864bc6b659c..bcd8f960afb9 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,10 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
+- clocks : phandle for the core clock used to generate the external SPI clock.
 
 Optional properties:
-- cs-gpios : Specifies the gpio pis to be used for chipselects.
+- cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
@@ -25,6 +26,7 @@ Example:
 		interrupts = <0 154 4>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&spi_m_clk>;
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
-- 
2.20.1
