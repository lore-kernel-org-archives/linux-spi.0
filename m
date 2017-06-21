From: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 0/2] Add support for STM32 SPI
Date: Wed, 21 Jun 2017 16:32:04 +0200
Message-ID: <1498055526-6918-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patchset adds support for the STM32 Serial Peripheral Interface (SPI).

It applies to STM32 platforms implementing version 2 of SPI/I2S interface
like STM32H7 series.

It supports a half-duplex, full-duplex and simplex synchronous serial
communication with external devices with 4-bit to 16/32-bit per word.
It has two 8x/16x 8-bit embedded Rx and TxFIFOs with DMA capability.
It can operate in master or slave mode, but here, only master mode is
supported.

Amelie Delaunay (2):
  dt-bindings: spi: Document the STM32 SPI bindings
  spi: add driver for STM32 SPI controller

 .../devicetree/bindings/spi/spi-stm32.txt          |   60 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-stm32.c                            | 1266 ++++++++++++++++++++
 4 files changed, 1337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
 create mode 100644 drivers/spi/spi-stm32.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
