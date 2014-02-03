From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: Add a timeout when waiting for transfers
Date: Mon, 3 Feb 2014 09:55:33 +0100
Message-ID: <CAMuHMdXgDAPy4aezxULQsjiRUfyE3F2_NSjuWhBiy119DSXR5A@mail.gmail.com>
References: <1391121536-10937-1-git-send-email-broonie@kernel.org>
	<CAMuHMdUVmL5Zq8AYPVmUyWEBTzokSMV-Xg4uFzpxr7c2uSmU7g@mail.gmail.com>
	<20140131114935.GA22609@sirena.org.uk>
	<CAMuHMdXLe+Ot5ntOtUC2Qynid4mv1h+UoitJuDW=Z-iyRKXCdg@mail.gmail.com>
	<20140131122617.GC22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140131122617.GC22609-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Jan 31, 2014 at 1:26 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jan 31, 2014 at 01:00:31PM +0100, Geert Uytterhoeven wrote:
>> One other thing: I haven't tried your patch yet, but I'm afraid the 10 ms
>> may be too small.
>
>> E.g. with PIO-based RSPI I don't get more than 2 Mbps, even though
>> spi-max-frequency = <30000000>, due to the PIO and interrupt overhead.
>> Hence a 1 MiB read would take ca. 4s, while your timeout would be 300 ms.
>
> Hrm, I wouldn't have expected something doing PIO in more than one burst
> to be letting the transfer run in the background.  Though I suppose that
> might make sense in some situations...

While I've been thinking about moving more code to the interrupt handler,
the current RSPI transfer_one() is indeed still synchronous, so the timeout
doesn't apply yet.

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
