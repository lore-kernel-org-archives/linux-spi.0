From: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [RFC PATCH 0/2] Enable DMA transfers for SAM9 and fix cache aliasing
Date: Wed, 15 Nov 2017 18:35:30 +0200
Message-ID: <1510763732-10151-1-git-send-email-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patches are an attempt to fix the following problem:
On SAM9 SoCs the cache model is VIVT thus 2 different cache may exist for
the same physical address, and because of that, when we allocate memory
with vmalloc and try to use DMA to read or write from/to this region it's
possible to get cache coherency problems.

To solve this, I have investigated the mailing list for possible solutions
and other drivers as well. The buffers coming from the filesystem allocated
with vmalloc are not in a DMA coherent area in this scenario. MTDblock
layer solve this problem for the other file system, but for file systems
based on MTD directly like UBIFS, this is not happening.

One solution is to use bounce buffers to copy the data in a DMA coherent
area. This will add a certain delay though and impact the performance. To
have best possible outcome we need to pass the same buffer to the DMA
engine, but insure that the memory is cache coherent before we read from
it, and the cache is invalidated after we write to the memory. To achieve
that I have added a cache flush on the buffer before starting the DMA
operation and a cache invalidate after DMA operation completes.

>From my point of view this is the best and most simple approach.

I based these patches on Russell King idea
https://lkml.org/lkml/2017/6/23/509

I welcome any feedback about this solution.

Thanks.



Radu Pirea (2):
  Revert "spi: atmel: fix corrupted data issue on SAM9 family SoCs"
  spi: atmel: Fix DMA transfers data corruption

 drivers/spi/spi-atmel.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
