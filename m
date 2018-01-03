From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: spi-gpio: Make optional chipselect handling more explicit
Date: Wed, 3 Jan 2018 10:40:52 +0100
Message-ID: <CACRpkdaEyKcWPY543CZz0grepAhVijefh_+FCsPd3g+83hv2Fg@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-5-linus.walleij@linaro.org> <CAMuHMdV5tdm0diunWg2BXxgVsG0FqwTgXXXBD+p9nbOEXcd59Q@mail.gmail.com>
 <CACRpkdZaLKUs+9BP_Tp8bhdCur+CHaTK1RsS=i2na4Edqz1VGw@mail.gmail.com> <CAMuHMdVeTQOxRMJaohGFtw6LUtwQb6H46rsrf1fRFno9KBQXXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVeTQOxRMJaohGFtw6LUtwQb6H46rsrf1fRFno9KBQXXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 3, 2018 at 10:17 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Wed, Jan 3, 2018 at 9:58 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On Wed, Jan 3, 2018 at 9:21 AM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>>
>>> Hmm, having two indicators for the same feature (spi_gpio->has_cs == true and
>>> spi_gpio->cs_gpios[0] = NULL), and the need to keep them in sync in the
>>> future, also complicates things.
>>
>> The patch does not do this.
>>
>> It removes the latter and adds the former. That is why it removes the
>> assignment of NULL to cs_gpios[0].
>
> So what is cs_gpios[0] if has_cs == true? Oh, it will point to unallocated
> memory right after the structure...

I think it is a problem with all dynamic arrays: they are prone to out-of-bounds
accesses.

That in turn comes from the following design pattern i the spi alloc_master()
helper:

        status = spi_gpio_request(pdata, dev_name(&pdev->dev), &master_flags);
        if (status < 0)
                return status;

        master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio) +
                                        (sizeof(unsigned long) * num_devices));
        if (!master) {
                status = -ENOMEM;
                goto gpio_free;
        }
        spi_gpio = spi_master_get_devdata(master);

So someone wanted to save a slab by using this instead of allocating
the array dynamically. It's not a very admirable coding style to begin
with. I doubt the system gains much from this.

If you agree I can rewrite it to have struct gpio_desc ** and
dynamically allocate that to the number of descriptors with devm_kzalloc()
instead, that is more in line with kernel patterns and this memory
optimization anyways seems a bit overdone anyways.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
