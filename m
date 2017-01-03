From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v3 0/2] spi: lantiq-ssc: add support for Lantiq SSC SPI controller
Date: Tue,  3 Jan 2017 18:20:13 +0100
Message-ID: <20170103172015.13052-1-hauke@hauke-m.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It took me longer than expected to get this to work with the
transfer_one() callback.

changes since v2:
 * take bits_per_word and speed_hz from the transfer
 * remove support for 24 bit transfer
 * only mark the transfer as complete if the tx fifo is empty
 * check if the error interrupt was really triggered
 * rename check_finished to transfer_status
 * improve some commit messages

changes since v1:
 * renamed from Intel to Lantiq
 * make use of transfer_one and related functions
 * make use of check_finished function
 * use generic GPIO CS handling
 * enable IRQs only after the device was initialized

Hauke Mehrtens (2):
  spi: add transfer_status() callback
  spi: lantiq-ssc: add support for Lantiq SSC SPI controller

 .../devicetree/bindings/spi/spi-lantiq-ssc.txt     |  29 +
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-lantiq-ssc.c                       | 952 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  14 +
 include/linux/spi/spi.h                            |   3 +
 6 files changed, 1007 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
 create mode 100644 drivers/spi/spi-lantiq-ssc.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
