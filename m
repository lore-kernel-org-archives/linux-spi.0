From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4] spi: Add Lattice ECP3 FPGA configuration via SPI
Date: Wed, 05 Dec 2012 23:34:08 +0000
Message-ID: <20121205233408.CAAA73E0E22@localhost>
References: <1354287532-6798-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1354287532-6798-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 30 Nov 2012 15:58:52 +0100, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org> wrote:
> This patch adds support for bitstream configuration (programming /
> loading) of the Lattice ECP3 FPGA's via the SPI bus.
> 
> Here an example on my custom MPC5200 based board:
> 
> $ echo 1 > /sys/class/firmware/spi0.0/loading
> $ cat fpga_a4m2k.bit > /sys/class/firmware/spi0.0/data
> $ echo 0 > /sys/class/firmware/spi0.0/loading
> 
> leads to these messages:
> 
> lattice-ecp3 spi0.0: FPGA Lattice ECP3-35 detected
> lattice-ecp3 spi0.0: Configuring the FPGA...
> lattice-ecp3 spi0.0: FPGA succesfully configured!
> 
> Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Hi Stefan,

Comments below.

> ---
> v4:
> - Allocate per-device struct to store the completion
>   variable unique per device
> 
> v3:
> - Removed unnecessary goto (return instead)
> - Added waiting for completion in remove
> 
> v2:
> - Moved from drivers/firmware to drivers/spi as suggested by
>   Ming Lei
> - Removed pseudo device
> - Removed static buffer pointer usage
> 
>  drivers/spi/Kconfig                   |  11 ++
>  drivers/spi/Makefile                  |   1 +
>  drivers/spi/spi-lattice-ecp3-config.c | 246 ++++++++++++++++++++++++++++++++++

This isn't an spi controller driver. It belongs in drivers/misc

>  3 files changed, 258 insertions(+)
>  create mode 100644 drivers/spi/spi-lattice-ecp3-config.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 1acae35..e7b108773 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -461,6 +461,17 @@ config SPI_DW_MMIO
>  #
>  comment "SPI Protocol Masters"
>  
> +config SPI_LATTICE_ECP3_CONFIG
> +	tristate "Lattice ECP3 FPGA bitstream configuration via SPI"
> +	depends on SYSFS
> +	select FW_LOADER
> +	default	n
> +	help
> +	  This option enables support for bitstream configuration (programming
> +	  or loading) of the Lattice ECP3 FPGA family via SPI.
> +
> +	  If unsure, say N.
> +
>  config SPI_SPIDEV
>  	tristate "User mode SPI device driver support"
>  	depends on EXPERIMENTAL
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index c48df47..9a532c0 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
>  obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
>  obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
>  obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
> +obj-$(CONFIG_SPI_LATTICE_ECP3_CONFIG)	+= spi-lattice-ecp3-config.o
>  obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
>  obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
>  obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
> diff --git a/drivers/spi/spi-lattice-ecp3-config.c b/drivers/spi/spi-lattice-ecp3-config.c
> new file mode 100644
> index 0000000..d34b2a6
> --- /dev/null
> +++ b/drivers/spi/spi-lattice-ecp3-config.c
> @@ -0,0 +1,246 @@
> +/*
> + * Copyright (C) 2012 Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/spi/spi.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +
> +#define DRIVER_NAME	"lattice-ecp3"
> +#define DRIVER_VER	"1.0"

Nit: Drop this. It is pointless. DRIVER_NAME isn't even used!  :-)

Otherwise the patch looks pretty straightforward.

Reviewed-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
