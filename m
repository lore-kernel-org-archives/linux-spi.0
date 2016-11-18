From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: spi-fsl-dspi: Fix SPI transfer issue when using
 multiple SPI_IOC_MESSAGE
Date: Thu, 17 Nov 2016 16:52:43 -0800
Message-ID: <b92d7535f6c34a2b011a1c7c75c7f6fe@agner.ch>
References: <cover.1479384571.git.maitysanchayan@gmail.com>
 <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479384571.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bbdbc8df434dd2af74eb351b799a2812a1c1967e.1479384571.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2016-11-17 04:16, Sanchayan Maity wrote:
> Current DMA implementation had a bug where the DMA transfer would
> exit the loop in dspi_transfer_one_message after the completion of
> a single transfer. This results in a multi message transfer submitted
> with SPI_IOC_MESSAGE to terminate incorrectly without an error.

Looks good to me:

Reviewed-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>

> 
> Signed-off-by: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index bc64700..b1ee1f5 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -714,7 +714,7 @@ static int dspi_transfer_one_message(struct
> spi_master *master,
>  				SPI_RSER_TFFFE | SPI_RSER_TFFFD |
>  				SPI_RSER_RFDFE | SPI_RSER_RFDFD);
>  			status = dspi_dma_xfer(dspi);
> -			goto out;
> +			break;
>  		default:
>  			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
>  				trans_mode);
> @@ -722,9 +722,13 @@ static int dspi_transfer_one_message(struct
> spi_master *master,
>  			goto out;
>  		}
>  
> -		if (wait_event_interruptible(dspi->waitq, dspi->waitflags))
> -			dev_err(&dspi->pdev->dev, "wait transfer complete fail!\n");
> -		dspi->waitflags = 0;
> +		if (trans_mode != DSPI_DMA_MODE) {
> +			if (wait_event_interruptible(dspi->waitq,
> +						dspi->waitflags))
> +				dev_err(&dspi->pdev->dev,
> +					"wait transfer complete fail!\n");
> +			dspi->waitflags = 0;
> +		}
>  
>  		if (transfer->delay_usecs)
>  			udelay(transfer->delay_usecs);
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
