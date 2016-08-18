From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as Samsung SPI maintainer
Date: Thu, 18 Aug 2016 09:05:43 +0200
Message-ID: <CAJKOXPevQ9c0ZPSWLftXe05VQad0HsPcnjot1H2QZe027S_W8g@mail.gmail.com>
References: <20160818064431.8982-1-andi.shyti@samsung.com> <CAJKOXPe-=qLNSsm9AQHkcVYGSV=yMjsawMbBRbeo6h7sQuzHsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJKOXPe-=qLNSsm9AQHkcVYGSV=yMjsawMbBRbeo6h7sQuzHsw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Aug 18, 2016 at 8:58 AM, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Aug 18, 2016 at 8:44 AM, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> Create a new entry for the Samsung SPI driver supported by the
>> drivers/spi/spi-s3c* and remove it from its original place under
>> "ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".
>>
>> The original maintainership inherited from the Samsung Exynos
>> ARM Architecture is kept as it was (i.e. Kukjin and Krzysztof), I
>> will help and co-maintain the driver.
>>
>> CC: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> CC: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>> Hi,
>>
>> this patch depends on Krzysztof's previous patch-set on the
>> MAINTAINER file: https://lkml.org/lkml/2016/8/16/571
>
> Thanks for taking care of SPI. From my side:
> Acked-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> I think there is no strict dependency on my patch (patches do not
> overlap) so it can safely go through SPI tree if accepted.

One thought. Probably you should extend the entry to cover all the SPI files:
include/linux/platform_data/spi-s3c64xx.h
Documentation/devicetree/bindings/spi/spi-samsung.txt

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
