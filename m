From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 06 Dec 2012 12:38:55 +0000
Message-ID: <20121206123856.002683E0AE3@localhost>
References: <1353464203.20353.6.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1353464203.20353.6.camel@bichao>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 21 Nov 2012 10:16:43 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> This patch is to implement SSP SPI controller driver, which has been applied and
> validated on intel Moorestown & Medfield platform. The patch are originated by
> Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> and Sylvain Centelles <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
> and to be further developed by Channing <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> and Chen Jun
> <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> according to their integration & validation on Medfield platform.
> 
> Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Sylvain Centelles <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: channing <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Chen Jun <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Hi Chao,

Thanks for the patch, comments below...

> ---
>  drivers/spi/Kconfig                   |    9 +
>  drivers/spi/Makefile                  |    1 +
>  drivers/spi/spi-intel-mid-ssp.c       | 1407 +++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-intel-mid-ssp.h |  326 ++++++++

Most (if not all) of this header file looks like it needs to be moved
into the .c file. Any symbol that is only used by the driver's .c file
(usually, anything that isn't platform_data) belongs in the .c

>  4 files changed, 1743 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/spi-intel-mid-ssp.c
>  create mode 100644 include/linux/spi/spi-intel-mid-ssp.h
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 1acae35..8b4461b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -179,6 +179,15 @@ config SPI_IMX
>  	  This enables using the Freescale i.MX SPI controllers in master
>  	  mode.
>  
> +config SPI_INTEL_MID_SSP
> +	tristate "SSP SPI controller driver for Intel MID platforms"
> +	depends on SPI_MASTER && INTEL_MID_DMAC
> +	help
> +	  This is the unified SSP SPI master controller driver for
> +	  the Intel MID platforms, handling Moorestown & Medfield,
> +	  master clock mode.
> +	  It supports Bulverde SSP core.
> +

I think I've asked this question before, but I can't remember if I've
gotten an answer. How is this different from the designware spi
controller that is already in the tree for medfield and moorestown MID
platforms? (drivers/spi/spi-dw-mid.c).

>  config SPI_LM70_LLP
>  	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
>  	depends on PARPORT && EXPERIMENTAL
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index c48df47..83f06d0 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
>  obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
>  obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
>  obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
> +obj-$(CONFIG_SPI_INTEL_MID_SSP)		+= spi-intel-mid-ssp.o
>  obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
>  obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
>  obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
> diff --git a/drivers/spi/spi-intel-mid-ssp.c b/drivers/spi/spi-intel-mid-ssp.c
> new file mode 100644
> index 0000000..8fca48f
> --- /dev/null
> +++ b/drivers/spi/spi-intel-mid-ssp.c
> @@ -0,0 +1,1407 @@
> +/*
> + * spi-intel-mid-ssp.c
> + * This driver supports Bulverde SSP core used on Intel MID platforms
> + * It supports SSP of Moorestown & Medfield platforms and handles clock
> + * slave & master modes.
> + *
> + * Copyright (c) 2010, Intel Corporation.
> + *  Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *  Sylvain Centelles <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +/*
> + * Note:
> + *
> + * Supports DMA and non-interrupt polled transfers.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/highmem.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/intel_mid_dma.h>
> +#include <linux/pm_qos.h>
> +#include <linux/module.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-intel-mid-ssp.h>
> +
> +#define DRIVER_NAME "intel_mid_ssp_spi_unified"

This string is used exactly one. Drop the #define.

> +
> +MODULE_AUTHOR("Ken Mills");
> +MODULE_DESCRIPTION("Bulverde SSP core SPI contoller");
> +MODULE_LICENSE("GPL");
> +
> +static const struct pci_device_id pci_ids[];

If you move the pci_ids table up to this point then the forward
declaration can be eliminated.

Also, use a driver-specific prefix on all symbols, even if they are
static. It makes it a lot easier to navigate code when the symbol names
match the driver and it avoids any possibility of conflict with the
global namespace. Something like "midssp_" or "midssp_spi_".

So, this symbol would be midssp_spi_pci_ids[], and all the static
functions below should be renamed.

> +
> +#ifdef DUMP_RX

Nit: Since this is debug code, rename the define to something like
DEBUG_DUMP_RX.

> +static void dump_trailer(const struct device *dev, char *buf, int len, int sz)
> +{
> +	int tlen1 = (len < sz ? len : sz);
> +	int tlen2 =  ((len - sz) > sz) ? sz : (len - sz);
> +	unsigned char *p;
> +	static char msg[MAX_SPI_TRANSFER_SIZE];

Is this size a limitation of the hardware, of of the driver?

> +
> +	memset(msg, '\0', sizeof(msg));
> +	p = buf;
> +	while (p < buf + tlen1)
> +		sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> +
> +	if (tlen2 > 0) {
> +		sprintf(msg, "%s .....", msg);
> +		p = (buf+len) - tlen2;
> +		while (p < buf + len)
> +			sprintf(msg, "%s%02x", msg, (unsigned int)*p++);
> +	}

This looks like it will overrun the msg buffer. It adds 2 bytes for
every byte of data. It's also kind of sketchy code to sprintf into the
same buffer you're reading from.

You could avoid all these problems by using print_hex_dump() instead.

> +
> +	dev_info(dev, "DUMP: %p[0:%d ... %d:%d]:%s", buf, tlen1 - 1,
> +		   len-tlen2, len - 1, msg);
> +}
> +#endif
> +
> +static inline u32 is_tx_fifo_empty(struct ssp_driver_context *drv_context)

u32 ==> bool

> +{
> +	u32 sssr;
> +	sssr = read_SSSR(drv_context->ioaddr);
> +	if ((sssr & SSSR_TFL_MASK) || (sssr & SSSR_TNF) == 0)
> +		return 0;
> +	else
> +		return 1;

or simply: return (sssr & (SSR_TFL_MASK || SSSR_TNF)) != 0;


... Okay, so I just went looking for the read_SSSR() function because I
wanted to know how it was defined. I just discovered that this driver is
the same as drivers/spi/spi-pxa2xx.c with a PCI front end bolted on.

I'm not keen on having two separate drivers for the same logic block.

> +/**
> + * intel_mid_ssp_spi_probe() - Driver probe procedure
> + * @pdev:	Pointer to the pci_dev struct
> + * @ent:	Pointer to the pci_device_id struct
> + */
> +static int intel_mid_ssp_spi_probe(struct pci_dev *pdev,
> +	const struct pci_device_id *ent)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spi_master *master;
> +	struct ssp_driver_context *drv_context = 0;
> +	int status;
> +	u32 iolen = 0;
> +	u8 ssp_cfg;
> +	int pos;
> +	void __iomem *syscfg_ioaddr;
> +	unsigned long syscfg;
> +
> +	/* Check if the SSP we are probed for has been allocated */
> +	/* to operate as SPI. This information is retreived from */
> +	/* the field adid of the Vendor-Specific PCI capability  */
> +	/* which is used as a configuration register.            */
> +	pos = pci_find_capability(pdev, PCI_CAP_ID_VNDR);
> +	if (pos > 0) {
> +		pci_read_config_byte(pdev,
> +			pos + VNDR_CAPABILITY_ADID_OFFSET,
> +			&ssp_cfg);
> +	} else {
> +		dev_info(dev, "No Vendor Specific PCI capability\n");
> +		goto err_abort_probe;
> +	}
> +
> +	if (SSP_CFG_GET_MODE(ssp_cfg) != SSP_CFG_SPI_MODE_ID) {
> +		dev_info(dev, "Unsupported SSP mode (%02xh)\n",
> +			ssp_cfg);
> +		goto err_abort_probe;
> +	}
> +
> +	dev_info(dev, "found PCI SSP controller(ID: %04xh:%04xh cfg: %02xh)\n",
> +		pdev->vendor, pdev->device, ssp_cfg);
> +
> +	status = pci_enable_device(pdev);
> +	if (status)
> +		return status;
> +
> +	/* Allocate Slave with space for drv_context and null dma buffer */
> +	master = spi_alloc_master(dev, sizeof(struct ssp_driver_context));
> +
> +	if (!master) {
> +		dev_err(dev, "cannot alloc spi_slave\n");
> +		status = -ENOMEM;
> +		goto err_free_0;
> +	}
> +
> +	drv_context = spi_master_get_devdata(master);
> +	drv_context->master = master;
> +
> +	drv_context->pdev = pdev;
> +	drv_context->quirks = ent->driver_data;
> +
> +	/* Set platform & configuration quirks */
> +	if (drv_context->quirks & QUIRKS_PLATFORM_MRST) {
> +		/* Apply bit banging workarround on MRST */
> +		drv_context->quirks |= QUIRKS_BIT_BANGING;
> +		/* MRST slave mode workarrounds */
> +		if (SSP_CFG_IS_SPI_SLAVE(ssp_cfg))
> +			drv_context->quirks |=
> +				QUIRKS_USE_PM_QOS |
> +				QUIRKS_SRAM_ADDITIONAL_CPY;
> +	}
> +	drv_context->quirks |= QUIRKS_DMA_USE_NO_TRAIL;
> +	if (SSP_CFG_IS_SPI_SLAVE(ssp_cfg))
> +		drv_context->quirks |= QUIRKS_SPI_SLAVE_CLOCK_MODE;
> +
> +	master->mode_bits = SPI_CPOL | SPI_CPHA;
> +	master->bus_num = SSP_CFG_GET_SPI_BUS_NB(ssp_cfg);
> +	master->num_chipselect = 1;
> +	master->cleanup = cleanup;
> +	master->setup = setup;
> +	master->transfer = transfer;
> +	drv_context->dma_wq = create_workqueue("intel_mid_ssp_spi");
> +	INIT_WORK(&drv_context->complete_work, int_transfer_complete_work);

Workqueue management is integrated into the core spi infrastructure now.
SPI drivers should no longer be creating their own workqueues.

Instead, replace the ->transfer hook with prepare_transfer_hardware(),
unprepare_transfer_hardware() and transfer_one_message(). See
Documentation/spi/spi-summary for details.

> +static int __init intel_mid_ssp_spi_init(void)
> +{
> +	return pci_register_driver(&intel_mid_ssp_spi_driver);
> +}
> +
> +late_initcall(intel_mid_ssp_spi_init);

Why late_initcall()? module_init() should be sufficient. Or better yet
replace the init and exit functions with module_pci_driver()

> diff --git a/include/linux/spi/spi-intel-mid-ssp.h b/include/linux/spi/spi-intel-mid-ssp.h
> new file mode 100644
> index 0000000..1b90b75
> --- /dev/null
> +++ b/include/linux/spi/spi-intel-mid-ssp.h

As mentioned above, most if not all of the stuff in this file belongs in the .c.

g.

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
