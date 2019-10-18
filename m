From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
Date: Fri, 18 Oct 2019 14:14:41 +0300
Message-ID: <CAHp75VeLyTi=gqfNr-=Tg36yQs_fYG__iQAxAEKdks0mqsTbug@mail.gmail.com>
References: <20191017025058.31528-1-hslester96@gmail.com> <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
 <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 18, 2019 at 1:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> > >
> > > pxa2xx_spi_init_pdata misses checks for devm_clk_get and
> > > platform_get_irq.
> > > Add checks for them to fix the bugs.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  drivers/spi/spi-pxa2xx.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > > index bb6a14d1ab0f..2e73d75a6ac5 100644
> > > --- a/drivers/spi/spi-pxa2xx.c
> > > +++ b/drivers/spi/spi-pxa2xx.c
> > > @@ -1565,7 +1565,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
> > >  #endif
> > >
> > >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > > +       if (IS_ERR(ssp->clk))
> > > +               return NULL;
> > > +
> > >         ssp->irq = platform_get_irq(pdev, 0);
> > > +       if (ssp->irq < 0)
> > > +               return NULL;
> >
> > I'm not sure they are mandatory for all platforms.
> > To be on the safe side, you simple need to add _optional() to the both
> > call along with above change.
> >
>
> As I know, this is the only one in spi which does not have a check for
> devm_clk_get.

For some it still may be optional. That's why better to check it and
mention in the commit message.

> Even if add _optional(), they still may return errors and need security checks.

Of course, see "along with" in my previous comment.

-- 
With Best Regards,
Andy Shevchenko
