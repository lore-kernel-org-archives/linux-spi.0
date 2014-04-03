From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH] spi: s3c24xx: Convert to use devm_kzalloc
Date: Thu, 3 Apr 2014 14:26:25 +0100
Message-ID: <20140403132625.GR4400@trinity.fluff.org>
References: <1396237049.12196.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396237049.12196.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Mar 31, 2014 at 11:37:29AM +0800, Axel Lin wrote:
> Simplify the cleanup code.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Acked-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
>  drivers/spi/spi-s3c24xx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
> index bed2338..6db14e5 100644
> --- a/drivers/spi/spi-s3c24xx.c
> +++ b/drivers/spi/spi-s3c24xx.c
> @@ -183,7 +183,9 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
>  
>  	/* allocate settings on the first call */
>  	if (!cs) {
> -		cs = kzalloc(sizeof(struct s3c24xx_spi_devstate), GFP_KERNEL);
> +		cs = devm_kzalloc(&spi->dev,
> +				  sizeof(struct s3c24xx_spi_devstate),
> +				  GFP_KERNEL);
>  		if (!cs) {
>  			dev_err(&spi->dev, "no memory for controller state\n");
>  			return -ENOMEM;
> @@ -209,11 +211,6 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static void s3c24xx_spi_cleanup(struct spi_device *spi)
> -{
> -	kfree(spi->controller_state);
> -}
> -
>  static inline unsigned int hw_txbyte(struct s3c24xx_spi *hw, int count)
>  {
>  	return hw->tx ? hw->tx[count] : 0;
> @@ -543,7 +540,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>  	hw->bitbang.txrx_bufs      = s3c24xx_spi_txrx;
>  
>  	hw->master->setup  = s3c24xx_spi_setup;
> -	hw->master->cleanup = s3c24xx_spi_cleanup;
>  
>  	dev_dbg(hw->dev, "bitbang at %p\n", &hw->bitbang);
>  
> -- 
> 1.8.3.2
> 
> 
> 

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
