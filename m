From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] spi: Add Meson SPICC driver
Date: Tue, 23 May 2017 15:39:31 +0200
Message-ID: <1495546773-20479-1-git-send-email-narmstrong@baylibre.com>
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Meson SPICC is generic SPI controller for general purpose Full-Duplex
communications with dedicated 16 words RX/TX PIO FIFOs.
It differs completely from the SPIFC, and thus need a separate driver.

The current driver only supportd the PIO transfer mode since the DMA seems
broken on available hardware.

This driver has been tested on a Amlogic S905X board.

Neil Armstrong (2):
  dt-bindings: spi-meson: Add SPICC bindings
  spi: Add Meson SPICC driver

 .../devicetree/bindings/spi/spi-meson.txt          |  31 ++
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-meson-spicc.c                      | 619 +++++++++++++++++++++
 4 files changed, 658 insertions(+)
 create mode 100644 drivers/spi/spi-meson-spicc.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
