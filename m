From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1] spi: dw: amend warning message
Date: Fri, 02 Jan 2015 16:11:08 +0200
Message-ID: <1420207868.12456.16.camel@linux.intel.com>
References: <1420207565-14712-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420207565-14712-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2015-01-02 at 16:06 +0200, Andy Shevchenko wrote:
> In case of warning message in ->probe() we have to use HW device name instead
> of master because last is not defined yet.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/spi/spi-dw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 7de8b50..83d17e38 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -659,7 +659,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	if (dws->dma_ops && dws->dma_ops->dma_init) {
>  		ret = dws->dma_ops->dma_init(dws);
>  		if (ret) {
> -			dev_warn(&master->dev, "DMA init failed\n");
> +			dev_warn(dev, "DMA init failed\n");
>  			dws->dma_inited = 0;
>  		} else {
>  			master->can_dma = dws->dma_ops->can_dma;

Oops, based on some WIP patches, though still applies smoothly on top of
recent linux-next.


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
