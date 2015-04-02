From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/4] ARM: dts: Add binding for Broadcom MSPI driver.
Date: Thu, 2 Apr 2015 12:23:20 -0700
Message-ID: <1428002603-21892-2-git-send-email-jonathar@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428002603-21892-1-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Signed-off-by: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/spi/brcm,mspi-spi.txt      |   38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
new file mode 100644
index 0000000..16164e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
@@ -0,0 +1,38 @@
+Broadcom MSPI controller
+
+Required properties:
+- compatible: Must be either "brcm,mspi" or "brcm,bcma-mspi". Use
+  "brcm,bcma-mspi" for controllers on a bcma bus and "brcm,mspi" otherwise.
+
+- reg:  Physical base address and length of the controller's registers.
+
+- interrupts: The interrupt id for the controller.
+
+- #address-cells: should be 1.
+
+- #size-cells: should be 0.
+
+Optional properties:
+- clocks: The MSPI reference clock. If not provided then it is assumed a clock
+  is enabled by default and no control of clock-frequency (see below) is
+  possible.
+
+- clock-names: The name of the reference clock.
+
+- clock-frequency: Desired frequency of the clock. This will set the serial
+  clock baud rate (SPBR) based on the reference clock frequency. The frequency
+  of the SPBR is mspi_clk / (2 * SPBR) where SPBR is a value between 1-255
+  determined by the desired 'clock-frequency'. If not provided then the default
+  baud rate of the controller is used.
+
+Example:
+
+mspi@18047000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "brcm,mspi";
+	reg = <0x18047000 0x1000>;
+	clocks = <&axi41_clk>;
+	clock-names = "mspi_clk";
+	clock-frequency = <12500000>;
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
