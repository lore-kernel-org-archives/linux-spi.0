From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/3] Spidev usability patchset update
Date: Tue, 19 Jul 2016 00:35:39 +0200
Message-ID: <cover.1468880530.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

this simplifies spidev to not pose as SPI driver but instead attach a character
device on each SPI slave indiscriminately. This does not require spidev to be
matched during driver binding and hence does not require it to be specified in
devicetree.

Any SPI slave device for which a driver is not bound to start with or from
which it is unbound is accessible with spidev.

Constructive comments on improving this patchset are welcome.

Thanks

Michal

Michal Suchanek (3):
  spi: spidev: create spidev device for all spi slaves.
  spi: of: allow instantiating slaves without a driver
  spi: core: allow creating devices without spi-max-frequency

 Documentation/spi/spidev |  40 ++---
 drivers/spi/Kconfig      |   2 +-
 drivers/spi/spi.c        |  28 +++-
 drivers/spi/spidev.c     | 370 ++++++++++++++++++++---------------------------
 include/linux/spi/spi.h  |  14 ++
 5 files changed, 201 insertions(+), 253 deletions(-)

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
