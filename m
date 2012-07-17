From: Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>
Subject: Re: [PATCH 05/10] mmc: spi: Pull out the SSP clock configuration
	function
Date: Tue, 17 Jul 2012 15:39:01 +0200
Message-ID: <20120717153901.5530a246a7a5fecfef03b373@kinali.ch>
References: <1342440597-8395-1-git-send-email-marex@denx.de>
	<1342440597-8395-6-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>,
	Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1342440597-8395-6-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 16 Jul 2012 14:09:52 +0200
Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:

> Pull out the MMC clock configuration function and make it
> into SSP clock configuration function, so it can be used by
> the SPI driver too.

> diff --git a/drivers/clk/mxs/clk-ssp.c b/drivers/clk/mxs/clk-ssp.c
> new file mode 100644
> index 0000000..b3c1e16
> --- /dev/null
> +++ b/drivers/clk/mxs/clk-ssp.c
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright 2012 DENX Software Engineering, GmbH
> + *
> + * Pulled from code:
> + * Portions copyright (C) 2003 Russell King, PXA MMCI Driver
> + * Portions copyright (C) 2004-2005 Pierre Ossman, W83L51xD SD/MMC driver
> + *
> + * Copyright 2008 Embedded Alley Solutions, Inc.
> + * Copyright 2009-2011 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/spi/mxs-spi.h>
> +
> +void mxs_ssp_set_clk_rate(struct mxs_ssp *ssp, unsigned int rate)
> +{
> +	unsigned int ssp_clk, ssp_sck;
> +	u32 clock_divide, clock_rate;
> +	u32 val;
> +
> +	ssp_clk = clk_get_rate(ssp->clk);
> +
> +	for (clock_divide = 2; clock_divide <= 254; clock_divide += 2) {
> +		clock_rate = DIV_ROUND_UP(ssp_clk, rate * clock_divide);
> +		clock_rate = (clock_rate > 0) ? clock_rate - 1 : 0;
> +		if (clock_rate <= 255)
> +			break;
> +	}
> +
> +	if (clock_divide > 254) {
> +		dev_err(ssp->dev,
> +			"%s: cannot set clock to %d\n", __func__, rate);
> +		return;
> +	}
> +
> +	ssp_sck = ssp_clk / clock_divide / (1 + clock_rate);
> +
> +	val = readl(ssp->base + HW_SSP_TIMING(ssp));
> +	val &= ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
> +	val |= BF_SSP(clock_divide, TIMING_CLOCK_DIVIDE);
> +	val |= BF_SSP(clock_rate, TIMING_CLOCK_RATE);
> +	writel(val, ssp->base + HW_SSP_TIMING(ssp));
> +
> +	ssp->clk_rate = ssp_sck;
> +
> +	dev_dbg(ssp->dev,
> +		"%s: clock_divide %d, clock_rate %d, ssp_clk %d, rate_actual %d, rate_requested %d\n",
> +		__func__, clock_divide, clock_rate, ssp_clk, ssp_sck, rate);
> +}

There is a EXPORT_SYMBOL_GPL(mxs_ssp_set_clk_rate); missing here.

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
