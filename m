From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: [PATCH 3/6] DT: add documentation for spi-fc-test driver
Date: Tue,  1 Mar 2016 15:43:17 +0100
Message-ID: <1456843400-20696-3-git-send-email-linux@rempel-privat.de>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
To: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456843400-20696-1-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-fc-test.txt        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fc-test.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-fc-test.txt b/Documentation/devicetree/bindings/spi/spi-fc-test.txt
new file mode 100644
index 0000000..c1f14e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fc-test.txt
@@ -0,0 +1,30 @@
+SPI-FC-TEST is a test driver to simulate slave
+flow control from spi master.
+
+Required properties:
+ - compatible: should be set to "spi-fc-test"
+ - fc-gpio: spi device gpio input for flow control line.
+ - test-cs-in-gpio: chip select gpio input to emulate slave device
+ - test-fc-out-gpio: request gpio output to emulate slave device
+Fallowing required properties are provided by spi framework.
+See spi-bus.txt for more information.
+ - spi-fc-ready
+ - spi-fc-stop-ack
+ - spi-fc-request
+
+Example:
+test-spi@0 {
+	status = "okay";
+	reg = <0>;
+	compatible = "spi-fc-test";
+	spi-max-frequency = <100000>;
+	spi-fc-ready;
+	spi-fc-request;
+	spi-fc-stop-ack;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_test_in_pins_bananapi>, <&spi_test_out_pins_bananapi>;
+	fc-gpio = <&pio 7 20 GPIO_ACTIVE_LOW>; /* request line, in IO-4, (PH20) */
+	test-cs-in-gpio = <&pio 7 1 GPIO_ACTIVE_LOW>; /* RXD0, (PH1)  */
+	test-rq-out-gpio = <&pio 7 21 GPIO_ACTIVE_LOW>; /* IO-5, (PH21) */
+};
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
