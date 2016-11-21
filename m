From: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] Fixes for Vybrid SPI DMA implementation
Date: Mon, 21 Nov 2016 11:24:00 +0530
Message-ID: <cover.1479706671.git.maitysanchayan@gmail.com>
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

The following set of patches have fixes for Vybrid SPI DMA
implementation along with some minor clean ups requested
at time when v3 version of SPI DMA support patch was accepted.

This series of patches is based on top of branch topic/fsl-dspi.
http://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=topic/fsl-dspi

The patches have been tested on a Toradex Colibri Vybrid VF61 module
and now incoporate feedback from Stefan on version 1 of patchset.

Changes since v1:
1. Place the continuous selection format patch second in order and remove
code duplication
2. Improve the use of curr_xfer_len and instead of converting from bytes
to DMA transfers in every use, do it at a single place. Accordingly change
it's use at other places
3. Code cleanup patch has less to clean with change above 

v1:
http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1274632.html

Thanks & Regards,
Sanchayan.

Sanchayan Maity (4):
  spi: spi-fsl-dspi: Fix SPI transfer issue when using multiple SPI_IOC_MESSAGE
  spi: spi-fsl-dspi: Fix continuous selection format
  spi: spi-fsl-dspi: Fix incorrect DMA setup
  spi: spi-fsl-dspi: Minor code cleanup and error path fixes

 drivers/spi/spi-fsl-dspi.c | 71 ++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 27 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
