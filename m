From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 0/8] spi: spi-message transformation framework
Date: Mon, 14 Dec 2015 15:20:17 +0000
Message-ID: <1450106426-2277-1-git-send-email-kernel@martin.sperl.org>
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
DMA alignment or max transfer sizes.

This patchset implements at this very moment:
* splitting transfers longer than 60k in size into
  multiple transfers.
* splitting misalligned transfers (there are probably multiple
  variations necessary for different HW)
* mergeing multiple small transfers into a single transfer

The patch-set essentially is based arround spi resource
management on a spi_message basis, which was inspired by
devres.

This framework could also get used to handle spi_unmap_buf
calls with the framework.

Right now the drivers themselves have to implement
spi_master.translate_message, but as soon as the "typical"
HW-variations become apparent this may be reduced to assign
one of a set of "standard" translation methods to
spi_master.translate_message instead, but this may require
some additional parametrization of the HW characteristics.

The whole patch set has been tested successfully on a RPI with:
* spi_loopback_test - see below for stats after applying the patch-set
* enc28j60 - note that this driver does do misaligned transfers for
    	     rx and for tx resulting in a need to copy data to align
	     the transfer buffers propperly for DMA.
* fb_st7735r - framebuffer playing BigBuckBunny
* mmc-spi with an out of tree patch to work arround the mmc_spi
  internal dma mapping issues, that inhibits the driver from working
  correctly - this got introduced with commit 0589342c27944e50
   ("of: set dma_mask to point to coherent_dma_mask")

Changelog:
 V1->V2: initial split of different transforms into separate patches
         but only spi_split_transfer_maxsize was implemented
 V2->V3: complete set of transforms implemented in V1 and also merge
         transforms was implemented
         also contains several fixes based on feedback by Andy Shevchenko
	 minimized code required inside spi-bcm2835 removing all of the

spi_loopback_test produces the following statistics:
==> /sys/class/spi_master/spi32766/statistics/bytes
31840476
==> /sys/class/spi_master/spi32766/statistics/bytes_rx
22629003
==> /sys/class/spi_master/spi32766/statistics/bytes_tx
26926636
==> /sys/class/spi_master/spi32766/statistics/errors
0
==> /sys/class/spi_master/spi32766/statistics/messages
1732
==> /sys/class/spi_master/spi32766/statistics/spi_async
0
==> /sys/class/spi_master/spi32766/statistics/spi_sync
1732
==> /sys/class/spi_master/spi32766/statistics/spi_sync_immediate
1732
==> /sys/class/spi_master/spi32766/statistics/timedout
0
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_0-1
610
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_1024-2047
106
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_128-255
170
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_16-31
313
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_16384-32767
0
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_2048-4095
277
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_2-3
286
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_256-511
48
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_32-63
88
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_32768-65535
464
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_4096-8191
287
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_4-7
143
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_512-1023
158
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_64-127
222
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_65536+
0
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_8-15
369
==> /sys/class/spi_master/spi32766/statistics/transfer_bytes_histo_8192-16383
20
==> /sys/class/spi_master/spi32766/statistics/transfers
3561
==> /sys/class/spi_master/spi32766/statistics/transfers_merged
540
==> /sys/class/spi_master/spi32766/statistics/transfers_split_maxsize
320
==> /sys/class/spi_master/spi32766/statistics/transfers_split_unaligned
844
==> /sys/class/spi_master/spi32766/statistics/transfers_split_unaligned_copy
492

Martin Sperl (8):
  spi: core: added spi_resource management
  spi: core: add spi_replace_transfers method
  spi: core: add spi_split_transfers_maxsize
  spi: core: added spi_split_transfers_unaligned
  spi: core: add spi_merge_transfers method
  spi: core: add spi_master.translate_message
  spi: core: add spi_master.min_dma_len and supporting methods
  spi: bcm2835: move to spi-core methods translate_message and can_dma

 drivers/spi/spi-bcm2835.c |   58 +---
 drivers/spi/spi.c         |  848 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h   |  136 +++++++-
 3 files changed, 1002 insertions(+), 40 deletions(-)

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
