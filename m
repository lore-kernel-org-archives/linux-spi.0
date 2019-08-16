From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH net-next 10/11] ARM: dts: ls1021a-tsn: Use the DSPI controller in poll mode
Date: Fri, 16 Aug 2019 03:44:48 +0300
Message-ID: <20190816004449.10100-11-olteanv@gmail.com>
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

Connected to the LS1021A DSPI is the SJA1105 DSA switch. This
constitutes 4 of the 6 Ethernet ports on this board. When using the
board as a PTP switch and bridging all 6 ports under one single L2
entity, it is good to also have the PTP clocks of the switch and of the
standalone Ethernet ports in sync.

This cannot be done with hardware timestamping, and is where phc2sys
comes into play. Using poll mode for SPI access helps ensure that all
transfers take a deterministic time to complete, which is an important
requirement for a TSN switch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 arch/arm/boot/dts/ls1021a-tsn.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/ls1021a-tsn.dts
index 6cec454c484c..3b35e6b5977f 100644
--- a/arch/arm/boot/dts/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/ls1021a-tsn.dts
@@ -37,6 +37,7 @@
 	bus-num = <0>;
 	/* EXP1_GPIO6 is GPIO4_18 */
 	debug-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+	/delete-property/ interrupts;
 	status = "okay";
 
 	/* ADG704BRMZ 1:4 SPI mux/demux */
-- 
2.17.1
