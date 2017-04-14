From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: atmel: add deepest PM support to SAMA5D2
Date: Fri, 14 Apr 2017 12:35:49 +0200
Message-ID: <20170414103549.szcy5ev26psnuu4i@piout.net>
References: <20170414082243.23002-1-quentin.schulz@free-electrons.com>
 <20170414082243.23002-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170414082243.23002-2-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 14/04/2017 at 10:22:43 +0200, Quentin Schulz wrote:
> This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
> SoC's SPI controller.
> 
> When resuming from deepest state, it is required to restore MR register
> as the registers are lost since VDD core has been shut down when
> entering deepest state on the SAMA5D2.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

> ---
> 
> v2:
>   - fix commit log explanation on why restoring the registers is required
>   after resuming from deepest state,
> 
>  drivers/spi/spi-atmel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 247d920..1eb83c9 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1702,8 +1702,17 @@ static int atmel_spi_suspend(struct device *dev)
>  static int atmel_spi_resume(struct device *dev)
>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
> +	struct atmel_spi *as = spi_master_get_devdata(master);
>  	int ret;
>  
> +	ret = clk_prepare_enable(as->clk);
> +	if (ret)
> +		return ret;
> +
> +	atmel_spi_init(as);
> +
> +	clk_disable_unprepare(as->clk);
> +
>  	if (!pm_runtime_suspended(dev)) {
>  		ret = atmel_spi_runtime_resume(dev);
>  		if (ret)
> -- 
> 2.9.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
