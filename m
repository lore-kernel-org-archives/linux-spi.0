From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v3 0/7] add device tree for SAM9X60 SoC and SAM9X60-EK board
Date: Tue, 14 Jan 2020 12:23:10 +0200
Message-ID: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <radu_nicolae.pirea-8LCfxC+Vs8U@public.gmane.org>, <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series add device tree for SAM9X60 SoC and SAM9X60-EK board.
Allong with these, there are patches that documents some compatibles
for SAM9X60's IPs.

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

Claudiu Beznea (6):
  dt-bindings: atmel-tcb: remove wildcard
  dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
  dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
  dt-bindings: atmel-usart: remove wildcard
  dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
  ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B

Sandeep Sheriker Mallikarjun (1):
  ARM: dts: at91: sam9x60: add device tree for soc and board

 .../devicetree/bindings/mfd/atmel-tcb.txt          |   7 +-
 .../devicetree/bindings/mfd/atmel-usart.txt        |   8 +-
 .../bindings/rtc/atmel,at91rm9200-rtc.txt          |   3 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/at91-sam9x60ek.dts               | 647 +++++++++++++++++++
 arch/arm/boot/dts/sam9x60.dtsi                     | 691 +++++++++++++++++++++
 arch/arm/configs/at91_dt_defconfig                 |   4 +
 7 files changed, 1355 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sam9x60ek.dts
 create mode 100644 arch/arm/boot/dts/sam9x60.dtsi

-- 
2.7.4
