From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: spi-controller: Fix
 #address-cells for slave mode
Date: Wed, 4 Mar 2020 13:50:41 +0100
Message-ID: <CAMuHMdUBTVZGNtdc0dhUz5d+P2_Fr89MvBCz8=9oQK1EOi7s2w@mail.gmail.com>
References: <20200303094522.23180-1-geert+renesas@glider.be>
 <20200303094522.23180-2-geert+renesas@glider.be> <CAL_JsqL+9Tcqm_bsorRwqvWZyJXAZmJhXb=EmJ+nZ44kCFp6Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP"
        <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqL+9Tcqm_bsorRwqvWZyJXAZmJhXb=EmJ+nZ44kCFp6Kg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Rob,

On Tue, Mar 3, 2020 at 10:05 PM Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Mar 3, 2020 at 3:45 AM Geert Uytterhoeven
> <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:
> > Currently, the DT bindings for an SPI controller specify that
> > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > controller in master mode only.  When running in SPI slave mode,
> > "#address-cells" should be zero.
> >
> > Fix this making the value of "#address-cells" dependent on the presence
> > of "spi-slave".
> >
> > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> > ---
> > v2:
> >   - Use "enum: [0, 1]" instead of min/max limit,
> >   - use "- spi-slave" instead of "[ spi-slave ]".
> >
> > As of dtc commit 403cc79f06a135ae ("checks: Update SPI bus check for
> > 'spi-slave'") and Linux commit c2e7075ca8303631 ("scripts/dtc: Update to
> > upstream version v1.4.7-57-gf267e674d145"), dtc knows about SPI slave.
> >
> > However, when using "#address-cells = <0>" with W=1:
> >
> >     Warning (avoid_unnecessary_addr_size): /soc/spi@e6e10000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> What was the point in having #address-cells in the first place for
> slaves?

I don't know, commit a8830cb19cfea04e ("spi: Document DT bindings for
SPI controllers in slave mode") doesn't require any #address-cells for
slave mode.

Perhaps because node_addr_cells() in dtc defaults to 2?
Or because of_bus_n_addr_cells() walks up the parent chain and thus
defaults to the first found parent value?

> Seems like we should make it mutually exclusive with 'spi-slave'.

Sounds like a good idea. How to express that in yaml?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
