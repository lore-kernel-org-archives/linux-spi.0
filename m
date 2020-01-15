From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 1/5] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
Date: Wed, 15 Jan 2020 12:59:43 +0200
Message-ID: <1579085987-13976-2-git-send-email-claudiu.beznea@microchip.com>
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

Add microchip,sam9x60-rtc to DT bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
index 5d3791e789c6..35eab9138d0b 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
@@ -1,7 +1,8 @@
 Atmel AT91RM9200 Real Time Clock
 
 Required properties:
-- compatible: should be: "atmel,at91rm9200-rtc" or "atmel,at91sam9x5-rtc"
+- compatible: should be: "atmel,at91rm9200-rtc", "atmel,at91sam9x5-rtc" or
+  "microchip,sam9x60-rtc"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: rtc alarm/event interrupt
-- 
2.7.4
