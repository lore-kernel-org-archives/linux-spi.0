From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] gpio: of: Support SPI nonstandard GPIO properties
Date: Fri, 5 Jan 2018 12:21:42 +0200
Message-ID: <CAHp75VeaDU0Zn4W2hgspVDB+yLgpp8UYG+=ci_4Ymo68PTPO3g@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-2-linus.walleij@linaro.org> <CAL_JsqLH4pqptAkpw2CHPRe=6dR3k1iBPM8g7yMFUHnYmm7L9w@mail.gmail.com>
 <CACRpkdZ9yGm9K4iF=jR8bjzZR6cU7vEV8tNz6i7DfcE=Jhp2yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZ9yGm9K4iF=jR8bjzZR6cU7vEV8tNz6i7DfcE=Jhp2yw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 4, 2018 at 10:24 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jan 3, 2018 at 4:23 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

>> Instead of the ifdef:
>>
>> if (!IS_ENABLED(CONFIG_SPI_MASTER))
>>   return ERR_PTR(-ENOENT);
>>
>> Or merge the condition with the if below.
>
> I was consciously exploting the fact the CONFIG_SPI_MASTER is bool,
> but I guess that can be fragile if someone decides to modularize it so, OK.

Just a side note, we have IS_BUILTIN() for booleans.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
