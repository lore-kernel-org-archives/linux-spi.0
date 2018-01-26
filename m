From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Remove unused members from struct chip_data
Date: Fri, 26 Jan 2018 16:34:11 +0200
Message-ID: <1516977251.7000.1283.camel@linux.intel.com>
References: <20180126142449.18954-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180126142449.18954-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2018-01-26 at 16:24 +0200, Jarkko Nikula wrote:
> Local struct chip_data has two members that are not used:
> 
> - cs. Looks like was never used
> - enable_dma. Became unused by the commit f89a6d8f43eb ("spi: dw-mid:
> move
>   to use core SPI DMA mappings").

Good clean up!

Acked-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/spi/spi-dw.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index b217c22ff72f..211cc7d75bf8 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -30,13 +30,11 @@
>  
>  /* Slave spi_dev related */
>  struct chip_data {
> -	u8 cs;			/* chip select pin */
>  	u8 tmode;		/* TR/TO/RO/EEPROM */
>  	u8 type;		/* SPI/SSP/MicroWire */
>  
>  	u8 poll_mode;		/* 1 means use poll mode */
>  
> -	u8 enable_dma;
>  	u16 clk_div;		/* baud rate divider */
>  	u32 speed_hz;		/* baud rate */
>  	void (*cs_control)(u32 command);

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
