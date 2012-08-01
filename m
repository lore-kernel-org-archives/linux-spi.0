From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix the error handling in probe
Date: Wed, 1 Aug 2012 08:07:13 -0700
Message-ID: <20120801150713.GB15630@roeck-us.net>
References: <1343813788-19165-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1343813788-19165-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 01, 2012 at 03:06:28PM +0530, Shubhrajyoti D wrote:
> The kfree() is taken care of by the spi core (spi_master_release() function)
> that is called once the last reference to the underlying struct device has
> been released. So the driver need not call kfree.
> 
> Also the put was missed in some of the error handling fix the same.
> There by fixing the missing device_put in some of the error paths.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>

Reported-by: may be better here.

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I suspect that "spi_master_put(master);" may also be missing in
omap2_mcspi_remove(), but we'll need someone to confirm that.

Thanks,
Guenter

> ---
>  drivers/spi/spi-omap2-mcspi.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 7d46b15..b5035e2 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1203,18 +1203,16 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
>  
>  	status = spi_register_master(master);
>  	if (status < 0)
> -		goto err_spi_register;
> +		goto disable_pm;
>  
>  	return status;
>  
> -err_spi_register:
> -	spi_master_put(master);
>  disable_pm:
>  	pm_runtime_disable(&pdev->dev);
>  dma_chnl_free:
>  	kfree(mcspi->dma_channels);
>  free_master:
> -	kfree(master);
> +	spi_master_put(master);
>  	platform_set_drvdata(pdev, NULL);
>  	return status;
>  }
> -- 
> 1.7.5.4
> 
> 
