From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] spi: davinci: fixes and updates
Date: Thu, 21 Aug 2014 18:25:04 +0300
Message-ID: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <m-karicheri2-l0cyMroinI0@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <santosh.shilimkar-l0cyMroinI0@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The first patch fixes the issue for the case when SPI_NO_CS flag is set
which was introduced by previous
commit a88e34ea213e1b ("spi: davinci: add support to configure gpio cs through dt"). 

The second patch completes migration of Davinci SPI driver to DT
and adds ability to configure additional properties for SPI slave
devices which were possible to configure only from platform code
through struct davinci_spi_config

Grygorii Strashko (2):
  spi: davinci: fix SPI_NO_CS functionality
  spi: davinci: support adding delay between transmission

 .../devicetree/bindings/spi/spi-davinci.txt        |   18 ++++
 drivers/spi/spi-davinci.c                          |   96 +++++++++++++++++---
 2 files changed, 99 insertions(+), 15 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
