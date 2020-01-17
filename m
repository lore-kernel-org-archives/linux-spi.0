From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v5 1/2] dt-bindings: atmel-usart: remove wildcard
Date: Fri, 17 Jan 2020 13:58:28 +0200
Message-ID: <1579262309-6542-2-git-send-email-claudiu.beznea@microchip.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1579262309-6542-1-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Remove chip whildcard and introduce the list of compatibles instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 699fd3c9ace8..614a14b5d205 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -1,10 +1,11 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
 Required properties for USART:
-- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
-  The compatible <chip> indicated will be the first SoC to support an
-  additional mode or an USART new feature.
-  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
+- compatible: Should be one of the following:
+	- "atmel,at91rm9200-usart"
+	- "atmel,at91sam9260-usart"
+	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
+	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
-- 
2.7.4
