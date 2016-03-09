From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] spi/spi-xilinx: Add clock support
Date: Wed, 9 Mar 2016 10:07:52 +0100
Message-ID: <56DFE7E8.3040902@metafoo.de>
References: <1457426528-15247-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457426528-15247-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/08/2016 09:42 AM, Shubhrajyoti Datta wrote:
> Add basic clock support. The clocks are requested at probe
> and released at remove.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-xilinx.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 3009121..7e12338 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -21,6 +21,7 @@
>  #include <linux/spi/spi_bitbang.h>
>  #include <linux/spi/xilinx_spi.h>
>  #include <linux/io.h>
> +#include <linux/clk.h>
>  
>  #define XILINX_SPI_MAX_CS	32
>  
> @@ -83,6 +84,7 @@ struct xilinx_spi {
>  	struct spi_bitbang bitbang;
>  	struct completion done;
>  	void __iomem	*regs;	/* virt. address of the control registers */
> +	struct clk *clk;
>  
>  	int		irq;
>  
> @@ -428,6 +430,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>  		goto put_master;
>  	}
>  
> +	xspi->clk = devm_clk_get(&pdev->dev, NULL);

Considering that the core has multiple clock inputs this should specify
which clock you are referencing here.

Also this breaks existing devicetrees which do not specify the clock...

- Lars
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
