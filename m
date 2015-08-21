From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4 RESEND] spi: s3c64xx: clean up runtime PM if driver
 registration fails
Date: Fri, 21 Aug 2015 09:57:54 +0900
Message-ID: <55D67792.20000@samsung.com>
References: <55D6324F.7070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <55D6324F.7070601-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21.08.2015 05:02, Heiner Kallweit wrote:
> Fix missing runtime PM cleanup if driver registration fails.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changed:
> - Separated fix from added functionality
> 
>  drivers/spi/spi-s3c64xx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Looks good, thanks:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Krzysztof

> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index cd1cfac..8a6ab88 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1186,7 +1186,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
> -		goto err3;
> +		goto err4;
>  	}
>  
>  	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
> @@ -1197,6 +1197,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err4:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
>  err3:
>  	clk_disable_unprepare(sdd->src_clk);
>  err2:
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
