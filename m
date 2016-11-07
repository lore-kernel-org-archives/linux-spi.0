From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: make architecture specific hardware depend on the
 associated hardware
Date: Mon, 7 Nov 2016 18:12:21 +0000
Message-ID: <CALeDE9NiTvKd1So=Hw4oe2LQUNnZhq4e0NLroG6K_vc82_oE6w@mail.gmail.com>
References: <20161106222128.24433-1-pbrobinson@gmail.com> <20161107174935.25r32yoq626yselg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161107174935.25r32yoq626yselg-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

">> There's not much point enabling hardware specific hardware drivers if the
>> actual SoC architecture platforms aren't enabled as they're not much use
>> with out it.
>
> This really needs cross checking with the various platform maintainers
> that the dependencies are correct and it's breaking compile test
> coverage for quite a few of the individual drivers.

Was going on the get maintainers script, but on the breakage I'm not
sure how it does breaks stuff as it just adds in the explicit ARCH
config for those SoCs. Are the compile test breakages somewhere public
where I can see them and cross verify with my testing?

>>  config SPI_DW_MID_DMA
>>       bool "DMA support for DW SPI controller on Intel MID platform"
>> -     depends on SPI_DW_PCI && DW_DMAC_PCI
>> +     depends on X86 && SPI_DW_PCI && DW_DMAC_PCI
>
> This isn't right - while Intel do use this IP Desginware are a generic
> IP vendor and PCI is an architecture neutral bus so there shouldn't be
> an x86 dependency.

The SPI_DW_PCI seems to be the generic part. The description for the
DMA bit explicitly says "Intel MID platform" and looking in
spi-dw-mid.c it has comments like "Get pci device for DMA controller,
currently it could only be the DMA controller of Medfield" so while
I'm aware that DesignWare is generic IP a lot of the ARM DW stuff is
mostly generic drivers a lot have a bunch of platform specific
wrapping it the form of platform specific bits (see the SW stmmac
ethernet directory for numerous examples. This does look at least
currently to be specific for that Intel part so at the moment I still
think that makes sense.

Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
