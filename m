From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v2 0/2] spi: lantiq-ssc: add support for Lantiq SSC SPI controller
Date: Sun, 11 Dec 2016 21:03:48 +0100
Message-ID: <20161211200350.13590-1-hauke@hauke-m.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It took me longer than expected to get this to work with the
transfer_one() callback.

changes since v1:
 * renamed from Intel to Lantiq
 * make use of transfer_one and related functions
 * make use of check_finished function
 * use generic GPIO CS handling
 * enable IRQs only after the device was initialized

Hauke Mehrtens (2):
  spi: add check_finished() callback
  spi: lantiq-ssc: add support for Lantiq SSC SPI controller

 .../devicetree/bindings/spi/spi-lantiq-ssc.txt     |  29 +
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-lantiq-ssc.c                       | 947 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  10 +
 include/linux/spi/spi.h                            |   4 +
 6 files changed, 999 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
 create mode 100644 drivers/spi/spi-lantiq-ssc.c

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
