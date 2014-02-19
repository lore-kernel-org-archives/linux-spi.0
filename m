From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: New bug?
Date: Wed, 19 Feb 2014 08:45:29 +0100
Message-ID: <CAMuHMdUTVAey=9rmU0xRomEomBk1erMoH-jnu8Szg=OcZWbLog@mail.gmail.com>
References: <1392795133.984411895@f316.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392795133.984411895-P0ORxJMC3jVsdVUOrk1QfQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 19, 2014 at 8:32 AM, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org> wrote:
> During testing functions transfer_one(), stumbled upon an error.
> I'm using kernel 3.13, so I had to apply a patch from upstream
> (spi: core: Fix transfer failure when master->transfer_one returns positive value).
> After applying all becomes normal with probing, but where did the error
> "Unable to handle kernel NULL pointer dereference" ?
> Did someone have similar bugs?
>
> Thanks.
>
> spi_master spi0: failed to transfer one message from queue: 1
> 74x164 spi0.1: Failed writing: 1
> 74x164: probe of spi0.1 failed with error 1
> Unable to handle kernel NULL pointer dereference at virtual address 00000020
> CAN device driver interface
> pgd = c0024000
> [00000020] *pgd=00000000
> Internal error: Oops: 63c11805 [#1] PREEMPT ARM
> CPU: 0 PID: 22 Comm: spi0 Not tainted 3.13.3 #1
> task: c396b260 ti: c396e000 task.ti: c396e000
> PC is at spi_pump_messages+0x150/0x194

Have you applied other patches from upstream?

E.g. e120cc0dcf2880a4c5c0a6cb27b655600a1cfa1d introduced a NULL
pointer dereference, with got fixed by
1f802f8249a0da536877842c43c7204064c4de8b.

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
