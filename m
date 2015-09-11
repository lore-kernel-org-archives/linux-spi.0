From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v6 0/4] spi: bcm2835: add spi-bcm2835aux driver
Date: Fri, 11 Sep 2015 11:22:02 +0000
Message-ID: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	eEric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This patch-series adds the spi-bcm2835aux driver to the kernel.

After a long discussion of how to enable/disable the hw block,
which resulted in multiple versions, the consensus is now
that the clk-bcm2835-aux clock driver is responsible for
enabling/disabling the HW block.

So there is a dependency of this device-driver on the
clock driver that supplies that functionality.

Martin Sperl (4):
  dt/bindings: bcm2835: spi: add bindings for the bcm2835 auxiliary spi
    devices
  spi: bcm2835: add bcm2835 auxiliary spi device driver
  spi: bcm2835: add the auxiliary spi1 and spi2 to the device tree
  ARM: bcm2835: enable auxiliary spi driver in defaultconfig

 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   38 ++
 arch/arm/boot/dts/bcm2835.dtsi                     |   21 +
 arch/arm/configs/bcm2835_defconfig                 |    1 +
 drivers/spi/Kconfig                                |   11 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm2835aux.c                       |  493 ++++++++++++++++++++
 6 files changed, 565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
 create mode 100644 drivers/spi/spi-bcm2835aux.c

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
