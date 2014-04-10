From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 5/9] mtd: spi-nor: shorten Kconfig naming
Date: Thu, 10 Apr 2014 15:39:39 +0800
Message-ID: <20140410073938.GD24100@localhost>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <1397064774-31784-5-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397064774-31784-5-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 09, 2014 at 10:32:50AM -0700, Brian Norris wrote:
> Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/Makefile         |  2 +-
>  drivers/mtd/devices/Kconfig  |  2 +-
>  drivers/mtd/spi-nor/Kconfig  | 11 ++++++++---
>  drivers/mtd/spi-nor/Makefile |  2 +-
>  4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 40fd15344387..99bb9a1f6e16 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -32,5 +32,5 @@ inftl-objs		:= inftlcore.o inftlmount.o
>  
>  obj-y		+= chips/ lpddr/ maps/ devices/ nand/ onenand/ tests/
>  
> -obj-$(CONFIG_MTD_SPI_NOR_BASE)	+= spi-nor/
> +obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor/
>  obj-$(CONFIG_MTD_UBI)		+= ubi/
> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index 48aa1aa5820b..f9e32b53dfc6 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -80,7 +80,7 @@ config MTD_DATAFLASH_OTP
>  
>  config MTD_M25P80
>  	tristate "Support most SPI Flash chips (AT26DF, M25P, W25X, ...)"
> -	depends on SPI_MASTER && MTD_SPI_NOR_BASE
> +	depends on SPI_MASTER && MTD_SPI_NOR
>  	help
>  	  This enables access to most modern SPI flash chips, used for
>  	  program and data storage.   Series supported include Atmel AT26DF,
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index 64cfc39ad17e..d682fb440e06 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -1,12 +1,17 @@
> -config MTD_SPI_NOR_BASE
> -	bool "the framework for SPI-NOR support"
> +config MTD_SPI_NOR
> +	bool "SPI-NOR device support"
>  	depends on MTD
>  	help
>  	  This is the framework for the SPI NOR which can be used by the SPI
>  	  device drivers and the SPI-NOR device driver.
> +
> +if MTD_SPI_NOR
> +
>  config SPI_FSL_QUADSPI
>  	tristate "Freescale Quad SPI controller"
> -	depends on ARCH_MXC && MTD_SPI_NOR_BASE
> +	depends on ARCH_MXC
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
>  	  We only connect the NOR to this controller now.
> +
> +endif # MTD_SPI_NOR
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 51f9d8b99ab7..6a7ce1462247 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -1,2 +1,2 @@
> -obj-$(CONFIG_MTD_SPI_NOR_BASE)	+= spi-nor.o
> +obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
>  obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
> -- 
> 1.8.3.2
> 
> 
> 
Acked-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
