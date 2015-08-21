From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 4/4 RESEND] spi: s3c64xx: replace clock disabling with
 runtime PM suspend call in remove function
Date: Fri, 21 Aug 2015 10:17:07 +0900
Message-ID: <55D67C13.8000909@samsung.com>
References: <55D63457.5060901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <55D63457.5060901@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 21.08.2015 05:11, Heiner Kallweit wrote:
> Simplify s3c64xx_spi_remove by replacing the clock disabling with calling
> runtime PM suspend which does the same.
> Waking up the device if it was suspended wouldn't be strictly needed
> for this driver but using pm_runtime_get_sync is cleaner and makes
> s3c64xx_spi_remove more consistent with the runtime PM handling in
> s3c64xx_spi_setup.
> 
> pm_runtime_force_suspend does most of the work for us:
> disabling the clocks, disabling runtime PM and setting it to
> "suspended" state.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Changed:
> - Added to the patch set
> 
>  drivers/spi/spi-s3c64xx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 735b7f5..4a91a6c 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1225,13 +1225,12 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
>  	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
>  	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
>  
> -	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
>  
>  	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
>  
> -	clk_disable_unprepare(sdd->src_clk);
> -
> -	clk_disable_unprepare(sdd->clk);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_force_suspend(&pdev->dev);
>  
>  	return 0;
>  }

The get+put_noidle looks good. But replacing this with
pm_runtime_force_suspend() does not.

The device is going to be removed so we do not want to do anything with
it any more. We do not want to suspend it. Probably this would work fine
but it is not intuitive. I think it's better to just:
get(), disable(), set_suspended(), put_noidle()

Best regards,
Krzysztof
