From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 0/3] spi: spi-message transformation framework
Date: Mon, 30 Nov 2015 13:04:51 +0000
Message-ID: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This patchset implements a spi-message transformation framework in
SPI-core, that allows drivers to transfor individual spi messages
into something that can more easily get handled by the HW.

This would typically be used for HW which has some limitations on
DMA alignment of max transfer sizes.

Note that for DMA alignment there probably exist multiple variations
of requirements for different types of HW.

The patch here implements the variation:
* a single entry in the scatter-gather list has to have a length of word
  size unless it is the last entry. Otherwise the SPI-HW FIFOs need to
  get cleared and the pending transfer size reset - this is the
  requirement of the SPI-HW implementation of the bcm2835.
  So the method will split the transfer into up to 2 or 3 transfers in
  such a way that last transfer starts on a word-aligned address and has
  maximum size. the first 1 or 2 transfers will be of only a few bytes
  in size (1,2 or 3 bytes in the case of bcm2835)

But it also can get used to aggregate multiple small spi_transfers into
a single transfer to reduce the number of transfers that need to get
executed. This is preferable as each transfer adds some  overhead -
especially with regards to DMA mapping.

Right now the "correct" methods have to be implemented inside the
spi_master.prepare_message method in the correcto order.
When it becomes clearer what other drivers may require, then we can
move the default implementation also into spi-core.

The patch-set essentially is based arround spi resource management
on a spi_message basis, which was inspired by dev_res.
This could also get used to move spi_unmap_buf calls into this framework
code and there are probably a few other use-cases as well.

The whole patch set has been tested on a raspberry pi with:
* spi_loopback_test (see below for the statistics)
* enc28j60
* fb_st7735r - framebuffer playing BigBuckBunny
* mmc-spi with an out of tree patch to work arround the mmc_spi
  internal dma mapping issues, that inhibits the driver from working
  correctly - this got introduced with commit 0589342c27944e50
   ("of: set dma_mask to point to coherent_dma_mask")

With these all my tests succeeded.

Here the spi-statistics after running spi_loopback-test without any
other spi activity directly after reboot:

root@raspcm:/sys/class/spi_master/spi32766/statistics# head *
==> bytes <==
15698948
==> bytes_rx <==
11085044
==> bytes_tx <==
13272208
==> errors <==
0
==> messages <==
752
==> spi_async <==
0
==> spi_sync <==
752
==> spi_sync_immediate <==
752
==> timedout <==
0
==> transfer_bytes_histo_0-1 <==
518
==> transfer_bytes_histo_1024-2047 <==
25
==> transfer_bytes_histo_128-255 <==
88
==> transfer_bytes_histo_16-31 <==
92
==> transfer_bytes_histo_16384-32767 <==
114
==> transfer_bytes_histo_2048-4095 <==
63
==> transfer_bytes_histo_2-3 <==
244
==> transfer_bytes_histo_256-511 <==
25
==> transfer_bytes_histo_32-63 <==
88
==> transfer_bytes_histo_32768-65535 <==
350
==> transfer_bytes_histo_4096-8191 <==
25
==> transfer_bytes_histo_4-7 <==
0
==> transfer_bytes_histo_512-1023 <==
63
==> transfer_bytes_histo_64-127 <==
151
==> transfer_bytes_histo_65536+ <==
0
==> transfer_bytes_histo_8-15 <==
0
==> transfer_bytes_histo_8192-16383 <==
0
==> transfers <==
1846
==> transfers_split_maxsize <==
160
==> transfers_split_unaligned <==
366

Martin Sperl (3):
  spi: added spi_resource management
  spi: add initial set of spi_transfer transformation methods
  spi: bcm2835: moved to the spi_transfer transformation to avoid HW
    restrictions

 drivers/spi/spi-bcm2835.c |   53 ++---
 drivers/spi/spi.c         |  504 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h   |   63 ++++++
 3 files changed, 588 insertions(+), 32 deletions(-)

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
