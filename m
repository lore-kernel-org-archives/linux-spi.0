From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/4 RESEND] spi: s3c64xx: simplify suspend / resume handlers
Date: Fri, 21 Aug 2015 10:05:15 +0900
Message-ID: <55D6794B.60800@samsung.com>
References: <55D63376.5070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <55D63376.5070607-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21.08.2015 05:07, Heiner Kallweit wrote:
> The runtime PM suspend / resume handlers take care of the enabling/
> disabling the clocks already. Therefore replace the duplicated
> clock handling with pm_runtime_force_suspend/resume.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changed:
> - Replaced pm_runtime_suspend/resume calls with their
>   .._force_.. equivalents.
> 
>  drivers/spi/spi-s3c64xx.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index edeac06..735b7f5 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1246,10 +1246,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (!pm_runtime_suspended(dev)) {
> -		clk_disable_unprepare(sdd->clk);
> -		clk_disable_unprepare(sdd->src_clk);
> -	}
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	sdd->cur_speed = 0; /* Output Clock is stopped */
>  
> @@ -1261,14 +1260,14 @@ static int s3c64xx_spi_resume(struct device *dev)
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
>  	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
> +	int ret;
>  
>  	if (sci->cfg_gpio)
>  		sci->cfg_gpio();
>  
> -	if (!pm_runtime_suspended(dev)) {
> -		clk_prepare_enable(sdd->src_clk);
> -		clk_prepare_enable(sdd->clk);
> -	}
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret < 0)
> +		return ret;

The logic of resume is changed.
Previously if device was runtime suspended when sleeping then clocks
would not be enabled during system resume.
Now device is always runtime suspended before and always runtime resumed
after. So this is different... but I think it's right approach with
current PM model:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Krzysztof


>  
>  	s3c64xx_spi_hwinit(sdd, sdd->port_id);
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
