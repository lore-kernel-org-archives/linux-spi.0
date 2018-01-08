From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] gpio: of: Support SPI nonstandard GPIO properties
Date: Mon, 8 Jan 2018 14:25:43 +0100
Message-ID: <CAMuHMdWKO5WcLicMdaa7qKj=h-ddzRqNKvmxqVqRhgO9bTENaQ@mail.gmail.com>
References: <20180108124909.32334-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180108124909.32334-1-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

On Mon, Jan 8, 2018 at 1:49 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Before it was clearly established that all GPIO properties in the
> device tree shall be named "foo-gpios" (with the deprecated variant
> "foo-gpio" for single lines) we unfortunately merged a few bindings
> which named the lines "gpio-foo" instead.
>
> This is most prominent in the GPIO SPI driver in Linux which names
> the lines "gpio-sck", "gpio-mosi" and "gpio-miso".
>
> As we want to switch the GPIO SPI driver to using descriptors, we
> need devm_gpiod_get() to return something reasonable when looking
> up these in the device tree.
>
> Put in a special #ifdef:ed kludge to do this special lookup only
> for the SPI case and gets compiled out if we're not enabling SPI.
> If we have more oddly defined legacy GPIOs like this, they can be
> handled in a similar manner.
>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I will merge this into the GPIO tree as a preparation for the next
> (v4.17) kernel cycle so that we avoid cross-tree dependencies.
> I estimate that it is too late to merge the bulk of the patches
> for v4.16, but this can go in.
>
> ChangeLog v1->v2:
> - Us if IS_ENABLED(CONFIG_SPI_MASTER) instead of
>   #ifdef CONFIG_SPI_MASTER

> +++ b/drivers/gpio/gpiolib-of.c
> @@ -117,6 +117,37 @@ int of_get_named_gpio_flags(struct device_node *np, const char *list_name,
>  }
>  EXPORT_SYMBOL(of_get_named_gpio_flags);
>
> +/*
> + * The SPI GPIO bindings happened before we managed to establish that GPIO
> + * properties should be named "foo-gpios" so we have this special kludge for
> + * them.
> + */
> +#if IS_ENABLED(CONFIG_SPI_MASTER)

AFAIU, Rob really meant C "if", not CPP "#ifdef", so the code path is always
exercised by the compiler.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
