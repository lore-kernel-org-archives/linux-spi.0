From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings" to the spi tree
Date: Wed, 14 Sep 2016 18:16:55 +0100
Message-ID: <E1bkDnr-00020Y-9P@debutante>
References: <1472076269-4731-2-git-send-email-kdasu.kdev@gmail.com>
Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
        f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472076269-4731-2-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings

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

>From 5fc78f4c842aadb5bbe9d7033930e5b3afdffda6 Mon Sep 17 00:00:00 2001
From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 24 Aug 2016 18:04:22 -0400
Subject: [PATCH] spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings

Added device tree bindings documentation for BRCMSTB, NSP, NS2 iProc
SoCs supported by spi-bcm-qspi, spi-brcmstb-qspi and spi-iproc-qspi driver.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt  | 233 +++++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
new file mode 100644
index 000000000000..ad7ac80a3841
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
@@ -0,0 +1,233 @@
+Broadcom SPI controller
+
+The Broadcom SPI controller is a SPI master found on various SOCs, including
+BRCMSTB (BCM7XXX), Cygnus, NSP and NS2. The Broadcom Master SPI hw IP consits
+of :
+ MSPI : SPI master controller can read and write to a SPI slave device
+ BSPI : Broadcom SPI in combination with the MSPI hw IP provides acceleration
+	for flash reads and be configured to do single, double, quad lane
+	io with 3-byte and 4-byte addressing support.
+
+ Supported Broadcom SoCs have one instance of MSPI+BSPI controller IP.
+ MSPI master can be used wihout BSPI. BRCMSTB SoCs have an additional instance
+ of a MSPI master without the BSPI to use with non flash slave devices that
+ use SPI protocol.
+
+Required properties:
+
+- #address-cells:
+    Must be <1>, as required by generic SPI binding.
+
+- #size-cells:
+    Must be <0>, also as required by generic SPI binding.
+
+- compatible:
+    Must be one of :
+    "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-qspi" : MSPI+BSPI on BRCMSTB SoCs
+    "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+						   BRCMSTB  SoCs
+    "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi"     : MSPI+BSPI on Cygnus, NSP
+    "brcm,spi-bcm-qspi", "brcm,spi-ns2-qspi"     : NS2 SoCs
+
+- reg:
+    Define the bases and ranges of the associated I/O address spaces.
+    The required range is MSPI controller registers.
+
+- reg-names:
+    First name does not matter, but must be reserved for the MSPI controller
+    register range as mentioned in 'reg' above, and will typically contain
+    - "bspi_regs": BSPI register range, not required with compatible
+		   "spi-brcmstb-mspi"
+    - "mspi_regs": MSPI register range is required for compatible strings
+    - "intr_regs", "intr_status_reg" : Interrupt and status register for
+      NSP, NS2, Cygnus SoC
+
+- interrupts
+    The interrupts used by the MSPI and/or BSPI controller.
+
+- interrupt-names:
+    Names of interrupts associated with MSPI
+    - "mspi_halted" :
+    - "mspi_done": Indicates that the requested SPI operation is complete.
+    - "spi_lr_fullness_reached" : Linear read BSPI pipe full
+    - "spi_lr_session_aborted"  : Linear read BSPI pipe aborted
+    - "spi_lr_impatient" : Linear read BSPI requested when pipe empty
+    - "spi_lr_session_done" : Linear read BSPI session done
+
+- clocks:
+    A phandle to the reference clock for this block.
+
+Optional properties:
+
+
+- native-endian
+    Defined when using BE SoC and device uses BE register read/write
+
+Recommended optional m25p80 properties:
+- spi-rx-bus-width: Definition as per
+                    Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Examples:
+
+BRCMSTB SoC Example:
+
+  SPI Master (MSPI+BSPI) for SPI-NOR access:
+
+    spi@f03e3400 {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-brcmstb-qspi";
+		reg = <0xf03e0920 0x4 0xf03e3400 0x188 0xf03e3200 0x50>;
+		reg-names = "cs_reg", "mspi", "bspi";
+		interrupts = <0x6 0x5 0x4 0x3 0x2 0x1 0x0>;
+		interrupt-parent = <0x1c>;
+		interrupt-names = "mspi_halted",
+				  "mspi_done",
+				  "spi_lr_overread",
+				  "spi_lr_session_done",
+				  "spi_lr_impatient",
+				  "spi_lr_session_aborted",
+				  "spi_lr_fullness_reached";
+
+		clocks = <&hif_spi>;
+		clock-names = "sw_spi";
+
+		m25p80@0 {
+			#size-cells = <0x2>;
+			#address-cells = <0x2>;
+			compatible = "m25p80";
+			reg = <0x0>;
+			spi-max-frequency = <0x2625a00>;
+			spi-cpol;
+			spi-cpha;
+			m25p,fast-read;
+
+			flash0.bolt@0 {
+				reg = <0x0 0x0 0x0 0x100000>;
+			};
+
+			flash0.macadr@100000 {
+				reg = <0x0 0x100000 0x0 0x10000>;
+			};
+
+			flash0.nvram@110000 {
+				reg = <0x0 0x110000 0x0 0x10000>;
+			};
+
+			flash0.kernel@120000 {
+				reg = <0x0 0x120000 0x0 0x400000>;
+			};
+
+			flash0.devtree@520000 {
+				reg = <0x0 0x520000 0x0 0x10000>;
+			};
+
+			flash0.splash@530000 {
+				reg = <0x0 0x530000 0x0 0x80000>;
+			};
+
+			flash0@0 {
+				reg = <0x0 0x0 0x0 0x4000000>;
+			};
+		};
+	};
+
+
+    MSPI master for any SPI device :
+
+	spi@f0416000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&upg_fixed>;
+		compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-brcmstb-mspi";
+		reg = <0xf0416000 0x180>;
+		reg-names = "mspi";
+		interrupts = <0x14>;
+		interrupt-parent = <&irq0_aon_intc>;
+		interrupt-names = "mspi_done";
+	};
+
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
+	num-cs = <2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+    };
+
+
+ NS2 SoC Example:
+
+	       qspi: spi@66470200 {
+		       compatible = "brcm,spi-bcm-qspi", "brcm,spi-ns2-qspi";
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
+		      partition@a0000 {
+				  label = "env";
+				  reg = <0x000a0000 0x00060000>;
+		      };
+
+		      partition@100000 {
+				  label = "system";
+				  reg = <0x00100000 0x00600000>;
+		      };
+
+		      partition@700000 {
+				  label = "rootfs";
+				  reg = <0x00700000 0x01900000>;
+		      };
+	};
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
