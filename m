From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v4 13/14] spi: rspi: Add DT support
Date: Fri, 24 Jan 2014 14:05:46 +0100
Message-ID: <CAMuHMdWFzJ-PfFQz-mgbtYdV9d_8=mr+F51=1Jhx0K-HrGrwFg@mail.gmail.com>
References: <1390553044-11860-1-git-send-email-geert@linux-m68k.org>
	<1390553044-11860-14-git-send-email-geert@linux-m68k.org>
	<20140124093349.GK15586@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140124093349.GK15586-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 24, 2014 at 10:33 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> +- interrupts       : 1 interrupt for RSPI cores using a single multiplexed
>> +                  interrupt,
>> +                  3 interrupts (SPEI, SPRI, SPTI) for RSPI cores using
>> +                  separate interrupts.
>> +- interrupt-names  : Array of strings associated with the interrupt numbers:
>> +                  "error" for SPEI, "rx" for SPRI, and "tx" for SPTI.
>> +                  For RSPI cores using a single multiplexed interrupt, the
>> +                  name "mux" is optional.
>
> Rather than defining the set of interrupts twice, it would be nice to
> have interrupts defined in terms of interrupt-names:
>
> - interrupts: a list of interrupt-specifiers, one for each entry in
>   interrupt-names. If interrupt-names is not present, an interrupt
>   specifier for a single muxed interrupt.
>
> - interrupt-names: A list of interrupt names. Should contain (if
>   present):
>   * "error" for SPEI
>   * "rx" for SPRI
>   * "tx" to SPTI
>   * "mux" for a single muxed interrupt

Yes, that sounds much better, thank you.
Will update.

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
