From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] spi: tegra: remove redundant "depends on RESET_CONTROLLER"
Date: Fri, 6 Nov 2015 15:02:57 +0900
Message-ID: <CAK7LNAR6Mx4+E-8W5weSN2MyAgkMy6MFMxRQEDvrDftCW92ixw@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
	<1446722128-11961-4-git-send-email-yamada.masahiro@socionext.com>
	<20151105115030.GB18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151105115030.GB18409-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-11-05 20:50 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Nov 05, 2015 at 08:15:24PM +0900, Masahiro Yamada wrote:
>> ARCH_TEGRA selects RESET_CONTROLLER.
>> The dependency "depends on RESET_CONTROLLER" is already met.
>
>>       tristate "NVIDIA Tegra114 SPI Controller"
>>       depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
>> -     depends on RESET_CONTROLLER && HAS_DMA
>> +     depends on HAS_DMA
>
> Again, this driver doesn't depend on ARCH_TEGRA.

How come?

Sorry, I have not been tracking this sub-system,
so I do not get the "Again".


The prompt says "NVIDIA Tegra114 SPI Controller".

It sounds natural for me that this driver depends on ARCH_TEGRA.
No?



-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
