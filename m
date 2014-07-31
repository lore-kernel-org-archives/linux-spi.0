From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] spi: davinci: add support for gpio cs through dt
Date: Thu, 31 Jul 2014 20:33:13 +0300
Message-ID: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
	Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This small series enables GPIO chip select feature for Davinci SPI
when DT-boot mode is used.
This is actual for Keystone 2 which supports DT-boot mode only.

Murali Karicheri (2):
  spi: davinci: fix to support more than 2 chip selects
  spi: davinci: add support to configure GPIO CS through DT

 .../devicetree/bindings/spi/spi-davinci.txt        |    9 ++-
 drivers/spi/spi-davinci.c                          |   71 +++++++++++++++++---
 2 files changed, 68 insertions(+), 12 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
