From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pic32-sqi: add binding document for PIC32 Quad-SPI driver." to the spi tree
Date: Mon, 18 Apr 2016 20:04:16 +0100
Message-ID: <E1asET2-0006nI-CD@debutante>
References: <1460719639-4132-1-git-send-email-purna.mandal@microchip.com>
Cc: Rob Herring <rob@kernel.org>, Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
To: Purna Chandra Mandal <purna.mandal@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460719639-4132-1-git-send-email-purna.mandal@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pic32-sqi: add binding document for PIC32 Quad-SPI driver.

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 0a4afaae989c47fd93b73cc83d2c4a46b55aa1b7 Mon Sep 17 00:00:00 2001
From: Purna Chandra Mandal <purna.mandal@microchip.com>
Date: Fri, 15 Apr 2016 16:57:18 +0530
Subject: [PATCH] spi: pic32-sqi: add binding document for PIC32 Quad-SPI
 driver.

Document Device tree bindings for the quad SPI peripheral
found on Microchip PIC32 class devices.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Acked-by: Rob Herring <rob@kernel.org>

Cc: Kumar Gala <galak@codeaurora.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/sqi-pic32.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/sqi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/sqi-pic32.txt b/Documentation/devicetree/bindings/spi/sqi-pic32.txt
new file mode 100644
index 000000000000..c82d021bce50
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sqi-pic32.txt
@@ -0,0 +1,18 @@
+Microchip PIC32 Quad SPI controller
+-----------------------------------
+Required properties:
+- compatible: Should be "microchip,pic32mzda-sqi".
+- reg: Address and length of SQI controller register space.
+- interrupts: Should contain SQI interrupt.
+- clocks: Should contain phandle of two clocks in sequence, one that drives
+          clock on SPI bus and other that drives SQI controller.
+- clock-names: Should be "spi_ck" and "reg_ck" in order.
+
+Example:
+	sqi1: spi@1f8e2000 {
+		compatible = "microchip,pic32mzda-sqi";
+		reg = <0x1f8e2000 0x200>;
+		clocks = <&rootclk REF2CLK>, <&rootclk PB5CLK>;
+		clock-names = "spi_ck", "reg_ck";
+		interrupts = <169 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
2.8.0.rc3
