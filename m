From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] [RFC] spi: rspi: Handle dmaengine_prep_slave_sg()
 failures gracefully
Date: Thu, 10 Jul 2014 13:36:30 +0200
Message-ID: <CAMuHMdU38zJWe-fVWcSpDBFo0QJ9GsGC3Mveey64P3VE=8ggPw@mail.gmail.com>
References: <1404901583-31366-1-git-send-email-geert+renesas@glider.be>
	<6218596.RTFxRvYFXy@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6218596.RTFxRvYFXy@avalon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Laurent,

On Thu, Jul 10, 2014 at 1:05 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Wednesday 09 July 2014 12:26:22 Geert Uytterhoeven wrote:
>> As typically a shmobile SoC has less DMA channels than devices that can use
>> DMA, we may want to prioritize access to the DMA channels in the future.
>> This means that dmaengine_prep_slave_sg() may start failing arbitrarily.
>>
>> Handle dmaengine_prep_slave_sg() failures gracefully by falling back to
>> PIO.
>
> Just a random thought, do you think there would be performance-sensitive cases
> where failing the transfer completely would be better than using PIO ?

QSPI Flash reads gain most from DMA.

However, failing transfers (and thus the whole SPI message, which typically
consists of multiple transfers) means we'll have to retry the message later.
This could be done by the SPI driver, the SPI subsystem, or the upper layer.
E.g. m25p80 and mtd do not retry SPI FLASH reads and writes.

>> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>
> -EAGAIN might not be the best error code to return in this case, as it would
> imply that the caller should just call rspi_dma_transfer() again. On the other
> hand I don't see another error code that would be a perfect match, so

I followed the exact same reasoning to arrive at -EAGAIN...

BTW, calling rspi_dma_transfer() again is an option ;-)

> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Thanks!

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
