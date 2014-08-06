From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Remove unused definitions
Date: Wed, 6 Aug 2014 20:50:15 +0200
Message-ID: <CAMuHMdVJQd0Mb8aXbd9iqkabzKdw9WSR791LxqUoVEJ1g1kaHA@mail.gmail.com>
References: <1407347597-2168-1-git-send-email-xerofoiffy@gmail.com>
	<17153.1407349640@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Richard Weinberger <richard.weinberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Valdis Kletnieks <Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17153.1407349640-+bZmOdGhbsPr6rcHtW+onFJE71vCis6O@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 6, 2014 at 8:27 PM,  <Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org> wrote:
> On Wed, 06 Aug 2014 13:53:17 -0400, Nick Krause said:
>> Remove unused definition which cause the following warnings
>>
>> drivers/spi/spi-omap-100k.c:73:0: warning: "WRITE" redefined [enabled by default]
>> include/linux/fs.h:193:0: note: this is the location of the previous definition
>> drivers/spi/spi-omap-100k.c:74:0: warning: "READ" redefined [enabled by default]
>> include/linux/fs.h:192:0: note: this is the location of the previous definition
>
>> -#define WRITE 0
>> -#define READ  1
>
> NAK.  Full stop.  These are potentially used in an inner macro someplace, and by
> removing these, the conflicting values from fs.h will be used instead.
>
> #define READ                    0
> #define WRITE                   RW_MASK
>
> So if there *is* a use in an inner macro, you just screwed the pooch
> and introduced a bug in this "clean up" - somebody will be expecting to see
> a 0 for a READ, and will receive a 1 instead.  This can't end well.
>
> Nick - how *exactly* did you identify that these are in fact not used?
> Given your history of submitting poorly researched patches, you're going to
> have to justify the "unused" better than the handwaving you've done here.

Just looking into this...

It seems READ and WRITE are not used at all in this file.

To be 100% sure, I tried to find with which kernel config this warning shows up.
It doesn't happen for omap1_defconfig with CONFIG_SPI_OMAP_100K,
which was the most likely culprit.

It does happen with sparc/sparc64 allmodconfig. However, changing or
removing the READ and WRITE definitions in drivers/spi/spi-omap-100k.c
doesn't have any influence on the preprocessed source files
("make drivers/spi/spi-omap-100k.i", modulo line number changes),
for both omap1 and sparc builds.

(Nick: I believe the above is what people really want to see)

So I conclude they are really not used, and they can be safely removed.

Acked-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

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
