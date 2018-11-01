From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 4/4] ARM: dts: iwg23s-sbc: Add QSPI flash support
Date: Thu,  1 Nov 2018 12:35:05 +0000
Message-ID: <1541075705-1333-5-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1541075705-1333-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Biju Das <biju.das@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms@verge.net.au>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1541075705-1333-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This commit adds QSPI flash support to the iwg23s board specific
device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 18d2263..5245a1e 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -88,6 +88,11 @@
 		power-source = <1800>;
 	};
 
+	qspi0_pins: qspi0 {
+		groups = "qspi0_ctrl", "qspi0_data2";
+		function = "qspi0";
+	};
+
 	scif1_pins: scif1 {
 		groups = "scif1_data_b";
 		function = "scif1";
@@ -106,6 +111,27 @@
 	};
 };
 
+&qspi0 {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* WARNING - This device contains the bootloader. Handle with care. */
+	flash: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "issi,is25lp016d", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+	};
+};
+
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
