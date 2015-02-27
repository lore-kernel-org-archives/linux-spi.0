From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 2/3] spi: dw: program registers as soon as possible
Date: Fri, 27 Feb 2015 22:11:21 +0200
Message-ID: <1425067881.14897.105.camel@linux.intel.com>
References: <1425054977-9859-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1425054977-9859-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425054977-9859-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2015-02-27 at 18:36 +0200, Andy Shevchenko wrote:
> This patch refactors the code in pump_transfers() to reprogram the registers
> immediately when we have a new configuration data. The behaviour is slightly
> modified:
>  - chip is always disabled and reenabled
>  - CTRL0 is always reprogrammed
> 
> This change allows to do a further refactoring and simplier conversion to use
> SPI core DMA routines in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

>  	/*
>  	 * Interrupt mode
>  	 * we only need set the TXEI IRQ, as TX/RX always happen syncronizely
> +	 * Set the interrupt mask, for poll mode just disable all interrupts.
>  	 */
> -	if (!dws->dma_mapped && !chip->poll_mode) {
> +	if (chip->poll_mode) {
> +		spi_mask_intr(dws, 0xff);
> +	} else if (dws->dma_mapped) {
> +		spi_mask_intr(dws, 0xff);
> +	} else {
>  		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
> +		dw_writew(dws, DW_SPI_TXFLTR, txlevel);
>  
> +		spi_mask_intr(dws, 0xff);
>  		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
>  			 SPI_INT_RXUI | SPI_INT_RXOI;
> +		spi_umask_intr(dws, imask);
> +
>  		dws->transfer_handler = interrupt_transfer;
>  	}

Perhaps I have to revisit this piece of code.


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
