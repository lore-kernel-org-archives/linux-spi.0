From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: add optional DMA-safe bounce buffer
 for data transfer
Date: Sun, 7 Jan 2018 21:49:00 +0100
Message-ID: <20180107214900.21bfed26@bbrezillon>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
        <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org,
        marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Cyrille,

On Sun, 24 Dec 2017 05:36:04 +0100
Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org> wrote:

> This patch has two purposes:
> 
> 1 - To fix the compatible issue between the MTD and SPI sub-systems
> 
> The MTD sub-system has no particular requirement about the memory areas it
> uses. Especially, ubifs is well known for using vmalloc'ed buffers, which
> then are not DMA-safe. There are reasons behind that, so we have to deal
> with it.

Well, the only reason is that it's easier to deal with
virtually contiguous memory region, and since the LEB/PEB size can be
quite big (especially for NAND devices) we have to allocate it with
vmalloc() to prevent memory fragmentation.

The solution would be to allocate an array of ubi->min_io_size buffers
using kzalloc() and write/read to/from the MTD device using this
granularity, but this approach would require quite a few changes and
that's not the topic here.

> 
> On the other hand, the SPI sub-system clearly states in the kernel doc for
> 'struct spi-transfer' (include/linux/spi/spi.h) that both .tx_buf and
> .rx_buf must point into "dma-safe memory". This requirement has not been
> taken into account by the m25p80.c driver, at the border between MTD and
> SPI, for a long time now. So it's high time to fix this issue.

I agree, even if I guess the MTD layer is not the only offender and
having this bounce buffer logic at the SPI level would be even better
IMO. But let's solve the problem in the SPI-NOR layer for now.

> 
> 2 - To help other SPI flash controller drivers to perform DMA transfers
> 
> Those controller drivers suffer the same issue as those behind the
> m25p80.c driver in the SPI sub-system: They may be provided by the MTD
> sub-system with buffers not suited to DMA operations. We want to avoid
> each controller to implement its own bounce buffer so we offer them some
> optional bounce buffer, allocated and managed by the spi-nor framework
> itself, as an helper to add support to DMA transfers.
> 
> Then the patch adds two hardware capabilities for SPI flash controllers,
> SNOR_HWCAPS_WR_BOUNCE and SNOR_HWCAPS_RD_BOUNCE.

Do you have good reasons to handle the read/write path independently? I
mean, if you need a bounce buffer for one of them it's likely that
you'll need it for both.

> 
> SPI flash controller drivers are supposed to use them to request the
> spi-nor framework to allocate an optional bounce buffer in some
> DMA-safe memory area then to use it in some cases during (Fast) Read
> and/or Page Program operations.
> 
> More precisely, the bounce buffer is used if and only if two conditions
> are met:
> 1 - The SPI flash controller driver has declared the
>     SNOR_HWCAPS_RD_BOUNCE, resp. SNOR_HWCAPS_WR_BOUNCE for (Fast) Read,
>     resp. Page Program operations.
> 2 - The buffer provided by the above MTD layer is not already in a
>     DMA-safe area.
> 
> This policy avoid using the bounce buffer when not explicitly requested
> or when not needed, hence limiting the performance penalty.
> 
> Besides, the bounce buffer is allocated once for all at the very first
> time it is actually needed.

Hm, I think it would be better to allocate the buffer at detection/probe
time, when you have all the information you need (sector_size?). My
fear is that you might not be able to kmalloc() a large buffer the
first time a read/write operation is performed, and that means the
operation might randomly fail/succeed depending on when the first IO
operation is done. If you do it at probe time, you'll be able to detect
the allocation failure early and stop the MTD dev registration when
this is the case.

