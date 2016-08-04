From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Date: Thu, 4 Aug 2016 15:05:16 +0200
Message-ID: <CAMuHMdURxKP_U649yWPtmyQBh+zasUBDYcK5YKD0eL4MuXVs0A@mail.gmail.com>
References: <cover.1469686300.git.dalias@libc.org> <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk> <20160728194045.GK15995@brightrain.aerifal.cx>
 <20160728195125.GN11806@sirena.org.uk> <20160730033441.GO15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160730033441.GO15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Rich,

On Sat, Jul 30, 2016 at 5:34 AM, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org> wrote:
> On Thu, Jul 28, 2016 at 08:51:25PM +0100, Mark Brown wrote:
>> On Thu, Jul 28, 2016 at 03:40:45PM -0400, Rich Felker wrote:
>> > On Thu, Jul 28, 2016 at 08:11:53PM +0100, Mark Brown wrote:
>> > > Why are you not using the clock API for this?  Just require a clock and
>> > > use clk_get_rate() to find out what rate it is.
>>
>> > I thought about that but I'm not familiar with it. I can try to figure
>> > it out quickly and test that approach; don't see any reason it
>> > shouldn't work. Would you insist on having full support for
>> > enabling/disabling the clk when it's in use, or would you be happy
>> > with treating it as a fixed clock that's always-on for now and
>> > possibly extending it with more functionality later if there's ever
>> > hardware where that's relevant/helpful?
>>
>> It's fine to just enable it at startup and leave it on, though the
>> runtime PM ops are trivial and you can set auto_runtime_pm to have the
>> core do the gets and puts.
>
> I was able to get it working via the clk api and I'll include support
> for this in the next version of the patch, but to actually use it
> depends on changing arch/sh to use the common clk framework; otherwise
> there's no way to provide a suitable clk in the DT and have
> [devm_]clk_get actually pick it up. Should I keep around the option of
> using clock-frequency too? That would be most convenient.
>
> I do have a pending patch from Sato-san to switch arch/sh over to CCF
> but it's part of a series and I don't think it's ready to merge. I may
> be able to merge just a minimal, safe subset that won't break legacy
> non-DT configurations, though.

I think you can use non-CCF clocks with DT, if you register them first.
Cfr. the clk_names[] array and shmobile_clk_workaround() function in
v3.18:arch/arm/mach-shmobile/board-koelsch-reference.c and
v3.18:arch/arm/mach-shmobile/clock.c

Or was that the other way around?

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
