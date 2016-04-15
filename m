From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: dln2: Pass of_node to spi master
Date: Fri, 15 Apr 2016 15:19:35 +0300
Message-ID: <20160415121935.GD2058@lpalcu-desk>
References: <692686e5329a437499fbfb2c235e049979b415a3.1460722225.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tiberiu Breana <tiberiu.a.breana-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <692686e5329a437499fbfb2c235e049979b415a3.1460722225.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Apr 15, 2016 at 03:10:52PM +0300, Crestez Dan Leonard wrote:
> This allows defining SPI devices connected to a DLN2 using devicetree.
> 
> This already works for i2c because of a similar patch:
> 3b10db23: i2c: dln2: set the device tree node of the adapter
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/spi/spi-dln2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
> index 3b7d91d..4e8a862 100644
> --- a/drivers/spi/spi-dln2.c
> +++ b/drivers/spi/spi-dln2.c
> @@ -683,6 +683,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
>  	struct spi_master *master;
>  	struct dln2_spi *dln2;
>  	struct dln2_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  
>  	master = spi_alloc_master(&pdev->dev, sizeof(*dln2));
> @@ -700,6 +701,8 @@ static int dln2_spi_probe(struct platform_device *pdev)
>  	}
>  
>  	dln2->master = master;
> +	dln2->master->dev.parent = dev;
> +	dln2->master->dev.of_node = dev->of_node;
>  	dln2->pdev = pdev;
>  	dln2->port = pdata->port;
>  	/* cs/mode can never be 0xff, so the first transfer will set them */
> -- 
> 2.5.5
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
