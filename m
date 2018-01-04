From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] gpio: of: Support SPI nonstandard GPIO properties
Date: Thu, 4 Jan 2018 21:24:22 +0100
Message-ID: <CACRpkdZ9yGm9K4iF=jR8bjzZR6cU7vEV8tNz6i7DfcE=Jhp2yw@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-2-linus.walleij@linaro.org> <CAL_JsqLH4pqptAkpw2CHPRe=6dR3k1iBPM8g7yMFUHnYmm7L9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqLH4pqptAkpw2CHPRe=6dR3k1iBPM8g7yMFUHnYmm7L9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 3, 2018 at 4:23 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jan 1, 2018 at 7:37 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

>> +/*
>> + * The SPI GPIO bindings happened before we managed to establish that GPIO
>> + * properties should be named "foo-gpios" so we have this special kludge for
>> + * them.
>> + */
>> +#ifdef CONFIG_SPI_MASTER
>> +static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *con_id,
>> +                                         enum of_gpio_flags *of_flags)
>> +{
>> +       char prop_name[32]; /* 32 is max size of property name */
>> +       struct device_node *np = dev->of_node;
>> +       struct gpio_desc *desc;
>
> Instead of the ifdef:
>
> if (!IS_ENABLED(CONFIG_SPI_MASTER))
>   return ERR_PTR(-ENOENT);
>
> Or merge the condition with the if below.

I was consciously exploting the fact the CONFIG_SPI_MASTER is bool,
but I guess that can be fragile if someone decides to modularize it so, OK.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
