From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v5 2/2] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
Date: Fri, 17 Jan 2020 13:58:29 +0200
Message-ID: <1579262309-6542-3-git-send-email-claudiu.beznea@microchip.com>
References: <1579262309-6542-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <radu_nicolae.pirea-8LCfxC+Vs8U@public.gmane.org>, <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1579262309-6542-1-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add microchip,sam9x60-usart and add microchip,sam9x60-dbgu to DT
bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Hi Lee,

Between version 3 (that you Acked-for-MFD-by) and this one, there is a
new line introduced in this patch:

+       - "microchip,sam9x60-usart"

I kept your Acked-for-MFD-by in this version (with the extra line).
Tell me if you consider otherwise.

Thank you,
Claudiu Beznea

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
