From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/5] spi: rspi: Remove casts
Date: Fri, 27 Dec 2013 19:38:43 +0100
Message-ID: <CAMuHMdXyeRdgFJF0MzJkJ5jf1pSWfO98mdn-JSF0ze2iuTbLug@mail.gmail.com>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
	<1387878574-21445-3-git-send-email-geert+renesas@linux-m68k.org>
	<2810034.n2a8aHlIUW@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2810034.n2a8aHlIUW@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 27, 2013 at 3:33 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> @@ -440,12 +437,13 @@ static void rspi_memory_from_8bit(void *buf, const
>> void *data, unsigned len) static int rspi_send_dma(struct rspi_data *rspi,
>> struct spi_transfer *t) {
>>       struct scatterlist sg;
>> -     void *buf = NULL;
>> +     const void *buf = NULL;
>>       struct dma_async_tx_descriptor *desc;
>>       unsigned len;
>>       int ret = 0;
>>
>>       if (rspi->dma_width_16bit) {
>> +             void *tmp;
>
> I really dislike tmp as a variable name, as it can mean pretty much anything.
> What about calling it tx_buf instead ?

Thanks, that would indeed be a better name.
However, Mark has already applied it to spi/for-next, so I'm not sure we
can still change it, without sending a complete new patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
