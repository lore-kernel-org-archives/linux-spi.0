From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] [RFC] spi: rspi: Handle dmaengine_prep_slave_sg()
 failures gracefully
Date: Thu, 10 Jul 2014 13:55:43 +0200
Message-ID: <CAMuHMdXj=Y0w39iyY9GPjUJPXC7UgPyeqk7+G+zZeAvGoE1fGg@mail.gmail.com>
References: <1404901583-31366-1-git-send-email-geert+renesas@glider.be>
	<1498087.H5vJvgGuNO@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	dmaengine@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1498087.H5vJvgGuNO@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Laurent,

(cc dmaengine)

On Thu, Jul 10, 2014 at 1:08 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -477,7 +477,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi,
>> struct sg_table *tx, tx->sgl, tx->nents, DMA_TO_DEVICE,
>>                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>               if (!desc_tx)
>> -                     return -EIO;
>> +                     goto no_dma;
>>
>>               irq_mask |= SPCR_SPTIE;
>>       }
>> @@ -486,7 +486,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi,
>> struct sg_table *tx, rx->sgl, rx->nents, DMA_FROM_DEVICE,
>>                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>               if (!desc_rx)
>> -                     return -EIO;
>> +                     goto no_dma;
>
> This is not a new issue introduced by this patch, but aren't you leaking
> desc_tx here ?

AFAIK, descriptors are cleaned up automatically after use, and the only
function that takes a dma_async_tx_descriptor is dmaengine_submit().

But indeed, if you don't use them, that doesn't happen.
So calling dmaengine_terminate_all() seems appropriate to fix this.

But, Documentation/dmaengine.txt says:

        desc = dmaengine_prep_slave_sg(chan, sgl, nr_sg, direction, flags);

   Once a descriptor has been obtained, the callback information can be
   added and the descriptor must then be submitted.  Some DMA engine
   drivers may hold a spinlock between a successful preparation and
   submission so it is important that these two operations are closely
   paired.

W.r.t. the spinlock, is it safe to call dmaengine_terminate_all() for a prepared
but not submitted transfer?
Is there another/better way?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
