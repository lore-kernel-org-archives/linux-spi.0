From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 4/4] mtd: m25p80: Enable Dual SPI read transfers for
 s25fl256s1 and s25fl512s
Date: Tue, 21 Jan 2014 16:58:59 +0100
Message-ID: <CAMuHMdVMDO9nKQPgNwz47H2mK6kKreNYiyn-AFOB2KryRpSgoA@mail.gmail.com>
References: <1390309159-19643-1-git-send-email-geert@linux-m68k.org>
	<1390309159-19643-5-git-send-email-geert@linux-m68k.org>
	<201401211642.55461.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201401211642.55461.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 21, 2014 at 4:42 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> Spansion s25fl256s1 and s25fl512s support Dual SPI transfers, hence set the
>> M25P80_DUAL_READ flag.

> Why don't you lump this together with 1/4 ? :)

Because I don't want to delay Quad support for s25fl512s by bike-shedding
about the need for Dual support.

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