> This means that as long as all buffers
> provided by the above MTD layer are allocated in some DMA-safe areas, the
> bounce buffer itself is never allocated.
> 
> Finally, the bounce buffer size is limited to 256KiB, the currently known
> maximum erase sector size. This tradeoff should still provide good
> performances even if new memory parts come with even larger erase sector
> sizes, limiting the memory footprint at the same time.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
> ---
>  drivers/mtd/devices/m25p80.c  |   4 +-
>  drivers/mtd/spi-nor/spi-nor.c | 136 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mtd/spi-nor.h   |   8 +++
>  3 files changed, 139 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index a4e18f6aaa33..60878c62a654 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -239,7 +239,9 @@ static int m25p_probe(struct spi_device *spi)
>  	struct spi_nor_hwcaps hwcaps = {
>  		.mask = SNOR_HWCAPS_READ |
>  			SNOR_HWCAPS_READ_FAST |
> -			SNOR_HWCAPS_PP,
> +			SNOR_HWCAPS_PP |
> +			SNOR_HWCAPS_RD_BOUNCE |
> +			SNOR_HWCAPS_WR_BOUNCE,
>  	};
>  	char *flash_name;
>  	int ret;
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8bafd462f0ae..59f9fbd45234 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -14,8 +14,10 @@
>  #include <linux/errno.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/highmem.h>
>  #include <linux/mutex.h>
>  #include <linux/math64.h>
> +#include <linux/mm.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  
> @@ -1232,6 +1234,56 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ },
>  };
>  
> +static bool spi_nor_is_dma_safe(const void *buf)
> +{
> +	if (is_vmalloc_addr(buf))
> +		return false;
> +
> +#ifdef CONFIG_HIGHMEM
> +	if ((unsigned long)buf >= PKMAP_BASE &&
> +	    (unsigned long)buf < (PKMAP_BASE + (LAST_PKMAP * PAGE_SIZE)))
> +		return false;
> +#endif
> +
> +	return true;
> +}
> +
> +static int spi_nor_get_bounce_buffer(struct spi_nor *nor,
> +				     u_char **buffer,
> +				     size_t *buffer_size)
> +{
> +	const struct flash_info *info = nor->info;
> +	/*
> +	 * Limit the size of the bounce buffer to 256KB: this is currently
> +	 * the largest known erase sector size (> page size) and should be
> +	 * enough to still reach good performances if some day new memory
> +	 * parts use even larger erase sector sizes.
> +	 */
> +	size_t size = min_t(size_t, info->sector_size, SZ_256K);

Wow! That's a huge max size for a buffer allocated with kmalloc. Are
you sure you shouldn't shrink it a bit? Don't know what the usual
sector_size is, but AFAIU sector_size is the ->erasesize, and read/write
operations are done at a ->writesize or ->writebufsize granularity.

> +
> +	/*
> +	 * Allocate the bounce buffer once for all at the first time it is
> +	 * actually needed. This prevents wasting some precious memory
> +	 * in cases where it would never be needed.
> +	 */
> +	if (unlikely(!nor->bounce_buffer)) {

I've been told that unlikely/likely() specifiers are not so useful
these days and are sometime doing worse than when nothing is specified.
I must admit I never went as far as evaluating it myself, but I don't
think it's really needed here (the time spent doing this check is
likely to be negligible compared to the IO operation).

> +		nor->bounce_buffer = devm_kmalloc(nor->dev, size, GFP_KERNEL);

Nope, devm_kmalloc() is not DMA-safe (see this thread [1]).

> +
> +		/*
> +		 * The SPI flash controller driver has required and expects to
> +		 * use the DMA-safe bounce buffer, so we can't recover from
> +		 * this allocation failure.
> +		 */
> +		if (!nor->bounce_buffer)
> +			return -ENOMEM;
> +	}
> +
> +	*buffer = nor->bounce_buffer;
> +	*buffer_size = size;
> +
> +	return 0;
> +}
> +

Regards,

Boris

[1]http://linux-arm-kernel.infradead.narkive.com/vyJqy0RQ/question-devm-kmalloc-for-dma
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
