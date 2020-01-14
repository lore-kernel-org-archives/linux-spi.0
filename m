From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/7] dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
Date: Tue, 14 Jan 2020 12:23:12 +0200
Message-ID: <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To: <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <a.zummo@towertech.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add microchip,sam9x60-tcb to DT bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
index 8b197db8a3c3..5c78f46ff204 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
@@ -2,6 +2,7 @@
 - compatible: Should be one of the following:
 	- "atmel,at91rm9200-tcb"
 	- "atmel,at91sam9x5-tcb"
+	- "microchip,sam9x60-tcb"
   followed by: "simple-mfd", "syscon"
 - reg: Should contain registers location and length
 - #address-cells: has to be 1
-- 
2.7.4
