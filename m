From: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: fixed spin_lock usage inside atmel_spi_remove
Date: Tue, 19 Dec 2017 11:23:25 +0100
Message-ID: <16338851-85fe-27ab-3da6-7c37212b82b8@microchip.com>
References: <1513352417-15275-1-git-send-email-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        <Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513352417-15275-1-git-send-email-radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 15/12/2017 at 16:40, Radu Pirea wrote:
> The only part of atmel_spi_remove which needs to be atomic is hardware
> reset.
> 
> atmel_spi_stop_dma calls dma_terminate_all and this needs interrupts
> enabled.
> atmel_spi_release_dma calls dma_release_channel and dma_release_channel
> locks a mutex inside of spin_lock.
> 
> So the call of these functions can't be inside a spin_lock.
> 
> Reported-by: Jia-Ju Bai <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

Thanks Radu. Regards,
  Nicolas

> ---
>  drivers/spi/spi-atmel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index f95da36..6694709 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1661,12 +1661,12 @@ static int atmel_spi_remove(struct platform_device *pdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  
>  	/* reset the hardware and block queue progress */
> -	spin_lock_irq(&as->lock);
>  	if (as->use_dma) {
>  		atmel_spi_stop_dma(master);
>  		atmel_spi_release_dma(master);
>  	}
>  
> +	spin_lock_irq(&as->lock);
>  	spi_writel(as, CR, SPI_BIT(SWRST));
>  	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
>  	spi_readl(as, SR);
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
