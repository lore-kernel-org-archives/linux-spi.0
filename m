From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/5] Add support for the Armada 3700 SPI controller
Date: Tue, 29 Nov 2016 15:39:34 +0100
Message-ID: <20161129143939.3191-1-romain.perier@free-electrons.com>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Marvell Armada 3700 SoC includes an SPI controller. This controller
supports up to 4 SPI slave devices, with dedicated chip selects, CPIO or
FIFO mode with DMA or CPU transfers and different SPI transfer modes
(Standard single, Dual or Quad).

This set of patches adds a basic support for the CPIO mode, then it
enables the FIFO mode (CPU-side only, DMA not supported yet). It also
adds the required definitions of the spi nodes to the devicetree.

Romain Perier (5):
  spi: Add basic support for Armada 3700 SPI Controller
  spi: armada-3700: Add support for the FIFO mode
  dt-bindings: spi: Add documentation for the Armada 3700 SPI Controller
  arm64: dts: marvell: Add definition of SPI controller for Armada 3700
  arm64: dts: marvell: Enable spi0 on the board Armada-3720-db

 .../devicetree/bindings/spi/spi-armada-3700.txt    |   25 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   30 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   13 +
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-armada-3700.c                      | 1047 ++++++++++++++++++++
 6 files changed, 1123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt
 create mode 100644 drivers/spi/spi-armada-3700.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
