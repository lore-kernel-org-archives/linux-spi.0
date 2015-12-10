From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] spi: davinci: fix spurious i/o error
Date: Thu, 10 Dec 2015 21:59:03 +0530
Message-ID: <cover.1449764266.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series fixes a spurious I/O error with
DaVinci SPI.

v2:
- Update to handle DMA case
- add a patch to use dev_err() for error reporting

Sekhar Nori (2):
  spi: davinci: fix spurious i/o error
  spi: davinci: use dev_err() for error reporting

 drivers/spi/spi-davinci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
