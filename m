From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [RESEND][PATCH] SPI: Add SPI driver for
	most known i.MX SoCs
Date: Mon, 15 Jun 2009 15:28:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906151524560.4583@axis700.grange>
References: <20090512123151.GG29278@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Wolfram Sang <wsa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090512123151.GG29278-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Sascha, David

On Tue, 12 May 2009, Sascha Hauer wrote:

> Hi all,
> 
> I got no comments the last time I sent this, here is an updated version
> which now also works on i.MX35. Any input on this?

David, what's your take on this driver?

Sascha, haven't looked at or tested it at all, just one nitpick:

> 
> Sascha
> 
> 
> v2: Updated and tested on i.MX35
> 
> While there already is a SPI driver for i.MX1 in the tree there are
> good reasons to replace it:
> 
> - The inkernel driver implements a full blown SPI driver, but
>   the hardware can be fully supported using a bitbang driver.
>   This greatly reduces the size and complexity of the driver.
> - The inkernel driver only works on i.MX1 SoCs. Unfortunately
>   Freescale decided to randomly mix the register bits for each
>   new SoC, This is quite hard to handle with the current driver
>   since it has register accesses in many places.
> - The DMA API of the durrent driver is broken for arch-mx1 (as opposed
>   to arch-imx) and nobody cared to fix it yet.
> 
> This driver has been tested on i.MX1/i.MX27/i.MX35 with an AT25 type
> EEPROM and on i.MX27/i.MX31 with a Freescale MC13783 PMIC.
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  arch/arm/plat-mxc/include/mach/spi.h |   27 ++
>  drivers/spi/Kconfig                  |    7 +-
>  drivers/spi/Makefile                 |    2 +-
>  drivers/spi/mxc_spi.c                |  685 ++++++++++++++++++++++++++++++++++
>  4 files changed, 717 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/spi.h
>  create mode 100644 drivers/spi/mxc_spi.c
> 
> diff --git a/arch/arm/plat-mxc/include/mach/spi.h b/arch/arm/plat-mxc/include/mach/spi.h
> new file mode 100644
> index 0000000..08be445
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/spi.h
> @@ -0,0 +1,27 @@
> +
> +#ifndef __MACH_SPI_H_
> +#define __MACH_SPI_H_
> +
> +/*
> + * struct spi_imx_master - device.platform_data for SPI controller devices.
> + * @chipselect: Array of chipselects for this master. Numbers >= 0 mean gpio
> + *              pins, numbers < 0 mean internal CSPI chipselects according
> + *              to MXC_SPI_CS(). Normally you want to use gpio based chip
> + *              selects as the CSPI module tries to be intelligent about
> + *              when to assert the chipselect: The CSPI module deasserts the
> + *              chipselect once it runs out of input data. The other problem
> + *              is that it is not possible to mix between high active and low
> + *              active chipselects on one single bus using the internal
> + *              chipselects. Unfortunately Freescale decided to put some
> + *              chipselects on dedicated pins which are not usable as gpios,
> + *              so we have to support the internal chipselects.
> + * @num_chipselect: ARRAY_SIZE(chipselect)
> + */
> +struct spi_imx_master {
> +	int	*chipselect;
> +	int	num_chipselect;
> +};
> +
> +#define MXC_SPI_CS(no)	((no) - 32)
> +
> +#endif /* __MACH_SPI_H_*/
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 7c61251..6bb8e12 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -117,10 +117,11 @@ config SPI_GPIO
>  	  speed with a custom version of this driver; see the source code.
>  
>  config SPI_IMX
> -	tristate "Freescale iMX SPI controller"
> -	depends on ARCH_MX1 && EXPERIMENTAL
> +	tristate "Freescale iMX SPI controllers"
> +	depends on ARCH_MXC
> +	select SPI_BITBANG
>  	help
> -	  This enables using the Freescale iMX SPI controller in master
> +	  This enables using the Freescale iMX SPI controllers in master
>  	  mode.
>  
>  config SPI_LM70_LLP
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 5d04519..73b508b 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -17,7 +17,7 @@ obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
>  obj-$(CONFIG_SPI_AU1550)		+= au1550_spi.o
>  obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
>  obj-$(CONFIG_SPI_GPIO)			+= spi_gpio.o
> -obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
> +obj-$(CONFIG_SPI_IMX)			+= mxc_spi.o

You disable building spi_imx.o, but do not remove the .c?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
