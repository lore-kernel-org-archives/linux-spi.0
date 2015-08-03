From: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [LINUX RFC 0/2] spi: add dual parallel mode support in Zynq MPSoC GQSPI controller
Date: Mon, 3 Aug 2015 14:35:05 +0530
Message-ID: <1438592707-30713-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <ranjitw-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>, <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series is to add dual parallel mode support for Zynq Ultrascale+ MPSoC GQSPI controller driver.

What is dual parallel mode?
---------------------------
ZynqMP GQSPI controller supports Dual Parallel mode with following functionalities:
1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
2) Chip selects and clock are shared to both the flash devices
3) This mode is targeted for faster read/write speed and also doubles the size
4) Commands/data can be transmitted/received from both the devices(mirror),
   or only upper or only lower flash memory devices.
5) Data arrangement:
   With stripe enabled,
   Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
   Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

This series also updated MTD layer files for adding parallel mode support.

MTD layer dependency changes:
-----------------------------
1) Added Support for two flashes
2) Support to enable/disable data stripe as and when required.
3) Added required parameters to spi_nor structure. Initialized all
   added parameters in spi_nor_scan()
4) Added support for dual parallel in spi_nor_read/write/erase functions by:
   a) Increasing page_size, sector_size, erase_size and toatal flash size
      as and when required.
   b) Dividing address by 2
   c) Updating spi->master->flags for qspi driver to change CS
5) Updated read_sr() to get status of both flashes
6) Also updated read_fsr() to get status of both flashes

These all are very high level changes and expected to make an idea clear.
Comments and suggestions are always welcomed.

Ranjit Waghmode (2):
  mtd: spi-nor: add dual parallel mode support
  spi: zynqmp: gqspi: add support for dual parallel mode configuration

 drivers/mtd/devices/m25p80.c   |  1 +
 drivers/mtd/spi-nor/spi-nor.c  | 92 +++++++++++++++++++++++++++++++++---------
 drivers/spi/spi-zynqmp-gqspi.c | 24 ++++++++++-
 include/linux/mtd/spi-nor.h    |  3 ++
 include/linux/spi/spi.h        |  2 +
 5 files changed, 102 insertions(+), 20 deletions(-)

--
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
