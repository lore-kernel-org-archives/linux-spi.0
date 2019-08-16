From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH net-next 11/11] ARM: dts: ls1021a-tsn: Reduce the SJA1105 SPI frequency for debug
Date: Fri, 16 Aug 2019 03:44:49 +0300
Message-ID: <20190816004449.10100-12-olteanv@gmail.com>
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

I have a logic analyzer that cannot sample signals at a higher frequency
than this, and it's nice to actually see the captured data and not just
an amorphous mess.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 arch/arm/boot/dts/ls1021a-tsn.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/ls1021a-tsn.dts
index 3b35e6b5977f..8fdf4c3b24c7 100644
--- a/arch/arm/boot/dts/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/ls1021a-tsn.dts
@@ -55,7 +55,7 @@
 		#size-cells = <0>;
 		compatible = "nxp,sja1105t";
 		/* 12 MHz */
-		spi-max-frequency = <12000000>;
+		spi-max-frequency = <6000000>;
 		/* Sample data on trailing clock edge */
 		spi-cpha;
 		/* SPI controller settings for SJA1105 timing requirements */
-- 
2.17.1
