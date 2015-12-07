From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 0/5] spi: spi-message transformation framework
Date: Mon,  7 Dec 2015 15:21:43 +0000
Message-ID: <1449501708-2228-1-git-send-email-kernel@martin.sperl.org>
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

This patchset implements at this very moment only splitting
transfers longer than 60k in size into multiple transfers.

Future patches based on this basic patchset:
* split misalligned transfers (there are probably multiple
  variations necessary for different HW)
* merge multiple small transfers into a single transfer

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
* spi_loopback_test
* enc28j60
* fb_st7735r - framebuffer playing BigBuckBunny
* mmc-spi with an out of tree patch to work arround the mmc_spi
  internal dma mapping issues, that inhibits the driver from working
  correctly - this got introduced with commit 0589342c27944e50
   ("of: set dma_mask to point to coherent_dma_mask")

Martin Sperl (5):
  spi: core: added spi_resource management
  spi: core: add spi_replace_transfers method
  spi: core: add spi_split_transfers_maxsize
  spi: core add spi_master.translate_message
  spi: bcm2835: make use of the spi_translate_message methods

 drivers/spi/spi-bcm2835.c |   31 +++--
 drivers/spi/spi.c         |  339 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h   |   92 ++++++++++++
 3 files changed, 448 insertions(+), 14 deletions(-)

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
