From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: Remove unused pointer in
 omap1_spi100k_txrx_pio()
Date: Mon, 10 Feb 2014 08:54:30 +0900
Message-ID: <002e01cf25f2$45dbf4b0$d193de10$%han@samsung.com>
References: <20140208190223.45d1dcf8@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'H Hartley Sweeten' <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	'Michal Nazarewicz' <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Christian Engelmayer' <cengelma-RbZlAiThDcE@public.gmane.org>,
	'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140208190223.45d1dcf8@spike>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sunday, February 09, 2014 3:02 AM, Christian Engelmayer wrote:
> 
> Remove unused devdata pointer 'spi100k' in function omap1_spi100k_txrx_pio().
> 
> Detected by Coverity: CID 1077869.
> 
> Signed-off-by: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>

Reviewed-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Jingoo Han

> ---
> Applies against v3.14-rc1 as well as branch for-next in tree
> git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> ---
>  drivers/spi/spi-omap-100k.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
> index 0d32054..8eaf0cd 100644
> --- a/drivers/spi/spi-omap-100k.c
> +++ b/drivers/spi/spi-omap-100k.c
> @@ -204,12 +204,10 @@ static void omap1_spi100k_force_cs(struct omap1_spi100k *spi100k, int enable)
>  static unsigned
>  omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
>  {
> -	struct omap1_spi100k    *spi100k;
>  	struct omap1_spi100k_cs *cs = spi->controller_state;
>  	unsigned int            count, c;
>  	int                     word_len;
> 
> -	spi100k = spi_master_get_devdata(spi->master);
>  	count = xfer->len;
>  	c = count;
>  	word_len = cs->word_len;
> --
> 1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
