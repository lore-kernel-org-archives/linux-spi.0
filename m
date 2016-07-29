From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 7/8] arm64: dts: Add ns2 SoC support
Date: Fri, 29 Jul 2016 18:13:12 -0400
Message-ID: <1469830393-13295-8-git-send-email-kdasu.kdev@gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
	f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469830393-13295-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Adding qspi node compatible with the new spi-bcm-qspi
driver for the broadcom's northstar2 SoC.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 34 ++++++++++++++++++++++++++++----
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 19 ++++++++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index ea5603f..a40d3f5 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -141,10 +141,36 @@
 	};
 };
 
-&mdio_mux_iproc {
-	mdio@10 {
-		gphy0: eth-phy@10 {
-			reg = <0x10>;
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
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 46b78fa..efc5d50 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -438,5 +438,24 @@
 
 			brcm,nand-has-wp;
 		};
+
+		qspi: spi@66470200 {
+			compatible = "brcm,spi-bcm-qspi";
+			reg = <0x66470200 0x184>,
+				<0x66470000 0x124>,
+				<0x67017408 0x004>,
+				<0x664703a0 0x01c>;
+			reg-names = "mspi", "bspi", "intr_regs",
+				"intr_status_reg";
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
