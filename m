From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] gpio: of: Support SPI nonstandard GPIO properties
Date: Mon, 8 Jan 2018 09:22:52 -0600
Message-ID: <CAL_JsqKDObQZQ=GNYvZT013bu_gZvdJVDEP64ujdNC0CowEg=A@mail.gmail.com>
References: <20180108150221.14193-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180108150221.14193-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 8, 2018 at 9:02 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
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
> ChangeLog v2->v3:
> - Put the if(!IS_ENABLED()) inside the SPI GPIO retrieveal function
>   and rely on the compiler to stub out unused code.
> ChangeLog v1->v2:
> - Us if IS_ENABLED(CONFIG_SPI_MASTER) instead of
>   #ifdef CONFIG_SPI_MASTER
> ---
>  drivers/gpio/gpiolib-of.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
