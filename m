From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH net-next 09/11] ARM: dts: ls1021a-tsn: Add debugging GPIOs for the SJA1105 and DSPI drivers
Date: Fri, 16 Aug 2019 03:44:47 +0300
Message-ID: <20190816004449.10100-10-olteanv@gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816004449.10100-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

These GPIOs are exported to the expansion pin header at the rear of the
board:

EXP1_GPIO7: row 1, pin 9 from left
EXP1_GPIO6: row 1, pin 8 from left

Experimentally I could only see EXP1_GPIO6 (the pin currently assigned
to the DSPI driver) actually toggle on an analyzer - I don't know why,
but on my board, EXP1_GPIO7 isn't.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 arch/arm/boot/dts/ls1021a-tsn.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/ls1021a-tsn.dts
index 9d4eee986f53..6cec454c484c 100644
--- a/arch/arm/boot/dts/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/ls1021a-tsn.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "ls1021a.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "NXP LS1021A-TSN Board";
@@ -34,6 +35,8 @@
 
 &dspi0 {
 	bus-num = <0>;
+	/* EXP1_GPIO6 is GPIO4_18 */
+	debug-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
 	/* ADG704BRMZ 1:4 SPI mux/demux */
@@ -57,6 +60,8 @@
 		/* SPI controller settings for SJA1105 timing requirements */
 		fsl,spi-cs-sck-delay = <1000>;
 		fsl,spi-sck-cs-delay = <1000>;
+		/* EXP1_GPIO7 is GPIO4_19 */
+		debug-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.17.1
