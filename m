From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RFC] [PATCH v2 0/3] scatterlist: Add support to clone sg_table
Date: Mon, 27 Jun 2016 09:54:06 -0500
Message-ID: <1467039249-7816-1-git-send-email-fcooper@ti.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>
To: david.s.gordon@intel.com, axboe@fb.com, akpm@linux-foundation.org,
	ming.l@ssi.samsung.com, linux-kernel@vger.kernel.org,
	broonie@kernel.org, linux-spi@vger.kernel.org, nsekhar@ti.com,
	peter.ujfalusi@ti.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patchset creates two new functions within scatterlist that allows a
user to pass in a sg_table and receive a duplicate copy. The sgl in this
copied table are dynamically allocated but its values such as offset,
length and dma_address are the same as its variant within the sgl in the
original sg_table.

This is useful when tweaks to sgl may be needed to alter a future DMA
operation by tweaking the table nents count or the individual sgl
offset/length without changing the original values.

An example use case is also included in this patchset. In the omap2-mcspi
driver on certain OMAP SOCs if certain conditions are met the DMA should
transfer one or two less elements when reading from the SPI. The
remaining bytes are read in CPU mode. To accomplish this the spi's rx_sg
sgl should have the last entry length reduced for the DMA operation.
However, this change should only be done locally so instead of altering
the original sgl this new function allows a clone to be created.

V2 changes:
Save page_link value if page_link doesn't point to chained sg_list

Franklin S Cooper Jr (3):
  scatterlist: Add support to clone scatterlist
  spi: omap2-mcspi: Add comments for RX only DMA buffer workaround
  spi: omap2-mcspi: Use the SPI framework to handle DMA mapping

 drivers/spi/spi-omap2-mcspi.c | 120 +++++++++++++++++-------------------------
 include/linux/scatterlist.h   |   2 +
 lib/scatterlist.c             | 103 ++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 73 deletions(-)

-- 
2.7.0
