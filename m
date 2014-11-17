From: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] spi: Add support for Amlogic Meson SPIFC
Date: Mon, 17 Nov 2014 23:47:47 +0100
Message-ID: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
	Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
	Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

this patchset adds a driver for the SPIFC (SPI flash controller)
available in Amlogic Meson6 and Meson8 SoCs. The driver has been
tested on a Meson8 based device to communicate with a Macronix
mx25l1606e serial flash.

The first patch adds a field to the spi_transfer structure that allows
the driver to know in transfer_one() whether the transfer is the last
one and change CS accordingly, without the need to reimplement
transfer_one_message().

Changes since v1 [ https://lkml.org/lkml/2014/11/9/35 ]:
 - decrease busy wait timeout
 - remove check on xfer->speed_hz value in meson_spifc_transfer_one()
 - implement transfer_one() instead of transfer_one_message()
 - remove useless memset of devdata
 - use fixed regmap config
 - implement PM operations
 - don't set master->bus_num
 - allow modular build of the driver

Beniamino Galvani (4):
  spi: Add 'last' flag to spi_transfer structure
  spi: meson: Add device tree bindings documentation for SPIFC
  spi: meson: Add support for Amlogic Meson SPIFC
  ARM: dts: meson: add node for SPIFC

 .../devicetree/bindings/spi/spi-meson.txt          |  22 +
 arch/arm/boot/dts/meson.dtsi                       |   9 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-meson-spifc.c                      | 461 +++++++++++++++++++++
 drivers/spi/spi.c                                  |   6 +
 include/linux/spi/spi.h                            |   2 +
 7 files changed, 508 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt
 create mode 100644 drivers/spi/spi-meson-spifc.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
