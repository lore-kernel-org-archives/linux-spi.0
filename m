From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/3] spi: atmel: update DT bindings documentation
Date: Mon, 8 Jun 2015 18:07:43 +0200
Message-ID: <6f071506877a9986d1f30902339993f922387a74.1433779081.git.cyrille.pitchen@atmel.com>
References: <cover.1433779081.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1433779081.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

- add new property "atmel,fifo-size"
- change "cs-gpios" to optional for SPI controller version >= 2.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi_atmel.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
index 4f8184d..7ef7f6bc 100644
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -4,11 +4,16 @@ Required properties:
 - compatible : should be "atmel,at91rm9200-spi".
 - reg: Address and length of the register set for the device
 - interrupts: Should contain spi interrupt
-- cs-gpios: chipselects
+- cs-gpios: chipselects (optional for SPI controller version >= 2 with the
+  Alternative Command Mode).
 - clock-names: tuple listing input clock names.
 	Required elements: "spi_clk"
 - clocks: phandles to input clocks.
 
+Optional properties:
+- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
+  capable SPI controllers.
+
 Example:
 
 spi1: spi@fffcc000 {
@@ -20,6 +25,7 @@ spi1: spi@fffcc000 {
 	clocks = <&spi1_clk>;
 	clock-names = "spi_clk";
 	cs-gpios = <&pioB 3 0>;
+	atmel,fifo-size = <32>;
 	status = "okay";
 
 	mmc-slot@0 {
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
