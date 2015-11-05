From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: mediatek: single device does not require cs_gpios
Date: Thu, 5 Nov 2015 18:33:04 +0800
Message-ID: <CANMq1KCXPjQuJUp3zOSVQQA29n9TT56Z0NPpD4o3O5s3o3nqSA@mail.gmail.com>
References: <1446702633-14019-1-git-send-email-drinkcat@chromium.org>
	<CAHp75VfAHyTOpWcTh6w2EhEy73xfUYX5T3tpXbUbBiU-tjaZnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfAHyTOpWcTh6w2EhEy73xfUYX5T3tpXbUbBiU-tjaZnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Nov 5, 2015 at 5:16 PM, Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Nov 5, 2015 at 7:50 AM, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
[...]
>> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
>> index 563954a..f694031 100644
>> --- a/drivers/spi/spi-mt65xx.c
>> +++ b/drivers/spi/spi-mt65xx.c
>> @@ -410,7 +410,7 @@ static int mtk_spi_setup(struct spi_device *spi)
>>         if (!spi->controller_data)
>>                 spi->controller_data = (void *)&mtk_default_chip_info;
>>
>> -       if (mdata->dev_comp->need_pad_sel)
>> +       if (mdata->dev_comp->need_pad_sel && spi->cs_gpio >= 0)
>
> gpio_is_valid() ?

Yes, thanks! Will fix in next round. (there is a few other ones in
driver/spi/* that should probably be fixed too...)

Best,
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
