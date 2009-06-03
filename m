From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] Freescale STMP spi driver
Date: Wed, 3 Jun 2009 07:27:46 +0300
Message-ID: <20090603042746.GB8721@tarshish>
References: <1243971638.4011.16.camel@hp.diimka.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1243971638.4011.16.camel-GL0tbJR47UuzLY3athcO2A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi dmitry,

On Tue, Jun 02, 2009 at 11:40:38PM +0400, dmitry pervushin wrote:
> Hello David,
> 
> Here is the patch for SSP/SPI on STMP3xxx boards; could you please apply
> it? Any comments are appreciated.
> =========================================================================
>
> ...
>
> +/* the spi->mode bits understood by this driver: */
> +#define MODEBITS (SPI_CPOL | SPI_CPHA)
> +static int stmp_spi_setup(struct spi_device *spi)
> +{
> +	struct stmp_spi *ss;
> +
> +	ss = spi_master_get_devdata(spi->master);
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;
> +	if (spi->mode & ~MODEBITS) {
> +		dev_err(&spi->dev, "%s: unsupported mode bits %x\n",
> +			__func__, spi->mode & ~MODEBITS);
> +		return -EINVAL;
> +	}
> +	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w\n",
> +		__func__, spi->mode & MODEBITS, spi->bits_per_word);
> +	return stmp_spi_setup_transfer(spi, NULL);

This might trash running SPI transfers. The setup() method must not touch 
hardware registers.

> ...
>
> Index: linux-2.6-arm/drivers/spi/spi_stmp.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6-arm/drivers/spi/spi_stmp.h

No need for a separate .h file here, IMO. The stmp_spi struct should go into 
stmp_spi.c.

> @@ -0,0 +1,45 @@
> +/*
> + * Freescale STMP378X SPI master driver
> + *
> + * Author: dmitry pervushin <dimka-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
> + *
> + * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +#ifndef __SPI_STMP_H
> +#define __SPI_STMP_H
> +
> +struct stmp_spi {
> +	int		id;
> +
> +	void *  __iomem regs;	/* vaddr of the control registers */
> +
> +	u32		irq;
> +	u32		dma;
> +	struct stmp3xxx_dma_descriptor d;
> +
> +	u32		speed_khz;
> +	u32		saved_timings;
> +	u32		divider;
> +
> +	struct clk	*clk;
> +	struct device	*master_dev;
> +
> +	struct work_struct work;
> +	struct workqueue_struct *workqueue;
> +	spinlock_t lock;
> +	struct list_head queue;
> +
> +	struct completion done;
> +};
> +
> +#endif /* __SPI_STMP_H */

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
