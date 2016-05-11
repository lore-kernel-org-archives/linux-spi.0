From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] arm64: dts: Add ns2 SoC support
Date: Wed, 11 May 2016 11:29:27 -0400
Message-ID: <1462980567-310-4-git-send-email-kdasu.kdev@gmail.com>
References: <1462980567-310-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462980567-310-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Adding qspi node compatible with the new spi-bcm-qspi
driver for the broadcom's northstar2 SoC.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 34 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 18 +++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index ce0ab84..82641d6 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -87,3 +87,37 @@
 		#size-cells = <1>;
 	};
 };
+
+&qspi {
+	bspi-sel = <0>;
+	flash: m25p80@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		reg = <0x0>;
+		spi-max-frequency = <12500000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partition@0 {
+			label = "boot";
+			reg = <0x00000000 0x000a0000>;
+		};
+
+		partition@1 {
+			label = "env";
+			reg = <0x000a0000 0x00060000>;
+		};
+
+		partition@2 {
+			label = "system";
+			reg = <0x00100000 0x00600000>;
+		};
+
+		partition@3 {
+			label = "rootfs";
+			reg = <0x00700000 0x01900000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 6f81c9d..421fe26 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -444,5 +444,23 @@
 
 			brcm,nand-has-wp;
 		};
+
+		qspi: spi@66470200 {
+			compatible = "brcm,spi-bcm-qspi";
+			reg = <0x66470200 0x184>,
+                              <0x66470000 0x124>,
+                              <0x67017408 0x004>,
+                              <0x664703a0 0x01c>;
+			reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+			interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "spi_l1_intr";
+			clocks = <&iprocmed>;
+			clock-names = "iprocmed";
+			clock-frequency = <12500000>;
+			num-cs = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
