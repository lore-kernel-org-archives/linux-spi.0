From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] spi: introduce max message size and use it in the
 fsl-espi driver
Date: Sun, 7 Aug 2016 21:46:52 +0200
Message-ID: <01d94235-a874-9331-e7ad-b326fb78271d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Recently a maximum transfer size was was introduced in struct spi_master.
However there are also spi controllers with a maximum message size, e.g.
fsl-espi has a max message size of 64KB.
As there are no (known) spi controller with differing size limits for
transfer and message, introduce a flag in spi_master to indicate that
the max transfer size is also the maximum message size.

Then use this flag in the m25p80 driver to calculate proper read chunks
for such controllers.

Eventually this new feature allows to significantly simplify the
fsl-espi driver.

Heiner Kallweit (3):
  spi: introduce max message size flag in spi_master
  mtd: m25p80: consider max message size in m25p80_read
  spi: fsl-espi: eliminate spi nor flash read loop

 drivers/mtd/devices/m25p80.c |  7 +++-
 drivers/spi/spi-fsl-espi.c   | 88 ++++++++++----------------------------------
 include/linux/spi/spi.h      |  4 ++
 3 files changed, 30 insertions(+), 69 deletions(-)

-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
