From: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 0/2] Zynq QSPI RFC
Date: Thu, 10 Jul 2014 14:20:05 +0530
Message-ID: <1404982207-4707-1-git-send-email-harinik@xilinx.com>
Cc: michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org,
	artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Xilinx Zynq uses a QSPI controller that is based on the Cadence SPI IP.
This controller implements all the functionality required to support
Quad SPI NOR flash devices.
This driver along with the MTD layer is used to support flash devices.

This series is for the following purposes:
- RFC of the Quad SPI driver.
- We currently use a custom MTD layer and would like to get inputs on
  dual stacked/dual parallel handling (described below).

The flash device(s) can be connected in the three configurations:
1. Single - One flash device with 1 CS, 1 Clock and 4 IO lines.
2. Dual Parallel - Two flash devices connected with common CS and
   separate IO lines (resulting in 8 IO lines).
   In this configuration, the controller
   a) Duplicates commands, address etc. sent on both sets of 4 IO lines.
   b) Stripes data both transmitted and received i.e.
      4 bits of data is sent to the first flash and the other 4 bits
      to the second flash. Similarly read data is also consolidated.
   Due to this, TX and RX data handling in the driver need special
   handling for parallel mode.
3. Dual Stacked - Two flash devices connected with separate CS and
   4 common IO lines. This is largely similar to single, except for
   the slave selection logic.
The above configuration is conveyed to the QSPI driver through a
devicetree property.

The QSPI driver differs from the existing Cadence SPI driver in
the following respects majorly:
1. TX and RX handling: Different TX registers are used to write into
   the TX FIFO. TXD0, TXD1, TXD2 and TXD3 are used write 4, 1, 2 and 3
   bytes respectively. Depending on the TXD register used, the received
   bytes also need to be handled separately.
2. Depending on the configuration in which flash devices are connected
   (single, parallel or stacked), QSPI controller configuration registers
   need to be modified.
3. There is no support for extended slave select in QSPI, as opposed to
   SPI. In case of stacked configuration, the slave select field remains
   the same and a different configuration bit is used to select between
   the two flash devices.
4. Handling of dual parallel configuration.

MTD layer:
The Xilinx Zynq MTD layer by far makes use of the mainline version with
some differences. The primary flash families supported are
Spansion, Winbond and Micron.
- Probe:
  - In dual configurations, both flash devices are recognized as one
    continuous memory. (ID is read only from one flash and it is a 
    pre-stated assumption that both flash devices have the same flash
    make and size.)
- Addressing:
  a) In dual stacked mode, the address passed to the MTD layer can be
     between 0x0 to 2*(one flash size). Hence the MTD layer has to recognize
     whether the address belongs to the first flash or the second flash
     subtract the offset and indicate the same to the QSPI driver.
  b) In dual stacked mode too the address can range between
     0 to 2*(one flash size). But, when an 8 bit word is written,
     4 bits are written to the first and 4 bits are written to the
     second flash. Hence the address sent is always halved and checks
     are in place for even address and even length.
- 4 byte addressing is not supported and hence bank selection logic is used
  along with the addressing system described above.
- Flash register read/writes, for example, lock/unlock, quad enable etc.
  are handled differently in dual stacked and parallel modes.

I'm sorry for the long  cover letter. Hope it helps.

Harini Katakam (2):
  spi: Add support for Zynq QSPI controller
  devicetree: Add devicetree bindings documentation for Zynq QSPI

 .../devicetree/bindings/spi/spi-zynq-qspi.txt      |   28 +
 drivers/spi/Kconfig                                |    6 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-zynq-qspi.c                        |  854 ++++++++++++++++++++
 4 files changed, 889 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
 create mode 100644 drivers/spi/spi-zynq-qspi.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
