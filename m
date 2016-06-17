From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 0/3] scatterlist: Add support to clone sg_table
Date: Fri, 17 Jun 2016 17:45:10 -0500
Message-ID: <1466203513-4771-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	<akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, <nsekhar-l0cyMroinI0@public.gmane.org>, <vigneshr-l0cyMroinI0@public.gmane.org>,
	<peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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

Franklin S Cooper Jr (3):
  lib/scatterlist: Add support to clone sg_table
  spi: omap2-mcspi: Add comments for RX only DMA buffer workaround
  spi: omap2-mcspi: Use the SPI framework to handle DMA mapping

 drivers/spi/spi-omap2-mcspi.c | 122 +++++++++++++++++-------------------------
 include/linux/scatterlist.h   |   2 +
 lib/scatterlist.c             |  93 ++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 73 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
