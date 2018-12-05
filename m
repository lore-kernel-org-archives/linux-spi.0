From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
Date: Wed, 5 Dec 2018 14:31:50 +0100
Message-ID: <CAMuHMdXF9PtWgjUKaTomkr4X_00HARQ_1uZPROWUr910HLVMCA@mail.gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com> <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com> <CAMuHMdV-Ca5sderSKmdbtovKrd-Z7piwVZbwDtB6vVXPa8Q5AA@mail.gmail.com>
 <8e667f91-70bd-795c-094f-23c919c3802c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: masonccyang@mxic.com.tw,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e667f91-70bd-795c-094f-23c919c3802c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Marek,

On Wed, Dec 5, 2018 at 2:25 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 12/05/2018 02:15 PM, Geert Uytterhoeven wrote:
> > On Wed, Dec 5, 2018 at 1:57 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On 12/05/2018 08:44 AM, masonccyang@mxic.com.tw wrote:
> >>>> "Marek Vasut" <marek.vasut@gmail.com>
> >>>> 2018/12/05 上午 10:04
> >>>> On 12/03/2018 10:18 AM, Mason Yang wrote:
> >>>>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> >>>>>
> >>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >
> >>>>> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> >>>>> +{
> >>>>> +   /*
> >>>>> +    * NOTE: The 0x260 are undocumented bits, but they must be set.
> >>>>> +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> >>>>> +    *   0x0 : the delay is biggest,
> >>>>> +    *   0x1 : the delay is 2nd biggest,
> >>>>> +    *   0x3 or 0x6 is a recommended value.
> >>>>> +    */
> >>>>
> >>>> Doesn't this vary by SoC ? I think H3 ES1.0 had different value here,
> >>>> but I might be wrong.
> >>>
> >>> I check the Renesas bare-metal code, mini_monitor v4.01.
> >>> It set 0x03 or 0x0 and I test them w/ 0x0, 0x3 and 0x6 are all OK.
> >>
> >> Shouldn't this somehow use the soc_device_match() then and configure it
> >> accordingly for various chips ? Like eg. the r8a7795-cpg-mssr driver does.
> >
> > Please don't use soc_device_match() for per-SoC configuration, if
> > you already have of_device_id.data.
>
> I mean, the value is different on H3 ES1 and ES2 iirc, that's what
> soc_device_match() is for, right ?

Oh, it differs between revisions, too?
Yes, in that case you need soc_device_match().

> > BTW, this drivers support r8a7795 only (for now), as per the compatible
> > value.
>
> 77995

Sorry, typo on my side. So H3 is not yet supported ;-)

> >>>>> +#ifdef CONFIG_RESET_CONTROLLER
> >>>>
> >>>> Just make the driver depend on reset controller.
> >>>
> >>> ?
> >>> please refer to
> >>> https://github.com/torvalds/linux/blob/master/drivers/clk/renesas/renesas-cpg-mssr.c
> >>>
> >>> line 124 ~ 126
> >>
> >> This seems like a stopgap measure for systems which do not have a reset
> >> api compatible controller. Geert ?
> >
> > So far CONFIG_RESET_CONTROLLER is optional.
>
> My understanding is that for this IP, it can well be mandatory, since
> all the chips have a reset wired to the IP internally.

That's what I was trying to find out, hence my question about the purpose.

> >>>>> +         regmap_write(rpc->regmap, RPC_SMWDR0,
> >>>>> +                 *(u32 *)(tx_buf + pos));
> >>>>
> >>>> *(u32 *) cast is probably not needed , fix casts globally.
> >>>
> >>> It must have it!
> >>
> >> Why ?
> >
> > Else you get a compiler warning, as tx_bug is void *.
>
> Don't you need some get_unaligned() in that case ? txbuf+pos can well be
> unaligned if it's void * .

True, but IIRC, arm64 can handle that, right?
Don't know about SuperH.

> >>>>> +#ifdef CONFIG_PM_SLEEP
> >>>>> +static int rpc_spi_suspend(struct device *dev)
> >>>>> +{
> >>>>> +   struct platform_device *pdev = to_platform_device(dev);
> >>>>> +   struct spi_master *master = platform_get_drvdata(pdev);
> >>>>> +
> >>>>> +   return spi_master_suspend(master);
> >>>>
> >>>> Won't the SPI NOR lose state across suspend ? Is that a problem ?
> >>>
> >>> I don't think so.
> >>> Because when the device is not in operation and CS# is high,
> >>> it is put in stand-by mode.
> >>
> >> Is the power to the SPI NOR retained ?
> >
> > Not if PSCI system suspend turns of power to the SoC.
>
> And is that a problem ?

Good question!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
