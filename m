From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device
 is created
Date: Mon, 24 Jul 2017 16:14:11 +0300
Message-ID: <20170724131411.GZ629@lahna.fi.intel.com>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75VfL8RK57sxKH4UVQ0-u9gGnJ-DaqOKYcq7DrdsFhpecwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfL8RK57sxKH4UVQ0-u9gGnJ-DaqOKYcq7DrdsFhpecwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jul 24, 2017 at 04:03:31PM +0300, Andy Shevchenko wrote:
> +Cc: Mika (for real this time)
> 
> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:
> > From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
> >
> > Avoid hogging chip select GPIOs just because they are listed for the
> > master. They might be mulitplexed and, if no slave device is attached,
> > used for different purposes. Moreover, this strategy avoids having to
> > allocate a cs_gpiods structure.
> >
> > Tested on the IOT2000 where the second SPI bus is connected to an
> > Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
> > usage.
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-pxa2xx.c | 59 +++++++++++++++++-------------------------------
> >  1 file changed, 21 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > index 38d053682892..be991266a6ce 100644
> > --- a/drivers/spi/spi-pxa2xx.c
> > +++ b/drivers/spi/spi-pxa2xx.c
> > @@ -1213,21 +1213,33 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
> >                     struct pxa2xx_spi_chip *chip_info)
> >  {
> >         struct driver_data *drv_data = spi_master_get_devdata(spi->master);
> > +       struct device *pdev = &drv_data->pdev->dev;
> > +       struct gpio_desc *gpiod;
> >         int err = 0;
> > +       int count;
> >
> >         if (chip == NULL)
> >                 return 0;
> >
> > -       if (drv_data->cs_gpiods) {
> > -               struct gpio_desc *gpiod;
> > +       count = gpiod_count(pdev, "cs");
> > +       if (count > 0) {
> > +               if (spi->chip_select >= count)
> > +                       return -EINVAL;
> > +
> > +               gpiod = gpiod_get_index(pdev, "cs", spi->chip_select,
> > +                                       GPIOD_OUT_HIGH);

This will not work if setup() gets called multiple times (and it will in
some cases) because we already have the GPIO descriptor from the
previous call to setup().

At least you should check if we already have the GPIO requested.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
