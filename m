From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx-pci: Support both chipselects on
 Braswell
Date: Wed, 6 Jul 2016 11:18:18 +0300
Message-ID: <20160706081818.GU23527@lahna.fi.intel.com>
References: <1467749525-100594-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467749525-100594-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jul 05, 2016 at 11:12:05PM +0300, Andy Shevchenko wrote:
> The commit 30f3a6ab44d8 ("spi: pxa2xx: Add support for both chip selects on
> Intel Braswell") introduces a support of chipselects for Intel Braswell SPI
> host controller. Though it missed to convert the PCI part of the driver.

That was actually on purpose - it requires some sort of firmware support
or alternatively a board file which we do not have for Braswell in the
first place.

> Do conversion here which enables both chipselects on Intel Braswell when
> enumerated via PCI.
> 
> We don't care about num_chipselect value since it is overrided inside core
> driver.
> 
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Fixes: 30f3a6ab44d8 ("spi: pxa2xx: Add support for both chip selects on Intel Braswell")

So I don't think this Fixes: is needed here but it should not cause any
harm if it gets backported to stable kernels.

Either way,

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/spi/spi-pxa2xx-pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index 5953edc..f3df522 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -127,21 +127,21 @@ static struct pxa_spi_info spi_info_configs[] = {
>  		.rx_param = &byt_rx_param,
>  	},
>  	[PORT_BSW0] = {
> -		.type = LPSS_BYT_SSP,
> +		.type = LPSS_BSW_SSP,
>  		.port_id = 0,
>  		.setup = lpss_spi_setup,
>  		.tx_param = &bsw0_tx_param,
>  		.rx_param = &bsw0_rx_param,
>  	},
>  	[PORT_BSW1] = {
> -		.type = LPSS_BYT_SSP,
> +		.type = LPSS_BSW_SSP,
>  		.port_id = 1,
>  		.setup = lpss_spi_setup,
>  		.tx_param = &bsw1_tx_param,
>  		.rx_param = &bsw1_rx_param,
>  	},
>  	[PORT_BSW2] = {
> -		.type = LPSS_BYT_SSP,
> +		.type = LPSS_BSW_SSP,
>  		.port_id = 2,
>  		.setup = lpss_spi_setup,
>  		.tx_param = &bsw2_tx_param,
> -- 
> 2.8.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
