From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: Add a timeout when waiting for transfers
Date: Fri, 31 Jan 2014 13:00:31 +0100
Message-ID: <CAMuHMdXLe+Ot5ntOtUC2Qynid4mv1h+UoitJuDW=Z-iyRKXCdg@mail.gmail.com>
References: <1391121536-10937-1-git-send-email-broonie@kernel.org>
	<CAMuHMdUVmL5Zq8AYPVmUyWEBTzokSMV-Xg4uFzpxr7c2uSmU7g@mail.gmail.com>
	<20140131114935.GA22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140131114935.GA22609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 31, 2014 at 12:49 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jan 31, 2014 at 08:49:45AM +0100, Geert Uytterhoeven wrote:
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -829,6 +829,9 @@ void spi_finalize_current_message(struct spi_master *master)
>>           queue_kthread_work(&master->kworker, &master->pump_messages);
>>           spin_unlock_irqrestore(&master->queue_lock, flags);
>>
>> +         if (!mesg)
>> +                 return NULL;
>> +
>
> Note that this is for transfers, not for messages, and we don't change
> the completion path for the message here so I'm not sure why the message
> would be affected?  That said there is definitely an issue here - we
> should probably be adding some sort of error teardown callback to try to
> stop the hardware if we do hit a timeout.

RIght. Sorry, I mixed them up.

One other thing: I haven't tried your patch yet, but I'm afraid the 10 ms
may be too small.

E.g. with PIO-based RSPI I don't get more than 2 Mbps, even though
spi-max-frequency = <30000000>, due to the PIO and interrupt overhead.
Hence a 1 MiB read would take ca. 4s, while your timeout would be 300 ms.

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
