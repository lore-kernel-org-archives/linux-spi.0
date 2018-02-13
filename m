From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: spi-gpio: Rewrite to use GPIO descriptors
Date: Tue, 13 Feb 2018 16:17:38 +0200
Message-ID: <CAHp75VeOf6Zywgn9LWWX1kOwsqw28dhZ5EE+N-0KFX_0m-JxOw@mail.gmail.com>
References: <20180212124532.25776-1-linus.walleij@linaro.org> <20180212124532.25776-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
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
In-Reply-To: <20180212124532.25776-2-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Feb 12, 2018 at 2:45 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> This converts the bit-banged GPIO SPI driver to looking up and
> using GPIO descriptors to get a handle on GPIO lines for SCK,
> MOSI, MISO and all CS lines.
>
> All existing board files are converted in one go to keep it all
> consistent. With these conversions I rarely find any interrim

interim

> steps that makes any sense.
>
> Device tree probing and GPIO handling should work like before
> also after this patch.
>
> For board files, we stop using controller data to pass the GPIO
> line for chip select, instead we pass this as a GPIO descriptor
> lookup like everything else.
>
> In some s3c24xx machines the names of the SPI devices were set to
> "spi-gpio" rather than "spi_gpio" which can never have worked, I
> fixed it working (I guess) as part of this patch set. Sometimes
> I wonder how this code got upstream in the first place, it
> obviously is not tested.
>
> mach-s3c64xx/mach-smartq.c has the same problem and additionally
> defines the *same* GPIO line for MOSI and MISO which is not going
> to be accepted by gpiolib. As the lines were number 1,2,2 I assumed
> it was a typo and use lines 1,2,3. A comment gives awat that line 0
> is chip select though no actual SPI device is provided for the LCD
> supposed to be on this bit-banged SPI bus. I left it intact instead
> of just deleting the bus though.
>
> Kill off board file code that try to initialize the SPI lines
> to the same values that they will later be set by the spi_gpio
> driver anyways. Given the huge number of weird things in these
> board files I do not think this code is very tested or put in
> with much afterthought anyways.
>
> In order to assert that we do not get performance regressions on
> this crucial bing-banged driver, a ran a script like this dumping the
> Ilitek ILI9322 regmap 10000 times (it has no caching obviously) on
> an otherwise idle system in two iterations before and after the
> patches:

> +               { },

As commented earlier to the similar change, terminator would terminate
even at compile time.
To achieve that just remove comma.

> +               { },

> +               { },

> +               { },

> +               { },

> +               { },

> +               { },

> +               { },

>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>

Do I understand correctly that gpio.h is left due to dependencies in
other parts of the code (here and in the rest of changed drivers)?

> +               { },

>  static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
>  {
>         struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
>
> +       /* set initial clock line level */
>         if (is_active)
> +               gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
> +
> +       /* Drive chip select line, if we have one */
> +       if (spi_gpio->has_cs) {
> +               struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
>
> +               /* SPI chip selects are normally active-low */
> +               gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);

  bool invert = !(spi->mode & SPI_CS_HIGH);

  gpiod_set_value_cansleep(cs, !!is_active ^ invert);

?

But I guess most used pattern is just explicit conditional

if (spi->mode & SPI_CS_HIGH)
        gpiod_set_value_cansleep(cs, is_active);
else
        gpiod_set_value_cansleep(cs, !is_active);

>         }
>  }

> +       spi_gpio->cs_gpios = devm_kzalloc(&pdev->dev,
> +                               pdata->num_chipselect * sizeof(*spi_gpio->cs_gpios),
> +                               GFP_KERNEL);

kcalloc

> +       if (!spi_gpio->cs_gpios)
> +               return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
