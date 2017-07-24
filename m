From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Mon, 24 Jul 2017 13:49:14 +0300
Message-ID: <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com>
References: <20170724095327.18602-1-mnhu@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170724095327.18602-1-mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+Cc: Mika, Jarkko

On Mon, Jul 24, 2017 at 12:53 PM, Martin Hundeb=C3=B8ll <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org> wr=
ote:
> Some gpio controllers requires lines to be configured as outputs to make
> subsequent calls to `gpio_set_value()` have any effect.
>
> Add a call to `gpio_request_one()` for configured gpio chip-selects to
> make it work on (at least) mvebu gpio controllers.
>

More and more hacks around plain GPIO integers... :-(

Perhaps we need to discuss how to convert SPI core to use GPIO
descriptors everywhere.

> Signed-off-by: Martin Hundeb=C3=B8ll <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
> ---
>  drivers/spi/spi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 0725c78b0de6..b7bfc52525aa 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2010,8 +2010,13 @@ static int of_spi_register_master(struct spi_contr=
oller *ctlr)
>         for (i =3D 0; i < ctlr->num_chipselect; i++)
>                 cs[i] =3D -ENOENT;
>
> -       for (i =3D 0; i < nb; i++)
> +       for (i =3D 0; i < nb; i++) {
>                 cs[i] =3D of_get_named_gpio(np, "cs-gpios", i);
> +               if (gpio_is_valid(cs[i]) &&
> +                   gpio_request_one(cs[i], 0, "spi-cs") < 0)
> +                       dev_warn(&master->dev,
> +                                "gpio_request_one failed for chipselect =
%i\n", i);
> +       }
>
>         return 0;
>  }
> --
> 2.13.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
