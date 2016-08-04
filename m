From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: jcore: add J-Core SPI master bindings" to the spi tree
Date: Thu, 04 Aug 2016 22:09:32 +0100
Message-ID: <E1bVPtU-0007O2-Hu@debutante>
References: <bc53c38fe100bd17b278dfb214eefea323a3ac4a.1470187592.git.dalias@libc.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
To: Rich Felker <dalias@libc.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc53c38fe100bd17b278dfb214eefea323a3ac4a.1470187592.git.dalias@libc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: jcore: add J-Core SPI master bindings

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

>From 4b87b6da506dc91b45df06984ed55fcb4676c68d Mon Sep 17 00:00:00 2001
From: Rich Felker <dalias@libc.org>
Date: Thu, 4 Aug 2016 04:30:37 +0000
Subject: [PATCH] spi: jcore: add J-Core SPI master bindings

Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/jcore,spi.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt

diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.txt b/Documentation/devicetree/bindings/spi/jcore,spi.txt
new file mode 100644
index 000000000000..93936d16e139
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/jcore,spi.txt
@@ -0,0 +1,34 @@
+J-Core SPI master
+
+Required properties:
+
+- compatible: Must be "jcore,spi2".
+
+- reg: Memory region for registers.
+
+- #address-cells: Must be 1.
+
+- #size-cells: Must be 0.
+
+Optional properties:
+
+- clocks: If a phandle named "ref_clk" is present, SPI clock speed
+  programming is relative to the frequency of the indicated clock.
+  Necessary only if the input clock rate is something other than a
+  fixed 50 MHz.
+
+- clock-names: Clock names, one for each phandle in clocks.
+
+See spi-bus.txt for additional properties not specific to this device.
+
+Example:
+
+spi@40 {
+	compatible = "jcore,spi2";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x40 0x8>;
+	spi-max-frequency = <25000000>;
+	clocks = <&bus_clk>;
+	clock-names = "ref_clk";
+}
-- 
2.8.1
