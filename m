From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V2 6/8] spi: rspi: Add support for missing SPCR2 register
Date: Sun, 19 Jan 2014 12:39:29 +0100
Message-ID: <CAMuHMdUG3m0H8Rgfne7XDUYXd5Uxq69jbSzAAEuWEyoNTZazdA@mail.gmail.com>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
	<1389522464-1569-7-git-send-email-geert@linux-m68k.org>
	<52D3DDDB.309@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D3DDDB.309-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 13, 2014 at 1:36 PM, Sergei Shtylyov
<sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org> wrote:
> On 12-01-2014 14:27, Geert Uytterhoeven wrote:
>> Add support for RSPI variants lacking the RSPI Control Register 2, based on
>> the SDK reference code. This is needed for RZ/A1H.
>
>> The availability of this register is passed using platform data, defaulting
>> to true for legacy RSPI. QSPI never has this register.
>
>> If the register is not available, it should not be touched.
>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>
>    I believe such things should be done via different platform device IDs
> instead, not platform data.

Thanks! The more I think about it, and the more I'm refactoring the driver,
the more I agree with you...

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
