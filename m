From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 34/36] ARM: s3c: stop including mach/hardware.h from mach/io.h
Date: Thu, 10 Oct 2019 23:53:18 +0200
Message-ID: <CAK8P3a2HTrxhncNbFtGA3itsZU6hfvRm6bW5ikx-PMFpVKcwdg@mail.gmail.com>
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-34-arnd@arndb.de> <20191010210208.GK25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
        <linux-samsung-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191010210208.GK25745@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 10, 2019 at 11:02 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 10, 2019 at 10:30:18PM +0200, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> > index 2ad22b2d459b..f8a114891f16 100644
> > --- a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> > +++ b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
> > @@ -14,6 +14,8 @@
> >  #ifndef GPIO_SAMSUNG_S3C24XX_H
> >  #define GPIO_SAMSUNG_S3C24XX_H
> >
> > +#include <mach/map.h>
> > +
>
> Why?  Nothing in this file uses anything from mach/map.h

Good point, I don't recall how this happened, most likely either
edited the wrong file after a build regression, or I had moved some
definition into this file in a patch that I later discarded and this
change got left behind.

> > diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> > index 7ca3dd4f13c0..da4e7b3aeba6 100644
> > --- a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> > +++ b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
> > @@ -9,6 +9,8 @@
> >  #ifndef __ASM_ARM_REGS_CLOCK
> >  #define __ASM_ARM_REGS_CLOCK
> >
> > +#include <mach/map.h>
> > +
>
> Why?  Nothing in this file uses anything from mach/map.h

I think I added this one for S3C24XX_VA_CLKPWR, which is in
plat/map-s3c.h

> > diff --git a/drivers/spi/spi-s3c24xx-regs.h b/drivers/spi/spi-s3c24xx-regs.h
> > index 37b93ff7c7fe..b76d591eba8c 100644
> > --- a/drivers/spi/spi-s3c24xx-regs.h
> > +++ b/drivers/spi/spi-s3c24xx-regs.h
> > @@ -8,6 +8,8 @@
> >  #ifndef __ASM_ARCH_REGS_SPI_H
> >  #define __ASM_ARCH_REGS_SPI_H
> >
> > +#include <mach/map.h>
> > +
>
> If this is outside of arch/arm, it shouldn't need anything from
> mach/map.h - mach/map.h is not for driver use.

This was the result of a botched rebase: The patch was initially
at the start of the series where the #include was still required
but later moved to the end behind the patch that used to remove
it again.

> > diff --git a/drivers/usb/gadget/udc/s3c2410_udc_regs.h b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> > index d8d2eeaca088..4df279342cdd 100644
> > --- a/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> > +++ b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
> > @@ -6,6 +6,8 @@
> >  #ifndef __ASM_ARCH_REGS_UDC_H
> >  #define __ASM_ARCH_REGS_UDC_H
> >
> > +#include <mach/map.h>
> > +
>
> If this is outside of arch/arm, it shouldn't need anything from
> mach/map.h - mach/map.h is not for driver use.

Same here.

Thanks for taking a look, I'll fix it all up tomorrow.

          Arnd
