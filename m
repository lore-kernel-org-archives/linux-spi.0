From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: spi-gpio: Rewrite to use GPIO descriptors
Date: Fri, 5 Jan 2018 12:33:51 +0200
Message-ID: <CAHp75VdN2xoSFtxT=EkMvTtduS4TV9bDcu1SRFHTCzOoAgwfvw@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org> <20180101133749.29567-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
        Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>,
        Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>,
        Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-3-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 1, 2018 at 3:37 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> +static struct gpiod_lookup_table cm_x300_spi_gpiod_table = {
> +       .dev_id         = "spi_gpio",
> +       .table          = {
> +               GPIO_LOOKUP("gpio-pxa", GPIO_LCD_SCL,
> +                           "gpio-sck", GPIO_ACTIVE_HIGH),
> +               GPIO_LOOKUP("gpio-pxa", GPIO_LCD_DIN,
> +                           "gpio-mosi", GPIO_ACTIVE_HIGH),
> +               GPIO_LOOKUP("gpio-pxa", GPIO_LCD_DOUT,
> +                           "gpio-miso", GPIO_ACTIVE_HIGH),
> +               GPIO_LOOKUP("gpio-pxa", GPIO_LCD_CS,
> +                           "cs", GPIO_ACTIVE_HIGH),
> +               { },
> +       },
> +};

...and why not to use new proper names from the beggining here?

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
