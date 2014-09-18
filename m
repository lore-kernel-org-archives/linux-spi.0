From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 00/10] spi: dw: make DMA working
Date: Thu, 18 Sep 2014 20:08:50 +0300
Message-ID: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series dedicated to make DMA working on Intel Medfield device with
SPI DW and DW DMA.

NOTE: the patch 9/10 depends on recent slave-dma.git tree branch for-linus. It
would be nice to have a topic branch for that there. Vinod?

Vinod, since the patch 10/10 removes the driver your are author of, please give
your Ack or NAck.

The driver was tested in loop back mode. It still has bugs (I don't know is it
related to Medfield SoC or generic ones), but now it's in much better shape.
Earlier I submit already two fixes of kernel crashes. It looks like there are
not so many users of it right now, but I would really appreciate if anyone
could test the driver on different hardware platforms.

Mark, the patch 9/10 fixes the bug we discussed earlier (memore leak in
probe()).

Andy Shevchenko (10):
  spi: dw-mid: respect 8 bit mode
  spi: dw-mid: always use duplex transfers when DMA
  spi: dw-mid: terminate ongoing transfers at exit
  spi: dw-mid: follow new DMAengine workflow
  spi: dw: disable all interrupts first when pump message
  spi: dw: introduce support of loopback mode
  spi: dw: fix style of code in few places
  spi: dw-mid: move to use core SPI DMA mappings
  spi: dw-mid: convert to use dw_dmac instead of intel_mid_dma
  dmaengine: intel-mid-dma: remove the driver

 drivers/dma/Kconfig              |   13 -
 drivers/dma/Makefile             |    1 -
 drivers/dma/intel_mid_dma.c      | 1460 --------------------------------------
 drivers/dma/intel_mid_dma_regs.h |  299 --------
 drivers/spi/Kconfig              |    2 +-
 drivers/spi/spi-dw-mid.c         |   96 +--
 drivers/spi/spi-dw.c             |   55 +-
 drivers/spi/spi-dw.h             |   15 +-
 include/linux/intel_mid_dma.h    |   76 --
 9 files changed, 85 insertions(+), 1932 deletions(-)
 delete mode 100644 drivers/dma/intel_mid_dma.c
 delete mode 100644 drivers/dma/intel_mid_dma_regs.h
 delete mode 100644 include/linux/intel_mid_dma.h

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
