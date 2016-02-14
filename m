From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Sun, 14 Feb 2016 23:31:20 +0900
Message-ID: <CAJKOXPfUhP6CRRr=dKxvw8k3f3-iiuoqhsPy099swpBOdExX3w@mail.gmail.com>
References: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
	<56C02634.8020204@samsung.com>
	<56C03731.5040107@gmail.com>
	<56C03B78.1040100@samsung.com>
	<56C07F7C.5030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56C07F7C.5030907-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2016-02-14 22:22 GMT+09:00 Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> When I think about this patch, I was motivated by below patch.
>
> commit 135f07c3252dc77d0245714d0b413ecc711cd823
> Author: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Date:   Mon Jul 14 17:07:16 2014 +0530
>
>     serial: samsung: get fifosize via device tree
>
>     UART modules on some SoCs only differ in the fifosize of each
>     UART channel. Its useless to duplicate the drv_data structure
>     or create a compatible name for such a change.
>
>     We can get fifosize via the device tree nodes (not mandating it).
>
>     Also updates the documentation.
>
>     Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>     Reviewed-by: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>
> I thought we can apply above patch to SPI also.
> The fifosize should be required for fifo_lvl_mask value in SPI of Exy=
nos series.
> I think this patch is useful when we port for the new exynos7xxx SoC =
come out.
> Because SPI of new exynos7xxx SoC has only difference on fifosize.
>

Please, do not top post.

You skipped some of arguments from my reply instead saying "patch is
useful". That is not a sufficient argument for my doubts... but let me
state again the most important question:

What happens if this *optional* property is not present on board with
Exynos7? What value should be used?

Best regards,
Krzysztof

> Thanks.
>
>
> On 2016=EB=85=84 02=EC=9B=94 14=EC=9D=BC 17:31, Krzysztof Kozlowski w=
rote:
>> W dniu 14.02.2016 o 17:13, Youngmin Nam pisze:
>>> Hello Krzysztof,
>>>
>>> As you mentioned, spi fifosize is not configurable in the given SoC=
=2E
>>> The point is we can set fifosize without changing driver code.
>>> For example, if some SoC in exynos7 series has different spi fifosi=
ze of on each channel with current
>>> our compatible, we can't cover this situation without adding new co=
mpatible into spi driver code.
>>
>> Yes, because new SoC is not compatible with old ones... so a new
>> compatible is required!
>>
>>> Whenever new SoC kind of exynos7 come out, we should add new compat=
ible into driver code only for fifosize change.
>>> I think this is not efficient. I think we can reduces this works th=
rough DT handling.
>>
>> I agree that this is not the most efficient possible way of setting =
some
>> specific properties of devices but this is the way how DT works.
>>
>> What if the property is not present on board with Exynos7? What valu=
e
>> should be used?
>>
>> You did not want to add a new compatible but you are adding a
>> compatible-like property which apparently is required for some devic=
es.
>>
>> That looks bad. It's easy to make a mistake, messes with compatibles=
=2E
>>
>> Best regards,
>> Krzysztof
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
