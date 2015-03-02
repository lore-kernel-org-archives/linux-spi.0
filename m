From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/9] spi: dw: make DMA working
Date: Mon,  2 Mar 2015 20:15:57 +0200
Message-ID: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series dedicated to make DMA working on Intel Medfield device with
SPI DW and DW DMA. The previous version would be found here [1].

First two patches are bug fixes. Patch 5/9 is bugfix as well, though it's not
marked as a fix to reduce a noise on stable kernels, where DMA wasn't working
properly anyway. Last one is the removal of old DMA driver, since the only user
of it in upstrem was SPI DW.

NOTE: the patch series depends on not applied yet [2, 3].

Vinod, since the patch 9/9 removes the driver your are author of, please give
your Ack. Reliminary answer, as I remember, was okay to remove.

The driver was tested in loop back mode. It looks like there are not so many
users of it right now, but I would really appreciate if anyone could test the
driver on different hardware platforms (to be sure that I didn't break it).

As a side effect the patch 8/9 fixes the memore leak in probe(). Mark, we
discussed tha bug earlier in last year.

[1] http://www.spinics.net/lists/linux-spi/msg01871.html
[2] http://marc.info/?l=linux-spi&m=142530114318498&w=2
[3] http://www.spinics.net/lists/linux-spi/msg02982.html

Changelog v2:
- change the approach (most of the patches were rewritten)
- rebased on top of recent linux-next
- added IRQ handler for DMA case to cover FIFO overrun/underrun issue

Andy Shevchenko (9):
  spi: dw-mid: avoid potential NULL dereference
  spi: dw-mid: clear BUSY flag fist and test other one
  spi: dw-mid: convert value of dma_width to enum dma_slave_buswidth
  spi: dw-mid: split dma_setup() from dma_transfer()
  spi: dw-mid: take care of FIFO overrun/underrun when do DMA
  spi: dw-mid: clear ongoing DMA transfers on timeout
  spi: dw-mid: move to use core SPI DMA mappings
  spi: dw-mid: convert to use dw_dmac instead of intel_mid_dma
  dmaengine: intel-mid-dma: remove the driver

 drivers/dma/Kconfig              |   13 -
 drivers/dma/Makefile             |    1 -
 drivers/dma/intel_mid_dma.c      | 1447 --------------------------------------
 drivers/dma/intel_mid_dma_regs.h |  299 --------
 drivers/spi/Kconfig              |    2 +-
 drivers/spi/spi-dw-mid.c         |  169 +++--
 drivers/spi/spi-dw.c             |   74 +-
 drivers/spi/spi-dw.h             |   22 +-
 include/linux/intel_mid_dma.h    |   76 --
 9 files changed, 147 insertions(+), 1956 deletions(-)
 delete mode 100644 drivers/dma/intel_mid_dma.c
 delete mode 100644 drivers/dma/intel_mid_dma_regs.h
 delete mode 100644 include/linux/intel_mid_dma.h

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
