From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Tue, 10 Mar 2015 10:31:38 +0200
Message-ID: <1425976298.2440.26.camel@mm-sol.com>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
		 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
		 <54F9F31A.3050501@codeaurora.org> <1425889207.2440.9.camel@mm-sol.com>
	 <54FDEC36.5080403@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54FDEC36.5080403-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,=20

On Mon, 2015-03-09 at 11:53 -0700, Stephen Boyd wrote:
> On 03/09/15 01:20, Ivan T. Ivanov wrote:
> > Hi Stephen,
> >=20
> > > On Mar 6, 2015, at 8:34 PM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> w=
rote:
> > > On 03/06/15 07:26, Ivan T. Ivanov wrote:
> > > > Ensure that driver is owner of the GPIO's used for CS signals.
> > > Why? What happens if we don=E2=80=99t?
> > We can have wrong DT configuration, which could reconfigure
> > GPIO=E2=80=99s without any warning or error.
>=20
> Ouch. That sounds bad. Can you please add this information to the com=
mit
> text?

Sure.

> > > > +       for (cs =3D 0; cs < master->num_chipselect; cs++) {
> > > > +               cs_gpio =3D of_get_named_gpio(dev->of_node, "cs=
-gpios", cs);
> > > > +
> > > > +               if (!gpio_is_valid(cs_gpio))
> > > > +                       continue;
> > > > +
> > > > +               ret =3D devm_gpio_request(&pdev->dev, cs_gpio, =
"spi-qup-cs");
> > > > +               if (ret) {
> > > > +                       dev_err(&pdev->dev, "can't get cs gpios=
\n");
> > > > +                       goto error;
> > > > +               }
> > > > +       }
> > > > +
> > > >         master->bus_num =3D pdev->id;
> > > Is this related to [1]? In that case I was just relying on DT/pin=
ctrl to
> > > properly request the gpios.
> > But the DT/pinctrl did not request GPIO=E2=80=99s, it just configur=
e them.
> > For some reason we are ending without any pinctrl_map of type
> > PIN_MAP_TYPE_MUX_GROUP, which is used for pin reservation.
> >=20
>=20
> Ah ok. I seem to be misremembering the details.

:-) I still have version of downstream "msm-pinctrl" driver,=20
which create PIN_MAP_TYPE_MUX_GROUP maps during node to map
parsing.=20

>=20
> Can you please use the gpiod interfaces here (devm_gpiod_get_index)?

Sure.

> That's more modern. Also, don't print any error because -EPROBE_DEFER
may come out and=20

Well, this could not happen. Driver probe will not called until default=
=20
pinctrl state is not available and we rely on this for proper driver
functionality.=20

> because __gpiod_get_index() already prints an error on
> failure at the debug level.

Ok.

Thanks,=20
Ivan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
