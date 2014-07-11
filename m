From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] [RFC] spi: rspi: Handle dmaengine_prep_slave_sg()
 failures gracefully
Date: Fri, 11 Jul 2014 15:22:14 +0200
Message-ID: <CAMuHMdWgThOk+ant7YH4vMrQGuF=BbHsWxKQzkHyGZX=_aVrFQ@mail.gmail.com>
References: <1404901583-31366-1-git-send-email-geert+renesas@glider.be>
	<1498087.H5vJvgGuNO@avalon>
	<CAMuHMdXj=Y0w39iyY9GPjUJPXC7UgPyeqk7+G+zZeAvGoE1fGg@mail.gmail.com>
	<1976766.LYbV6saU9X@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	dmaengine@vger.kernel.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1976766.LYbV6saU9X@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Laurent,

On Fri, Jul 11, 2014 at 1:47 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 10 July 2014 13:55:43 Geert Uytterhoeven wrote:
>> On Thu, Jul 10, 2014 at 1:08 PM, Laurent Pinchart wrote:
>> >> --- a/drivers/spi/spi-rspi.c
>> >> +++ b/drivers/spi/spi-rspi.c
>> >> @@ -477,7 +477,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi,
>> >> struct sg_table *tx, tx->sgl, tx->nents, DMA_TO_DEVICE,
>> >>                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> >>               if (!desc_tx)
>> >> -                     return -EIO;
>> >> +                     goto no_dma;
>> >>               irq_mask |= SPCR_SPTIE;
>> >>       }
>> >>
>> >> @@ -486,7 +486,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi,
>> >> struct sg_table *tx, rx->sgl, rx->nents, DMA_FROM_DEVICE,
>> >>                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> >>               if (!desc_rx)
>> >> -                     return -EIO;
>> >> +                     goto no_dma;
>> >
>> > This is not a new issue introduced by this patch, but aren't you leaking
>> > desc_tx here ?
>>
>> AFAIK, descriptors are cleaned up automatically after use, and the only
>> function that takes a dma_async_tx_descriptor is dmaengine_submit().
>>
>> But indeed, if you don't use them, that doesn't happen.
>> So calling dmaengine_terminate_all() seems appropriate to fix this.
>>
>> But, Documentation/dmaengine.txt says:
>>
>>         desc = dmaengine_prep_slave_sg(chan, sgl, nr_sg, direction, flags);
>>
>>    Once a descriptor has been obtained, the callback information can be
>>    added and the descriptor must then be submitted.  Some DMA engine
>>    drivers may hold a spinlock between a successful preparation and
>>    submission so it is important that these two operations are closely
>>    paired.
>>
>> W.r.t. the spinlock, is it safe to call dmaengine_terminate_all() for a
>> prepared but not submitted transfer?
>> Is there another/better way?
>
> Basically, I have no idea. I'm pretty sure some drivers will support it,
> others won't. Reading the code won't help much, as there's no available
> information regarding what the expected behaviour is. Welcome to the wonderful
> world of the undocumented DMA engine API :-)

I did dive a bit into the code...

1.  The spinlock comment seems to apply to INTEL_IOATDMA only.
    This driver doesn't implement dma_device.device_control(), so
    dmaengine_terminate_all() is a no-op there, and there doesn't seem to be
    a way to release a descriptor without submitting it first.

2.  While I thought dmaengine_terminate_all() would release all descriptors
    on shdma, as it calls shdma_chan_ld_cleanup(), it only releases the
    descriptors that are at least in submitted state.
    Hence after a while, you get

        sh-dma-engine e6700020.dma-controller: No free link descriptor available

    Interestingly, this contradicts with the comment in
    shdma_free_chan_resources():

        /* Prepared and not submitted descriptors can still be on the queue */
        if (!list_empty(&schan->ld_queue))
                shdma_chan_ld_cleanup(schan, true);

As dmaengine_submit() will not start the DMA operation, but merely add it
to the pending queue (starting needs a call to dma_async_issue_pending()),
it seems the right solution is to continue submitting the request for which
preparation succeeded, and then aborting everything using
dmaengine_terminate_all().

Note that this also means that if submitting the RX request failed, you should
still submit the TX request, as it has been prepared.

Alternatively, you can interleave prep and submit for both channels, which
makes the error recovery code less convoluted.

> The best way to move forward would be to decide on a behaviour and document
> it. If nobody objects, drivers that don't implement the correct behaviour
> could be considered as broken, and should be fixed. If someone objects, then a
> discussion should spring up, and hopefully an agreement will be achieved on
> what the correct behaviour is.

Right...

The document already says "the descriptor must then be submitted",
which matches with the above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
