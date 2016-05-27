From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: use DMA by default if supported
Date: Fri, 27 May 2016 21:21:32 +0200
Message-ID: <87oa7rgvcz.fsf@belgarion.home>
References: <1464375468-11510-1-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org,
	haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464375468-11510-1-git-send-email-dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org> (Dan
	O'Donovan's message of "Fri, 27 May 2016 19:57:48 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org> writes:

Let me add Jarkko and Mika to the review, they were active in the driver's DMA
area lately.

Cheers.

--
Robert

[1] Dan's patch
> Currently, even if the PXA2xx SPI master supports DMA, it won't be
> enabled unless (i) the slave device is enumerated through ACPI, or
> (ii) the slave device is registered with board-specific
> controller_data specified.  Even then, there isn't a field in the
> controller_data that explicitly enables dma - it just gets enabled
> if the master supports it and controller_data is non-NULL.
>
> This means that drivers which register SPI devices on a bus without
> awareness of this controller cannot avail of DMA performance gains.
>
> This patch allows DMA transfers to be used if supported.
>
> Signed-off-by: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-pxa2xx.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index fe07c05..27e0307 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1240,7 +1240,7 @@ static int setup(struct spi_device *spi)
>  			chip->frm = spi->chip_select;
>  		} else
>  			chip->gpio_cs = -1;
> -		chip->enable_dma = 0;
> +		chip->enable_dma = drv_data->master_info->enable_dma;
>  		chip->timeout = TIMOUT_DFLT;
>  	}
>  
> @@ -1259,17 +1259,9 @@ static int setup(struct spi_device *spi)
>  			tx_hi_thres = chip_info->tx_hi_threshold;
>  		if (chip_info->rx_threshold)
>  			rx_thres = chip_info->rx_threshold;
> -		chip->enable_dma = drv_data->master_info->enable_dma;
>  		chip->dma_threshold = 0;
>  		if (chip_info->enable_loopback)
>  			chip->cr1 = SSCR1_LBM;
> -	} else if (ACPI_HANDLE(&spi->dev)) {
> -		/*
> -		 * Slave devices enumerated from ACPI namespace don't
> -		 * usually have chip_info but we still might want to use
> -		 * DMA with them.
> -		 */
> -		chip->enable_dma = drv_data->master_info->enable_dma;
>  	}
>  
>  	chip->lpss_rx_threshold = SSIRF_RxThresh(rx_thres);
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
