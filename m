From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] [RFC] spi: rspi: Handle dmaengine_prep_slave_sg()
 failures gracefully
Date: Fri, 11 Jul 2014 15:58:07 +0200
Message-ID: <CAMuHMdWw6BZn5HnvkxbEbbG+j52YcJhtxHoL=PVjUC0kag=-tw@mail.gmail.com>
References: <1404901583-31366-1-git-send-email-geert+renesas@glider.be>
	<1976766.LYbV6saU9X@avalon>
	<CAMuHMdWgThOk+ant7YH4vMrQGuF=BbHsWxKQzkHyGZX=_aVrFQ@mail.gmail.com>
	<1457944.5hKp0epgQY@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457944.5hKp0epgQY@avalon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Laurent,

On Fri, Jul 11, 2014 at 3:27 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
>> >> AFAIK, descriptors are cleaned up automatically after use, and the only
>> >> function that takes a dma_async_tx_descriptor is dmaengine_submit().
>> >> But indeed, if you don't use them, that doesn't happen.
>> >> So calling dmaengine_terminate_all() seems appropriate to fix this.
>> >>
>> >> But, Documentation/dmaengine.txt says:
>> >>         desc = dmaengine_prep_slave_sg(chan, sgl, nr_sg, direction,
>> >>         flags);
>> >>
>> >>    Once a descriptor has been obtained, the callback information can be
>> >>    added and the descriptor must then be submitted.  Some DMA engine
>> >>    drivers may hold a spinlock between a successful preparation and
>> >>    submission so it is important that these two operations are closely
>> >>    paired.
>> >>
>> >> W.r.t. the spinlock, is it safe to call dmaengine_terminate_all() for a
>> >> prepared but not submitted transfer?
>> >> Is there another/better way?
>> >
>> > Basically, I have no idea. I'm pretty sure some drivers will support it,
>> > others won't. Reading the code won't help much, as there's no available
>> > information regarding what the expected behaviour is. Welcome to the
>> > wonderful world of the undocumented DMA engine API :-)
>>
>> I did dive a bit into the code...
>>
>> 1.  The spinlock comment seems to apply to INTEL_IOATDMA only.
>>     This driver doesn't implement dma_device.device_control(), so
>>     dmaengine_terminate_all() is a no-op there, and there doesn't seem to be
>>     a way to release a descriptor without submitting it first.
>>
>> 2.  While I thought dmaengine_terminate_all() would release all descriptors
>>     on shdma, as it calls shdma_chan_ld_cleanup(), it only releases the
>>     descriptors that are at least in submitted state.
>>     Hence after a while, you get
>>
>>         sh-dma-engine e6700020.dma-controller: No free link descriptor
>>         available
>>
>>     Interestingly, this contradicts with the comment in
>>     shdma_free_chan_resources():
>>
>>         /* Prepared and not submitted descriptors can still be on the queue
>> */
>>         if (!list_empty(&schan->ld_queue))
>>                 shdma_chan_ld_cleanup(schan, true);
>>
>> As dmaengine_submit() will not start the DMA operation, but merely add it
>> to the pending queue (starting needs a call to dma_async_issue_pending()),
>> it seems the right solution is to continue submitting the request for which
>> preparation succeeded, and then aborting everything using
>> dmaengine_terminate_all().
>>
>> Note that this also means that if submitting the RX request failed, you
>> should still submit the TX request, as it has been prepared.
>>
>> Alternatively, you can interleave prep and submit for both channels, which
>> makes the error recovery code less convoluted.
>
> How about fixing the DMA API to allow cleaning up a prepared request without
> submitting it ?

That's another option. But that would require updating all drivers.

Note that only ioat, iop-adma, mv_xor, and ppc4xx do not implement
.device_control() and/or DMA_TERMINATE_ALL.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
