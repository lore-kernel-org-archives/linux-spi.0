From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: add optional DMA-safe bounce buffer for
 data transfer
Date: Tue, 26 Dec 2017 19:12:09 +0530
Message-ID: <1126731d-cbf7-8fbf-34ab-8ccf1cc8241f@ti.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        <richard-/L3Ra7n9ekc@public.gmane.org>, <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Cyrille,

Thanks for doing this series! One comment below.

On 24-Dec-17 10:06 AM, Cyrille Pitchen wrote:
[...]
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

Better way would be to use virt_addr_valid():
static bool spi_nor_is_dma_safe(const void *buf)
{
	return virt_addr_valid(buf);
}

Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
