From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: [PATCH v5 0/2] J-Core SPI controller support
Date: Wed, 3 Aug 2016 01:26:32 +0000
Message-ID: <cover.1470187592.git.dalias@libc.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Updates based on requests by Mark Brown. Driver has been made
conditional in Kconfig to avoid it showing up in configurations where
it's not relevant. Lots of small style improvements have been made,
and the input clock frequency is now handled via the clk framework
rather than a fixed clock-frequency property in the DT. Corresponding
changes were made to the DT binding patch.

Rich



Rich Felker (2):
  of: add J-Core SPI master bindings
  spi: add driver for J-Core SPI controller

 .../devicetree/bindings/spi/jcore,spi.txt          |  34 +++
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-jcore.c                            | 232 +++++++++++++++++++++
 4 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
 create mode 100644 drivers/spi/spi-jcore.c

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
