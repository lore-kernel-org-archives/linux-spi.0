From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: [PATCH v4 0/2] J-Core SPI controller support
Date: Thu, 28 Jul 2016 06:11:40 +0000
Message-ID: <cover.1469686300.git.dalias@libc.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This driver is used with the J2, an open-source VHDL reimplementation
of SH-2. I've split it out from the main J-Core support patches going
upstream through my own linux-sh tree. Changes since the v3 should
include everything requested by Mark Brown in previous review (mainly
the chipsel changes I failed to make before), plus significant cleanup
(removal of unused macros and other cruft) and refactoring to
eliminate duplicate code.

Rich


Rich Felker (2):
  of: add J-Core SPI master bindings
  spi: add driver for J-Core SPI controller

 .../devicetree/bindings/spi/jcore,spi.txt          |  30 +++
 drivers/spi/Kconfig                                |   4 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-jcore.c                            | 220 +++++++++++++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
 create mode 100644 drivers/spi/spi-jcore.c

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
