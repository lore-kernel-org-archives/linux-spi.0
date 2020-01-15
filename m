From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 3/5] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
Date: Wed, 15 Jan 2020 12:59:45 +0200
Message-ID: <1579085987-13976-4-git-send-email-claudiu.beznea@microchip.com>
References: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To: <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <a.zummo@towertech.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add microchip,sam9x60-usart and add microchip,sam9x60-dbgu to DT
bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 614a14b5d205..a09133066aff 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -4,8 +4,10 @@ Required properties for USART:
 - compatible: Should be one of the following:
 	- "atmel,at91rm9200-usart"
 	- "atmel,at91sam9260-usart"
+	- "microchip,sam9x60-usart"
 	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
 	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"
+	- "microchip,sam9x60-dbgu", "microchip,sam9x60-usart"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
-- 
2.7.4
