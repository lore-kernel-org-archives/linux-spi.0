From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH linux-next 0/4] mtd: spi-nor: fix Quad SPI memory support
Date: Fri, 18 Sep 2015 17:49:24 +0200
Message-ID: <cover.1442590224.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>, <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

this series of patches fixes the QSPI support mostly for Micron and
Macronix memories. There are also some updates for Spansion memories.
There are also many comments to explain the implementation choices based
on the datasheets from memory manufacturers.

The series was backported to a at91-4.1 kernel then tested on a sama5d2
xplained board, which embeds a at25df321a memory on a SPI controller and
a Micron n25q128a13 QSPI memory on the new Atmel QSPI controller.

The at25 memory was used to check non regression on the m25p80 driver
whereas the Micron memory was used to test the fixes of the spi-nor
framework. The driver for the Atmel QSPI controller will be sent in a
dedicated series.

Best Regards,

Cyrille

Cyrille Pitchen (4):
  mtd: spi-nor: remove unused read_xfer/write_xfer hooks
  mtd: spi-nor: properly detect the memory when it boots in Quad or Dual
    mode
  mtd: spi-nor: fix Quad SPI mode support for Spansion, Micron and
    Macronix
  mtd: m25p80: add support of dual and quad spi protocols to all
    commands

 drivers/mtd/devices/m25p80.c  | 254 ++++++++++---
 drivers/mtd/spi-nor/spi-nor.c | 811 ++++++++++++++++++++++++++++++++++++------
 include/linux/mtd/spi-nor.h   |  69 ++--
 3 files changed, 954 insertions(+), 180 deletions(-)

-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
