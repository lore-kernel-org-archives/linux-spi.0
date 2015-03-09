From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Mon, 09 Mar 2015 10:20:07 +0200
Message-ID: <1425889207.2440.9.camel@mm-sol.com>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
	 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
	 <54F9F31A.3050501@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54F9F31A.3050501-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi Stephen,

> On Mar 6, 2015, at 8:34 PM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote=
:
> On 03/06/15 07:26, Ivan T. Ivanov wrote:
> > Ensure that driver is owner of the GPIO's used for CS signals.
> Why? What happens if we don=E2=80=99t?

We can have wrong DT configuration, which could reconfigure
GPIO=E2=80=99s without any warning or error.

> > Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > ---
> > drivers/spi/spi-qup.c | 17 ++++++++++++++++-
> > 1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> > index 2b2c359..a07ba46 100644
> > --- a/drivers/spi/spi-qup.c
> > +++ b/drivers/spi/spi-qup.c
> > @@ -14,11 +14,13 @@
> > #include <linux/clk.h>
> > #include <linux/delay.h>
> > #include <linux/err.h>
> > +#include <linux/gpio.h>
> > #include <linux/interrupt.h>
> > #include <linux/io.h>
> > #include <linux/list.h>
> > #include <linux/module.h>
> > #include <linux/of.h>
> > +#include <linux/of_gpio.h>
> > #include <linux/platform_device.h>
> > #include <linux/pm_runtime.h>
> > #include <linux/spi/spi.h>
> > @@ -499,7 +501,7 @@ static int spi_qup_probe(struct platform_device=
 *pdev)
> >         struct device *dev;
> >         void __iomem *base;
> >         u32 max_freq, iomode, num_cs;
> > -       int ret, irq, size;
> > +       int ret, irq, size, cs, cs_gpio;
> >=20
> >         dev =3D &pdev->dev;
> >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -556,6 +558,19 @@ static int spi_qup_probe(struct platform_devic=
e *pdev)
> >         else
> >                 master->num_chipselect =3D num_cs;
> >=20
> > +       for (cs =3D 0; cs < master->num_chipselect; cs++) {
> > +               cs_gpio =3D of_get_named_gpio(dev->of_node, "cs-gpi=
os", cs);
> > +
> > +               if (!gpio_is_valid(cs_gpio))
> > +                       continue;
> > +
> > +               ret =3D devm_gpio_request(&pdev->dev, cs_gpio, "spi=
-qup-cs");
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "can't get cs gpios\n")=
;
> > +                       goto error;
> > +               }
> > +       }
> > +
> >         master->bus_num =3D pdev->id;
> Is this related to [1]? In that case I was just relying on DT/pinctrl=
 to
> properly request the gpios.

But the DT/pinctrl did not request GPIO=E2=80=99s, it just configure th=
em.
=46or some reason we are ending without any pinctrl_map of type=20
PIN_MAP_TYPE_MUX_GROUP, which is used for pin reservation.=20

> [1] https://lkml.org/lkml/2014/5/27/784

I have missed this one. I have considered same approach, but abandoned
it, because of issues related to double request reasons mentioned by Ma=
rk.

Regards,
Ivan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
