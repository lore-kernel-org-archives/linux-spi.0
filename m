From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
Date: Tue, 01 Sep 2015 09:36:04 +0300
Message-ID: <55E54754.1060002@linux.intel.com>
References: <1441073073.12012.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441073073.12012.3.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

Adding linux-spi and Mark Brown.

On 09/01/2015 05:04 AM, Axel Lin wrote:
>    CC [M]  arch/arm/plat-pxa/ssp.o
> arch/arm/plat-pxa/ssp.c:110:52: error: 'LPSS_SSP' undeclared here (not in a function)
> scripts/Makefile.build:264: recipe for target 'arch/arm/plat-pxa/ssp.o' failed
> make[1]: *** [arch/arm/plat-pxa/ssp.o] Error 1
> Makefile:965: recipe for target 'arch/arm/plat-pxa' failed
> make: *** [arch/arm/plat-pxa] Error 2
>
>
> The build error is introduced by:
> commit 03fbf488cece461468d3abb795f5e5f055e00040
> Author: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date:   Thu Jun 4 16:55:10 2015 +0300
>
>      spi: pxa2xx: Differentiate Intel LPSS types
>
I obviously didn't do tree wide grep for LPSS_SSP and pxa3xx_defconfig 
don't reveal it without setting CONFIG_USE_OF. Sorry about that.

No I'm pondering how to fix this. I see these bindings are added by the 
commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") but some of the 
types are not used anywhere. For instance PXA168_SSP or PXA910_SSP. Then 
PXA3xx_SSP is used in sound/soc/pxa/pxa-ssp.c and CE4100_SSP in 
drivers/spi/spi-pxa2xx.c (where LPSS_SSP was used too before 
differentiating it).

What I'm wondering is this binding below correct in 
arch/arm/plat-pxa/ssp.c? LPSS_SSP was meant to be for Intel Intel Low 
Power Subsystem SPI.

"{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP }"

Mika, Daniel: do you know is there any change there is a Marvell PXA 
platform compatible with Intel LPSS or is above binding bogus?

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
