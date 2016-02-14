From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFT] spi: bcm2835: Remove unnecessary workaround to call gpio_set_value
Date: Sun, 14 Feb 2016 11:41:34 +0800
Message-ID: <CAFRkauCaq+4Rs_MaApZmqdZ=SiBG2GViZkm1VnjY9j-ftFsXZg@mail.gmail.com>
References: <1455380347.25581.1.camel@ingics.com>
	<67B70D1B-7FA5-48A6-8719-490FA484BFF6@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <67B70D1B-7FA5-48A6-8719-490FA484BFF6-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2016-02-14 1:08 GMT+08:00 Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>:
>
>> On 13.02.2016, at 17:19, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> This should be fixed by commit 4c02cba18cc9
>> ("pinctrl: bcm2835: Fix initial value for direction_output")
>>
>> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>
> Actually this also solves the situation when the DT is configured
> badly - and it is likely that old DTs are configured badly,
> because it did not matter before (it was always wrong anyway).
>
> This change would break those old DTs in this respect and can
> result in unexpected behavior and undetected devices.

Hi Martin,
I don't understand why this patch breaks old DTs.

Before 4c02cba18cc9:
gpio_direction_output(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
gpio_set_value(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);

is equivalent to

After 4c02cba18cc9: (Already in Linus' tree)
gpio_direction_output(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ? 0 : 1);

Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
