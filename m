From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]" to
 the spi tree
Date: Mon, 25 Sep 2017 21:15:53 +0200
Message-ID: <CAMuHMdUv-5COUuzJOWx=BTb5oJ7tFOi1BpocuJ7+VuCZ3fEuPg@mail.gmail.com>
References: <1506329660-4064-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <20170925161637.D7471440058@finisterre.ee.mobilebroadband>
 <CAMuHMdVsRwW+10ERyTJAa8XhhkPMn4ruymUwPKot+kmczBwbcA@mail.gmail.com> <20170925184545.5k4nke27rgud3uwp@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170925184545.5k4nke27rgud3uwp-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Mon, Sep 25, 2017 at 8:45 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Sep 25, 2017 at 07:48:44PM +0200, Geert Uytterhoeven wrote:
>> Please drop this patch, as there's no need to add explicit matching for these
>> compatible values. The family-specific compatible values (which the driver
>> already matches against) are sufficient.
>
> While the patch is not needed if people list the fallback property it
> also does no harm and provides a marginal documentation benefit in
> saying that someone has considered if any special handling is useful and
> decided that it isn't.

All true.

My rebuttal is threefold:
  1. Listing the fallback property is mandatory for new SoCs. We only keep
     the per-SoC compatible values in the driver for older SoCs that predate
     the introduction of fallback properties.
  2. Some harm is involved, in the form of increased kernel image size.
  3. When updating DT bindings for new SoCs, we usually add "No driver
     update is needed" to the patch description to clarify. Unfortunately
     that was missed here.

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
