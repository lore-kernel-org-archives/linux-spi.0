From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/2] [RFC] spi: rspi: Handle dmaengine_prep_slave_sg() failures gracefully
Date: Fri, 11 Jul 2014 01:47:52 +0200
Message-ID: <1976766.LYbV6saU9X@avalon>
References: <1404901583-31366-1-git-send-email-geert+renesas@glider.be> <1498087.H5vJvgGuNO@avalon> <CAMuHMdXj=Y0w39iyY9GPjUJPXC7UgPyeqk7+G+zZeAvGoE1fGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXj=Y0w39iyY9GPjUJPXC7UgPyeqk7+G+zZeAvGoE1fGg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On Thursday 10 July 2014 13:55:43 Geert Uytterhoeven wrote:
> On Thu, Jul 10, 2014 at 1:08 PM, Laurent Pinchart wrote:
> >> --- a/drivers/spi/spi-rspi.c
> >> +++ b/drivers/spi/spi-rspi.c
> >> @@ -477,7 +477,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi,
> >> struct sg_table *tx, tx->sgl, tx->nents, DMA_TO_DEVICE,
> >>                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >>               if (!desc_tx)
> >> -                     return -EIO;
> >> +                     goto no_dma;
> >>               irq_mask |= SPCR_SPTIE;
> >>       }
> >> 
> >> @@ -486,7 +486,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi,
> >> struct sg_table *tx, rx->sgl, rx->nents, DMA_FROM_DEVICE,
> >>                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >>               if (!desc_rx)
> >> -                     return -EIO;
> >> +                     goto no_dma;
> > 
> > This is not a new issue introduced by this patch, but aren't you leaking
> > desc_tx here ?
> 
> AFAIK, descriptors are cleaned up automatically after use, and the only
> function that takes a dma_async_tx_descriptor is dmaengine_submit().
> 
> But indeed, if you don't use them, that doesn't happen.
> So calling dmaengine_terminate_all() seems appropriate to fix this.
> 
> But, Documentation/dmaengine.txt says:
> 
>         desc = dmaengine_prep_slave_sg(chan, sgl, nr_sg, direction, flags);
> 
>    Once a descriptor has been obtained, the callback information can be
>    added and the descriptor must then be submitted.  Some DMA engine
>    drivers may hold a spinlock between a successful preparation and
>    submission so it is important that these two operations are closely
>    paired.
> 
> W.r.t. the spinlock, is it safe to call dmaengine_terminate_all() for a
> prepared but not submitted transfer?
> Is there another/better way?

Basically, I have no idea. I'm pretty sure some drivers will support it, 
others won't. Reading the code won't help much, as there's no available 
information regarding what the expected behaviour is. Welcome to the wonderful 
world of the undocumented DMA engine API :-)

The best way to move forward would be to decide on a behaviour and document 
it. If nobody objects, drivers that don't implement the correct behaviour 
could be considered as broken, and should be fixed. If someone objects, then a 
discussion should spring up, and hopefully an agreement will be achieved on 
what the correct behaviour is.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
