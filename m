From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 4/6] [RFC] Documentation: dt: Add Renesas RSPI/QSPI bindings
Date: Tue, 24 Dec 2013 12:56:48 +0100
Message-ID: <1387886210-3634-5-git-send-email-geert+renesas@linux-m68k.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387886210-3634-1-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
new file mode 100644
index 000000000000..06ec17fce4c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -0,0 +1,27 @@
+Device tree configuration for Renesas RSPI/QSPI driver
+
+Required properties:
+- compatible      : "renesas,rspi-<soctype>". "renesas,rspi-rz" as fallback,
+                    or
+                    "renesas,qspi-<soctype>", "renesas,qspi-rcar" as fallback.
+- reg             : address start and address range size of device
+- interrupts      : 3 interrupts for RSPI (SPEI, SPRI, SPTI),
+                    1 interrupt for QSPI
+- num-cs	  : Number of chip selects
+- #address-cells  : should be <1>
+- #size-cells     : should be <0>
+
+Pinctrl properties might be needed, too. See there.
+
+Example:
+
+	spi0: spi@e800c800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800c800 0x24>;
+		interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
