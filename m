From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] spi: dw: Add basic runtime PM support
Date: Tue, 17 Sep 2019 08:36:01 +0200
Message-ID: <CAMuHMdX9ZdLMmpHGqm2wmajwEDjuTY7s19PqwQ3kaVu8WLLykA@mail.gmail.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdUnzmYEcp0B5MG7itB1JHtNL7Stj9S2EFB0U0y_naQVBQ@mail.gmail.com> <TY2PR01MB2924AA1B012C2D305EE5C9B7DF8C0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY2PR01MB2924AA1B012C2D305EE5C9B7DF8C0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Gareth,

On Mon, Sep 16, 2019 at 6:14 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> > On Mon, Sep 16, 2019 at 15:36 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > On Fri, Sep 13, 2019 at 2:13 PM Gareth Williams
> > <gareth.williams.jx@renesas.com> wrote:
> > > From: Phil Edworthy <phil.edworthy@renesas.com>
> > >
> > > Enable runtime PM so that the clock used to access the registers in
> > > the peripheral is turned on using a clock domain.
> > >
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/spi/spi-dw.c
> > > +++ b/drivers/spi/spi-dw.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/highmem.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/spi/spi.h>
> > >
> > > @@ -497,6 +498,9 @@ int dw_spi_add_host(struct device *dev, struct
> > dw_spi *dws)
> > >         if (dws->set_cs)
> > >                 master->set_cs = dws->set_cs;
> > >
> > > +       pm_runtime_enable(dev);
> > > +       pm_runtime_get_sync(dev);
> >
> > The second line keeps the device powered all the time.
> > What about setting spi_controller.auto_runtime_pm = true, so the SPI code
> > can manage its Runtime PM status?
>
> That makes sense and works on target, I will change this for V2.

> > I assume this will be called from drivers/spi/spi-dw-mmio.c, which already
> > enables the clock explicitly all the timer?
> Yes, spi-dw-mmio.c already enables the bus clock, however we want to use clock
>
> domain to enable the clock and not explicitly provide pclk in the dts. If there are
> no other uses of that pclk, we can remove that later on.

IC, that's useful sideband information.

"pclk" is indeed an optional clock.
"ssi_clk" must be first.

However, to make use of the clock domain code, you still have to list "pclk"
in DT, but use a different name, to avoid spi-dw-mmio.c enabling it all the
time? Or do you plan to modify spi-dw-mmio.c for that?
In the former case, you should document that in your bindings, which
currently build on top of snps,dw-apb-ssi.txt, thus include "pclk".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
