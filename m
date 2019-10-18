From: Chuhong Yuan <hslester96@gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
Date: Fri, 18 Oct 2019 18:39:08 +0800
Message-ID: <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
References: <20191017025058.31528-1-hslester96@gmail.com>
 <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > pxa2xx_spi_init_pdata misses checks for devm_clk_get and
> > platform_get_irq.
> > Add checks for them to fix the bugs.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/spi/spi-pxa2xx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > index bb6a14d1ab0f..2e73d75a6ac5 100644
> > --- a/drivers/spi/spi-pxa2xx.c
> > +++ b/drivers/spi/spi-pxa2xx.c
> > @@ -1565,7 +1565,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
> >  #endif
> >
> >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(ssp->clk))
> > +               return NULL;
> > +
> >         ssp->irq = platform_get_irq(pdev, 0);
> > +       if (ssp->irq < 0)
> > +               return NULL;
>
> I'm not sure they are mandatory for all platforms.
> To be on the safe side, you simple need to add _optional() to the both
> call along with above change.
>

As I know, this is the only one in spi which does not have a check for
devm_clk_get.
Even if add _optional(), they still may return errors and need security checks.

> --
> With Best Regards,
> Andy Shevchenko
