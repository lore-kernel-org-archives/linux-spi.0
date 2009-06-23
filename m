From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RESEND][PATCH] SPI: xilinx_spi: Added
	platform driver and support for DS570
Date: Tue, 23 Jun 2009 12:37:54 -0700
Message-ID: <200906231237.54278.david-b@pacbell.net>
References: <4A366622.2050606@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Richard =?iso-8859-1?q?R=F6jfors?= <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4A366622.2050606-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 15 June 2009, Richard R=F6jfors wrote:
> This patch splits xilinx_spi into three parts, an OF and a platform
> driver and generic part.
> =

> The generic part now also works on X86 and also supports the Xilinx
> SPI IP DS570

Your Kconfig still mentions only DS464.

Is there any reason the platform driver shouldn't also build on x86?
Surely *any* system should be able to talk to an FPGA which exports
this register interface?


> =

> Signed-off-by: Richard R=F6jfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>

I'll second Andrew's comments.  Also, for my review, it'd be
better to split OF bits out from the rest ... but maybe that's
not practical given the previous xilinx_spi code.  At least
future patches will have a more-sane structure to build on.


> +config SPI_XILINX_OF
> +	tristate "Xilinx SPI controller OF device"
> +	depends on SPI_XILINX && XILINX_VIRTEX
> +	help
> +	  This exposes the SPI controller IP from the Xilinx EDK.

If it's IP, then why is it dependent on VIRTEX?  Surely
the same IP should work on Spartan etc.  I'd think just
depending on something like OF should suffice.


> +
> +	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
> +	  Product Specification document (DS464) for hardware details.
> +
> +config SPI_XILINX_PLTFM
> +	tristate "Xilinx SPI controller platform device"
> +	depends on SPI_XILINX

This should go first in the Kconfig, so that you don't goof up
the dependency display ... the OF bits depend on it.


> --- linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_of.c	(revision 0)
> +++ linux-2.6.30-rc7-spi/drivers/spi/xilinx_spi_of.c	(revision 912)
> @@ -0,0 +1,123 @@
> 	...

> +
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("platform:" XILINX_SPI_NAME);

This is clearly inappropriate for a file with an OpenFirmware driver.
For that matter, it's not needed with platform devices any more either;
so take it out of your platform driver code too.


> --- linux-2.6.30-rc7-spi/include/linux/spi/xilinx_spi.h	(revision 0)
> +++ linux-2.6.30-rc7-spi/include/linux/spi/xilinx_spi.h	(revision 912)
> @@ -0,0 +1,19 @@
> +#ifndef __LINUX_SPI_XILINX_SPI_H
> +#define __LINUX_SPI_XILINX_SPI_H
> +
> +#define XILINX_SPI_MODEL_DS464 0
> +#define XILINX_SPI_MODEL_DS570 1
> +
> +/* SPI Controller IP */
> +struct xspi_platform_data {
> +	s16 bus_num;

Not needed on the platform_bus; pdev->id suffices.
This is specific to the OF glue, yes?


> +	u16 num_chipselect;
> +	u8 model;
> +	u8 bits_per_word;

Synthesis data that's not explicitly visible in
the IP registers, I guess.


> +	/* devices to add to the bus when the host is up */
> +	struct spi_board_info *devices;
> +	u8 num_devices;

This is duplicating functionality in the SPI core code.
That's not really the way to fly.  That may also be
specific to the OF glue.


> +};
> +
> +#endif /* __LINUX_SPI_XILINX_SPI_H */
> +
> =

> =




---------------------------------------------------------------------------=
---
