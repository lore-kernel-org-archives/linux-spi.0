From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 5/8] Documentation: dt: spi: Add Broadcom NSP, NS2 SoC bindings
Date: Fri, 29 Jul 2016 18:13:10 -0400
Message-ID: <1469830393-13295-6-git-send-email-kdasu.kdev@gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
	f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469830393-13295-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Modify device tree bindings documentation to include
NS*, Cygnus and iProc SoCs supported by the new spi-bcm-qspi,
spi-nsp-qspi driver.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt  | 96 +++++++++++++++++++++-
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
index bbae763..bc01b73 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
@@ -5,8 +5,8 @@ BRCMSTB (BCM7XXX), Cygnus, NSP and NS2. The Broadcom Master SPI hw IP consits
 of :
  MSPI : SPI master controller can read and write to a SPI slave device
  BSPI : Broadcom SPI in combination with the MSPI hw IP provides acceleration
-        for flash reads and be configured to do single, double, quad lane
-        io with 3-byte and 4-byte addressing support.
+	for flash reads and be configured to do single, double, quad lane
+	io with 3-byte and 4-byte addressing support.
 
  Supported Broadcom SoCs have one instance of MSPI+BSPI controller IP.
  MSPI master can be used wihout BSPI. BRCMSTB SoCs have an additional instance
@@ -26,6 +26,8 @@ Required properties:
     "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-qspi" : MSPI+BSPI on BRCMSTB SoCs
     "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
 						   BRCMSTB  SoCs
+    "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi" : Uses MSPI+BSPI on Cygnus, NSP,
+			 		       NS2 SoCs
 
 - reg:
     Define the bases and ranges of the associated I/O address spaces.
@@ -35,8 +37,10 @@ Required properties:
     First name does not matter, but must be reserved for the MSPI controller
     register range as mentioned in 'reg' above, and will typically contain
     - "bspi_regs": BSPI register range, not required with compatible
-                   "spi-brcmstb-mspi"
+		   "spi-brcmstb-mspi"
     - "mspi_regs": MSPI register range is required for compatible strings
+    - "intr_regs", "intr_status_reg" : Interrupt and status register for
+      NSP, NS2, Cygnus SoC
 
 - interrupts
     The interrupts used by the MSPI and/or BSPI controller.
@@ -143,3 +147,89 @@ BRCMSTB SoC Example:
 		interrupt-names = "mspi_done";
 	};
 
+iProc SoC Example:
+
+    qspi: spi@18027200 {
+	compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+	reg = <0x18027200 0x184>,
+	      <0x18027000 0x124>,
+	      <0x1811c408 0x004>,
+	      <0x180273a0 0x01c>;
+	reg-names = "mspi_regs", "bspi_regs", "intr_regs", "intr_status_reg";
+	interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names =
+		     "spi_lr_fullness_reached",
+		     "spi_lr_session_aborted",
+		     "spi_lr_impatient",
+		     "spi_lr_session_done",
+		     "mspi_done",
+		     "mspi_halted";
+	clocks = <&iprocmed>;
+	clock-names = "iprocmed";
+	clock-frequency = <12500000>;
+	num-cs = <2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+    };
+
+
+ NS2 SoC Example:
+
+	       qspi: spi@66470200 {
+		       compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+		       reg = <0x66470200 0x184>,
+			     <0x66470000 0x124>,
+			     <0x67017408 0x004>,
+			     <0x664703a0 0x01c>;
+		       reg-names = "mspi", "bspi", "intr_regs",
+			"intr_status_reg";
+		       interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
+		       interrupt-names = "spi_l1_intr";
+			clocks = <&iprocmed>;
+			clock-names = "iprocmed";
+			clock-frequency = <12500000>;
+			num-cs = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+	       };
+
+
+ m25p80 node for NSP, NS2
+
+	 &qspi {
+		      flash: m25p80@0 {
+		      #address-cells = <1>;
+		      #size-cells = <1>;
+		      compatible = "m25p80";
+		      reg = <0x0>;
+		      spi-max-frequency = <12500000>;
+		      m25p,fast-read;
+		      spi-cpol;
+		      spi-cpha;
+
+		      partition@0 {
+				  label = "boot";
+				  reg = <0x00000000 0x000a0000>;
+		      };
+
+		      partition@1 {
+				  label = "env";
+				  reg = <0x000a0000 0x00060000>;
+		      };
+
+		      partition@2 {
+				  label = "system";
+				  reg = <0x00100000 0x00600000>;
+		      };
+
+		      partition@3 {
+				  label = "rootfs";
+				  reg = <0x00700000 0x01900000>;
+		      };
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
