From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] gpio: of: Support SPI nonstandard GPIO properties
Date: Wed, 3 Jan 2018 09:23:06 -0600
Message-ID: <CAL_JsqLH4pqptAkpw2CHPRe=6dR3k1iBPM8g7yMFUHnYmm7L9w@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org> <20180101133749.29567-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-2-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 1, 2018 at 7:37 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
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
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/gpio/gpiolib-of.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index e0d59e61b52f..0f2d096c78a3 100644
> --- a/drivers/gpio/gpiolib-of.c
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
> +#ifdef CONFIG_SPI_MASTER
> +static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *con_id,
> +                                         enum of_gpio_flags *of_flags)
> +{
> +       char prop_name[32]; /* 32 is max size of property name */
> +       struct device_node *np = dev->of_node;
> +       struct gpio_desc *desc;

Instead of the ifdef:

if (!IS_ENABLED(CONFIG_SPI_MASTER))
  return ERR_PTR(-ENOENT);

Or merge the condition with the if below.

> +
> +       /* Allow this specifically for "spi-gpio" devices */
> +       if (!of_device_is_compatible(np, "spi-gpio") || !con_id)
> +               return ERR_PTR(-ENOENT);
> +
> +       /* Will be "gpio-sck", "gpio-mosi" or "gpio-miso" */
> +       snprintf(prop_name, sizeof(prop_name), "%s-%s", "gpio", con_id);
> +
> +       desc = of_get_named_gpiod_flags(np, prop_name, 0, of_flags);
> +       return desc;
> +}
> +#else
> +static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *con_id,
> +                                         enum of_gpio_flags *of_flags)
> +{
> +       return ERR_PTR(-ENOENT);
> +}
> +#endif
> +
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
