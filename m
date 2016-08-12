From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/PROTO 5/9 option 1] arm64: dts: salvator-x: Configure MSIOF parent clock
Date: Fri, 12 Aug 2016 18:38:41 +0200
Message-ID: <1471019925-29083-6-git-send-email-geert+renesas@glider.be>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: linux-renesas-soc@vger.kernel.org
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add assigned-clocks and assigned-clock-rates DT properties to the cpg
device node, to configure the MSIOF parent clock for 20 MHz.

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not intended for upstream merge.

Note that these properties could also be added to an individual MSIOF
device node. As all MSIOF instances share the same parent clock, this
is not a good idea:
  - MSIOF instances initialized before the one with the properties will
    use the old (default) parent clock rate.
    When the MSIOF instances with the properties is initialized, the
    parent clock rate will change. In the absence of a clock notifier,
    no one will notice (at this point).
    All subsequent operations will use the new parent clock rate.
    As the MSIOF driver use clk_get_rate() before setting up each
    transfer, it will automatically adapt.
    However, spi_master.{min,max}_speed_hz are not updated (note that
    currently they are not set by the MSIOF driver anyway!).
  - If you add conflicting properties to multiple msiof nodes, they will
    still be used, but override each other, determined by probe order.

Cfr. Documentation/devicetree/bindings/clock/clock-bindings.txt

   "Configuring a clock's parent and rate through the device node that
    consumes the clock can be done only for clocks that have a single
    user. Specifying conflicting parent or rate configuration in
    multiple consumer nodes for a shared clock is forbidden."

and

   "Configuration of common clocks, which affect multiple consumer
    devices can be similarly specified in the clock provider node."
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 9040a691b8b61887..61c9f651adbdfcad 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -143,6 +143,11 @@
 	};
 };
 
+&cpg {
+	assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_MSO>;
+	assigned-clock-rates = <20000000>;
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
-- 
1.9.1
