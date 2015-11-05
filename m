From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] spi: sunxi: remove redundant "depends on RESET_CONTROLLER"
Date: Thu, 5 Nov 2015 21:11:47 +0900
Message-ID: <CAK7LNAQsFTKhnUCUVkZXudjKjPc9rbA8ERWeq4hw8RqPnbRihA@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
	<1446722128-11961-3-git-send-email-yamada.masahiro@socionext.com>
	<20151105112847.GA18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151105112847.GA18409-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-11-05 20:28 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Nov 05, 2015 at 08:15:23PM +0900, Masahiro Yamada wrote:
>> ARCH_SUNXI selects RESET_CONTROLLER.
>> The dependency "depends on RESET_CONTROLLER" is already met.
>
> No, it isn't.
>
>>  config SPI_SUN6I
>>       tristate "Allwinner A31 SPI controller"
>>       depends on ARCH_SUNXI || COMPILE_TEST
>> -     depends on RESET_CONTROLLER
>
> The dependency is on ARCH_SUNXI || COMPILE_TEST which is not the same as
> ARCH_SUNXI.


The compile test of this driver should pass even if RESET_CONTROLLER
is not defined.
So, it does not matter for COMPILE_TEST.




-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
