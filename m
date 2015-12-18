From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 0/4] spi: loopback-test: improvements and move dump method
Date: Fri, 18 Dec 2015 12:44:23 +0000
Message-ID: <1450442668-2391-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Move spi_message dump method into SPI-core and make use of
this extended version of the dumping code in loopback-test.

Also fix the module parameter dump_messages so that it is now a
bitmask that allows for better granularity when to dump what.

Finally add support for SPI_LOOP when spi_master supports it -
this has been sugested by Geert Uytterhoeven.

Martin Sperl (4):
  spi: core: add spi_message_dump and spi_transfer_dump
  spi: loopback-test: move to use spi_message_dump_data
  spi: loopback-test: make dump_messages module parameter a bitmask
  spi: loopback-test: added support for HW-loopback mode

 drivers/spi/spi-loopback-test.c |  123 ++++++++++++---------------------
 drivers/spi/spi.c               |  146 +++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h         |   30 ++++++++
 3 files changed, 220 insertions(+), 79 deletions(-)

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
