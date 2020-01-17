From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v5 0/2] add device tree for SAM9X60 SoC and SAM9X60-EK board
Date: Fri, 17 Jan 2020 13:58:27 +0200
Message-ID: <1579262309-6542-1-git-send-email-claudiu.beznea@microchip.com>
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
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

This series contains only DT binding documentation for
microchip,sam9x60-usart and add microchip,sam9x60-dbgu. I kept its
title and versioning for reference. Only these 2 patches in this
version left. The other were applied by Alexandre.

Thank you,
Claudiu Beznea

Changes in v5:
- remove patches:
	- dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
	- ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B
	- ARM: dts: at91: sam9x60: add device tree for soc and board
  as they were applied.
- collected Acked-for-mfd-by

Changes in v4:
- remove patches:
	- dt-bindings: atmel-tcb: remove wildcard
	- dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
  since they were applied
- address review comments
- fix compatible list for dbug in sam9x60.dtsi

Changes in v3:
- remove applied patches from series
- split patch "dt-bindings: atmel-tcb: add microchip,sam9x60-tcb" in two patches:
	- dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
	- dt-bindings: atmel-tcb: remove wildcard
- split patch "dt-bindings: atmel-usart: remove wildcard" in two patches:
	- dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
	- dt-bindings: atmel-usart: remove wildcard
  and adapt them as per review comments
- collect acked-by tags

Changes in v2:
- replace patch "dt-bindings: at_xdmac: add entry for microchip compatibles"
  by patches:
	- dt-bindings: at_xdmac: add microchip,sam9x60-dma
	- dt-bindings: at_xdmac: remove wildcard.
- replace patch "dt-bindings: atmel-usart: add microchip,<chip>-usart"
  by patches:
	- dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
	- dt-bindings: atmel-usart: remove wildcard
- remove patch "dt-bindings: spi_atmel: add microchip,sam9x60-spi"
  as it was accepted
- collect reviewed-by tags

Claudiu Beznea (2):
  dt-bindings: atmel-usart: remove wildcard
  dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}

 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.7.4
