From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: allocate spi_board_info entries one by one
Date: Tue, 28 Feb 2017 21:15:12 +0100
Message-ID: <CAMuHMdVTxDLnnVE0S7VfGKNB1EPnKv_7B8rgA2c+Ub7KgZHn1A@mail.gmail.com>
References: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
 <20170228041857.13292-3-dmitry.torokhov@gmail.com> <20170228091650.eiypppxblfhh33pb@sirena.org.uk>
 <20170228182417.GA20776@dtor-ws> <20170228185455.mdmvuc232chlveve@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170228185455.mdmvuc232chlveve-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 28, 2017 at 7:54 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Feb 28, 2017 at 10:24:17AM -0800, Dmitry Torokhov wrote:
>> On Tue, Feb 28, 2017 at 09:16:50AM +0000, Mark Brown wrote:
>> > On Mon, Feb 27, 2017 at 08:18:56PM -0800, Dmitry Torokhov wrote:
>> > > Lists of spi_board_info entries registered with spi_register_board_info()
>> > > can be quite long; instead of forcing memory allocator find contagious
>
>> > Do you have numbers on that?
>
>> Hm, so the largest array seems to be in
>> arch/blackfin/mach-bf537/boards/stamp.c at max of 43 entries. The new
>> board info is ether 60 or 72 bytes, so we get 2 or 3K table. Not above
>> page, but still could be packed I think.
>
> Oh wow, that's impressively large.  Still not sure the optimization is
> particularly worth it though, it's small change in the grand scheme of
> things.  OTOH it's a small change.

Given this is done during early boot, what's the probability of not having
sufficient contiguous memory?

>> If we decide that we want to keep single chunk I'll just change the
>> allocation to kcalloc. Let me know.
>
> I'd be inclined to do that because it requires less thinking about the
> value of what should be a very small optimization either way but
> whatever :)

Tada...

commit f9bdb7fdd2cac17bdc9c344b6036e6939fa087cd
Author: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date:   Fri Jan 13 12:28:04 2017 +0100

    spi: Use kcalloc() in spi_register_board_info()

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
