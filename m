From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7778/r8a7779 dtsi: Improve and
 correct HSPI bindings
Date: Thu, 13 Feb 2014 09:31:54 +0100
Message-ID: <CAMuHMdX9H5Nvvwy4J=UYE=82nx1nm+v5be2JHLWrUp2xkCO=Hg@mail.gmail.com>
References: <1392109008-29941-1-git-send-email-geert@linux-m68k.org>
	<20140213055600.GF17183@verge.net.au>
	<87zjlvbi7l.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zjlvbi7l.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Morimoto-san,

On Thu, Feb 13, 2014 at 8:11 AM, Kuninori Morimoto
<kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> could you test this series as Geert does not have access to a bockw board?
>>
>> On Tue, Feb 11, 2014 at 09:56:47AM +0100, Geert Uytterhoeven wrote:
>> > From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>> >
>> > Binding documentation:
>> >   - Add future-proof "renesas,hspi-<soctype>" compatible values,
>> >   - Add "interrupt-parent", "#address-cells" and "#size-cells" properties,
>> >   - Add reference to pinctrl documentation,
>> >   - Add example bindings.
>> >
>> > r8a7778 and r8a7779 dtsi:
>> >   - Add "renesas,hspi-r8a7778" resp. "renesas,hspi-r8a7779" compatible
>> >     values,
>> >   - Correct reference to parent interrupt controller
>> >     (use "interrupt-parent" instead of "interrupt-controller"),
>> >   - Add missing "#address-cells" and "#size-cells" properties, which are
>> >     needed when populating the SPI buses.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>> > Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> > ---
>
> I tested this patch, and it works well.
> But there are some notes
>
> 1) m25p80 driver DT support seems strange ??
>
>    ${LINUX}/Documentation/devicetree/bindings/mtd/m25p80.txt
>    has explain about DT of m25p80 driver, but,
>    ${LINUX}/drivers/mtd/devices/m25p80.c
>    doesn't have driver :: of_match_table.
>    but, it is using of_property_read_bool() on probe.
>    Is it out-of-tree support ?? I'm not sure,
>    anyway, m25p80 driver didn't probe.

It probes based on the values in m25p_ids[].

See drivers/of/base.c:of_modalias_node():

 * Based on the value of the compatible property, this routine will attempt
 * to choose an appropriate modalias value for a particular device tree node.
 * It does this by stripping the manufacturer prefix (as delimited by a ',')
 * from the first entry in the compatible list property.

Which is used by drivers/spi/spi.c:of_register_spi_devices().

>    So, I quick-hacked this issue in my local environment.

Was there anything else you needed to do, besides adding support for
s25fl008k to m25p80.c?

> 2) it needs Geert's this patch
>
>    Subject: [PATCH] mtd: m25p80: add support for the Spansion s25fl008k chip
>    Date:        Tue, 11 Feb 2014 09:51:18 +0100
>
>    Kernel will hung-up without this patch

Hang up? Not just ignoring the device?

> For HSPI / BockW point of view
>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

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
