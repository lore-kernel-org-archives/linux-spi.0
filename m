From: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH 0/3] Driver for AT91 USART in SPI mode
Date: Fri, 13 Apr 2018 19:11:14 +0300
Message-ID: <20180413161117.20274-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

I wrote this driver for USART IP that is found in AT91 and SAMA5 SoCs. The
IP has an internal chip select, but is not used because is deasserted and
asserted after every byte sent over the wires. Gpio chip selects are used
instead of internal one. The driver works with actual USART nodes from
device tree of boards, but compatible must be changed, SCK pin muxed and
cs-gpio, size-cells and address-cells must be added. Of course, at the end
of the wires must be an SPI slave linked, not a serial console. :)

I tested the driver on sama5d4-xplained and sama5d3-xplained and works
without issues.

Radu Pirea (3):
  MAINTAINERS: add usart spi driver
  dt-bindings: add binding for at91-usart in spi mode
  spi: at91-usart: add driver for at91-usart as spi

 .../bindings/spi/microchip,at91-usart-spi.txt |  24 +
 MAINTAINERS                                   |   7 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 545 ++++++++++++++++++
 5 files changed, 585 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
 create mode 100644 drivers/spi/spi-at91-usart.c

-- 
2.17.0
