From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] spi: davinci: add support for gpio cs through dt
Date: Fri, 1 Aug 2014 19:40:31 +0300
Message-ID: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This small series enables GPIO chip select feature for Davinci SPI
when DT-boot mode is used.
This is actual for Keystone 2 which supports DT-boot mode only.

Changes in v2:
- gpio_request_one() is used
- as suggested by Mark Brown, new patch has been added which updates
  Davinci SPI driver to use cs_gpio field
  of SPI device structure (spi_device) for both DT and non-DT cases.

v1:
 http://www.spinics.net/lists/linux-spi/msg01446.html

Grygorii Strashko (1):
  spi: davinci: use spi_device.cs_gpio to store gpio cs per spi device

Murali Karicheri (1):
  spi: davinci: add support to configure gpio cs through dt

 .../devicetree/bindings/spi/spi-davinci.txt        |    9 ++-
 drivers/spi/spi-davinci.c                          |   60 ++++++++++++++------
 2 files changed, 52 insertions(+), 17 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
