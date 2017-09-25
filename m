From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 21:20:31 +0200
Message-ID: <CAMuHMdXwv7s-uBM2J1Rf5fw+2=N_VcPxCYHartgUxb56yrR23A@mail.gmail.com>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk> <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
 <20170925161221.v23dpeljin5kakhz@sirena.org.uk> <449abd0e-8d8b-86e9-2b7a-65c27ab3171b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <449abd0e-8d8b-86e9-2b7a-65c27ab3171b-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Randy,

On Mon, Sep 25, 2017 at 7:19 PM, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> On 09/25/17 09:12, Mark Brown wrote:
>> On Fri, Sep 22, 2017 at 06:46:46PM -0700, Randy Dunlap wrote:
>>> On 09/22/17 02:26, Mark Brown wrote:
>>
>>>> right thing - if we can use hwspinlocks in a module when they're enabled
>>>> I'd expect to be able to build the stubs that way too.
>>
>>> Sorry, I'm not understanding what you are trying to say on that one.
>>
>>> HWSPINLOCK   SPI_SPRD_ADI
>>
>>> but this combo is not allowed (with the patch) or causes build errors
>>> (without the patch):
>>>      m               y
>>
>> Why is that not just an || COMPILE_TEST dependency then?  The dependency
>> you're trying to introduce is weird and confusing, we shouldn't be
>> having to do things like that.
>
> It already uses COMPILE_TEST:
>
> config SPI_SPRD_ADI
>         tristate "Spreadtrum ADI controller"
>         depends on ARCH_SPRD || COMPILE_TEST
>         help
>           ADI driver based on SPI for Spreadtrum SoCs.
>
> but that allows build errors when SPI_SPRD_ADI=y and HWSPINLOCK=y.

You mean "when SPI_SPRD_ADI=y and HWSPINLOCK=m"?

> As for the dependency that I am adding:
> +       depends on HWSPINLOCK || HWSPINLOCK=n
>
> that idiom is used over and over again in Kconfig files to prevent this kind of
> build problem in loadable modules.

Indeed, it's confusing, but used all over the place.

The issue is builtin drivers that depend on a modular API.  The clean way
is to separate API and implementation, so the API can be builtin, and the
implementation can be modular.
Hence the API should provide stubs that call into function pointers, to be
registered by the module providing the implementation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
