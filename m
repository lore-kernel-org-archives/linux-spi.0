From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v2 00/12] spi: moving to struct gpio_desc
Date: Sat, 29 Jul 2017 16:15:42 +0300
Message-ID: <CAHp75VeVijF13AO=SqkxtAaiYhss92gwrtCZ2WnxkkKtvjVS3A@mail.gmail.com>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 28, 2017 at 1:03 AM, Chris Packham
<chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> Hi Andy,
>
> As requested here's my WIP series. I've included the ep93xx changes from H
> Hartley Sweeten. I had these locally to use as a base, I was kind of
> surprised they hadn't made it into linux-next.
>
> I tried to account for the master -> ctlr rename as I was rebasing but I
> wouldn't be surprised if I missed some occurrences. This is very much an
> untested WIP it will probably crash and burn in unexpected ways.
>

I briefly looked at the code, first 6 patches for my taste could be
submitted w/o RFC tag.
One comment to them though, better to use u32 instead of unsigned int
when operate with 32-bit registers.

> Chris Packham (6):
>   spi: use gpio_desc instead of numeric gpio
>   ARM: ep93xx: add gpiod_lookup_table for spi chip-selects
>   ARM: imx: add gpiod_lookup_table for spi chip-selects
>   spi: core: convert spi_master to use gpio_desc
>   ARM: ep93xx: remove chipselect from ep93xx_spi_info
>   wip: convert struct spi_device to gpio_desc
>
> H Hartley Sweeten (6):
>   spi: spi-ep93xx: use 32-bit read/write for all registers
>   spi: spi-ep93xx: add spi master prepare_transfer_hardware()
>   spi: spi-ep93xx: absorb the interrupt enable/disable helpers
>   spi: spi-ep93xx: pass the spi_master pointer around
>   spi: spi-ep93xx: remove private data 'current_msg'
>   spi: spi-ep93xx: use the default master transfer queueing mechanism
>
>  arch/arm/mach-ep93xx/edb93xx.c           |  15 +-
>  arch/arm/mach-ep93xx/simone.c            |  14 +-
>  arch/arm/mach-ep93xx/vision_ep9307.c     |  20 +-
>  arch/arm/mach-imx/mach-mx27_3ds.c        |  21 ++
>  arch/arm/mach-imx/mach-pca100.c          |  13 +
>  drivers/spi/spi-ath79.c                  |  26 +-
>  drivers/spi/spi-atmel.c                  |   4 +-
>  drivers/spi/spi-bcm2835.c                |   8 +-
>  drivers/spi/spi-cadence.c                |  29 +-
>  drivers/spi/spi-clps711x.c               |  13 +-
>  drivers/spi/spi-davinci.c                |  10 +-
>  drivers/spi/spi-dw.c                     |   7 -
>  drivers/spi/spi-ep93xx.c                 | 487 ++++++++++++-------------------
>  drivers/spi/spi-fsl-spi.c                |  29 +-
>  drivers/spi/spi-img-spfi.c               |  25 +-
>  drivers/spi/spi-imx.c                    |  25 +-
>  drivers/spi/spi-lantiq-ssc.c             |   2 +-
>  drivers/spi/spi-mpc512x-psc.c            |  20 +-
>  drivers/spi/spi-mt65xx.c                 |  16 -
>  drivers/spi/spi-omap2-mcspi.c            |  17 +-
>  drivers/spi/spi-orion.c                  |   2 +-
>  drivers/spi/spi-pic32.c                  |  11 +-
>  drivers/spi/spi-s3c64xx.c                |  16 +-
>  drivers/spi/spi-st-ssc4.c                |  29 +-
>  drivers/spi/spi.c                        |  26 +-
>  include/linux/platform_data/spi-ep93xx.h |   4 +-
>  include/linux/spi/spi.h                  |   4 +-
>  27 files changed, 312 insertions(+), 581 deletions(-)
>
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
