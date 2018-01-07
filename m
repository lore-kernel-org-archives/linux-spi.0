From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: add optional DMA-safe bounce buffer
 for data transfer
Date: Sun, 7 Jan 2018 21:07:03 +0100
Message-ID: <20180107210703.31fdf0a0@bbrezillon>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
        <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen@wedev4u.fr>
        <1126731d-cbf7-8fbf-34ab-8ccf1cc8241f@ti.com>
        <ae977280-28b4-d746-da4b-0f807dad609d@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
        radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ae977280-28b4-d746-da4b-0f807dad609d-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 26 Dec 2017 14:59:00 +0100
Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org> wrote:

> Hi Vignesh
> 
> Le 26/12/2017 à 14:42, Vignesh R a écrit :
> > Hi Cyrille,
> > 
> > Thanks for doing this series! One comment below.
> > 
> > On 24-Dec-17 10:06 AM, Cyrille Pitchen wrote:
> > [...]  
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> >> index 8bafd462f0ae..59f9fbd45234 100644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -14,8 +14,10 @@
> >>  #include <linux/errno.h>
> >>  #include <linux/module.h>
> >>  #include <linux/device.h>
> >> +#include <linux/highmem.h>
> >>  #include <linux/mutex.h>
> >>  #include <linux/math64.h>
> >> +#include <linux/mm.h>
> >>  #include <linux/sizes.h>
> >>  #include <linux/slab.h>
> >>  
> >> @@ -1232,6 +1234,56 @@ static const struct flash_info spi_nor_ids[] = {
> >>  	{ },
> >>  };
> >>  
> >> +static bool spi_nor_is_dma_safe(const void *buf)
> >> +{
> >> +	if (is_vmalloc_addr(buf))
> >> +		return false;
> >> +
> >> +#ifdef CONFIG_HIGHMEM
> >> +	if ((unsigned long)buf >= PKMAP_BASE &&
> >> +	    (unsigned long)buf < (PKMAP_BASE + (LAST_PKMAP * PAGE_SIZE)))
> >> +		return false;
> >> +#endif
> >> +
> >> +	return true;
> >> +}
> >> +  
> > 
> > Better way would be to use virt_addr_valid():
> > static bool spi_nor_is_dma_safe(const void *buf)
> > {
> > 	return virt_addr_valid(buf);
> > }
> > 
> > Regards
> > Vignesh
> >   
> 
> Thanks for the advice :)
> 
> https://patchwork.kernel.org/patch/9768341/
> Maybe I could check both virt_addr_valid() and object_is_on_stack() too ?

Yep, see the explanation given here [1].

[1]http://elixir.free-electrons.com/linux/v4.15-rc6/source/Documentation/DMA-API-HOWTO.txt#L132
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
