From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx: Convert to let spi core validate bits_per_word
Date: Thu, 20 Feb 2014 15:54:17 +0100
Message-ID: <5601bea5-46eb-4a30-8111-9bbb20149c4b@CH1EHSMHS040.ehs.local>
References: <1392383203.31961.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392383203.31961.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/14/2014 02:06 PM, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.
> 
> spi_bitbang requires custom setup_transfer() to be defined if there is a
> custom txrx_bufs(). Thus keep the empty xilinx_spi_setup_transfer() function
> in the code.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-xilinx.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index e6cd111..66dbefc 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -208,26 +208,11 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
>  }
>  
>  /* spi_bitbang requires custom setup_transfer() to be defined if there is a
> - * custom txrx_bufs(). We have nothing to setup here as the SPI IP block
> - * supports 8 or 16 bits per word which cannot be changed in software.
> - * SPI clock can't be changed in software either.
> - * Check for correct bits per word. Chip select delay calculations could be
> - * added here as soon as bitbang_work() can be made aware of the delay value.
> + * custom txrx_bufs().
>   */
>  static int xilinx_spi_setup_transfer(struct spi_device *spi,
>  		struct spi_transfer *t)
>  {
> -	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
> -	u8 bits_per_word;
> -
> -	bits_per_word = (t && t->bits_per_word)
> -			 ? t->bits_per_word : spi->bits_per_word;
> -	if (bits_per_word != xspi->bits_per_word) {
> -		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
> -			__func__, bits_per_word);
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -406,6 +391,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>  		xspi->write_fn = xspi_write32_be;
>  	}
>  
> +	master->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
>  	xspi->bits_per_word = bits_per_word;
>  	if (xspi->bits_per_word == 8) {
>  		xspi->tx_fn = xspi_tx8;
> 

Acked-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Thanks,
Michal


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
