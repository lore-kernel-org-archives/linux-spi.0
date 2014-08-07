From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/12] spi: sh-msiof: Fix leaking of unused DMA descriptors
Date: Thu, 7 Aug 2014 10:55:01 +0200
Message-ID: <CAMuHMdUd3OKqDwhLSCMW-rEQSnWky+saN5TgC005rkmNPfEL+g@mail.gmail.com>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
	<1407329949-5695-7-git-send-email-geert+renesas@glider.be>
	<1888537.ONCuOO6jck@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	dmaengine@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1888537.ONCuOO6jck@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Laurent,

On Thu, Aug 7, 2014 at 2:07 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 06 August 2014 14:59:03 Geert Uytterhoeven wrote:
>> +++ b/drivers/spi/spi-sh-msiof.c
>> @@ -636,48 +636,38 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv
>> *p, const void *tx, dma_cookie_t cookie;
>>       int ret;
>>
>> -     if (tx) {
>> -             ier_bits |= IER_TDREQE | IER_TDMAE;
>> -             dma_sync_single_for_device(p->master->dma_tx->device->dev,
>> -                                        p->tx_dma_addr, len, DMA_TO_DEVICE);
>> -             desc_tx = dmaengine_prep_slave_single(p->master->dma_tx,
>> -                                     p->tx_dma_addr, len, DMA_TO_DEVICE,
>> -                                     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> -             if (!desc_tx)
>> -                     return -EAGAIN;
>> -     }
>> -
>> +     /* First prepare and submit the DMA request(s), as this may fail */
>>       if (rx) {
>>               ier_bits |= IER_RDREQE | IER_RDMAE;
>>               desc_rx = dmaengine_prep_slave_single(p->master->dma_rx,
>>                                       p->rx_dma_addr, len, DMA_FROM_DEVICE,
>>                                       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> -             if (!desc_rx)
>> -                     return -EAGAIN;
>> -     }
>> -
>> -     /* 1 stage FIFO watermarks for DMA */
>> -     sh_msiof_write(p, FCTR, FCTR_TFWM_1 | FCTR_RFWM_1);
>> -
>> -     /* setup msiof transfer mode registers (32-bit words) */
>> -     sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
>> -
>> -     sh_msiof_write(p, IER, ier_bits);
>> -
>> -     reinit_completion(&p->done);
>> +             if (!desc_rx) {
>> +                     ret = -EAGAIN;
>> +                     goto no_dma_rx;
>
> You could return -EAGAIN directly here.

Indeed...

>> +             }
>>
>> -     if (rx) {
>>               desc_rx->callback = sh_msiof_dma_complete;
>>               desc_rx->callback_param = p;
>>               cookie = dmaengine_submit(desc_rx);
>>               if (dma_submit_error(cookie)) {
>>                       ret = cookie;
>> -                     goto stop_ier;
>> +                     goto no_dma_rx;

... and here, too. Will do.

>> @@ -688,15 +678,30 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv
>> *p, const void *tx, cookie = dmaengine_submit(desc_tx);
>>               if (dma_submit_error(cookie)) {
>>                       ret = cookie;
>> -                     goto stop_rx;
>> +                     goto no_dma_tx;
>>               }
>> -             dma_async_issue_pending(p->master->dma_tx);
>>       }
>>
>> +     /* 1 stage FIFO watermarks for DMA */
>> +     sh_msiof_write(p, FCTR, FCTR_TFWM_1 | FCTR_RFWM_1);
>> +
>> +     /* setup msiof transfer mode registers (32-bit words) */
>> +     sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
>> +
>> +     sh_msiof_write(p, IER, ier_bits);
>> +
>> +     reinit_completion(&p->done);
>> +
>> +     /* Now start DMA */
>> +     if (tx)
>> +             dma_async_issue_pending(p->master->dma_rx);
>
> if (tx) issue pending on dma_rx ? Shouldn't is be tx -> tx and rx -> rx below
> ? I would also start rx before tx, but that might be an unnecessary
> precaution.

Woops. That check should indeed be "if (rx)", and the one below should
be "if (tx)".

>> +     if (rx)
>> +             dma_async_issue_pending(p->master->dma_tx);
>> +

While I did test transmit-only in the past, usually I tested transmit + receive
only, as the attached PMIC doesn't offer much test potential for large
write-only transfers.

Will send an update soon.

Thanks for your review!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
