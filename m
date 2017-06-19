From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] spi/bcm63xx: Fix checkpatch warnings
Date: Mon, 19 Jun 2017 13:07:07 -0700
Message-ID: <1497902827.8495.52.camel@perches.com>
References: <1497896268-5613-1-git-send-email-aravind.thk@gmail.com>
         <1497901338.8495.50.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497901338.8495.50.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2017-06-19 at 12:42 -0700, Joe Perches wrote:
> On Mon, 2017-06-19 at 23:47 +0530, Aravind Thokala wrote:
> > This patch fixes the checkpatch.pl warnings on the driver
> > file.
> []
> > diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> 
> []
> > @@ -191,7 +191,7 @@ static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
> >  #endif
> >  }
> >  
> > -static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
> > +static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
> >  	{ 20000000, SPI_CLK_20MHZ },
> >  	{ 12500000, SPI_CLK_12_50MHZ },
> >  	{  6250000, SPI_CLK_6_250MHZ },
> 
> It's probably better to change this array into a struct
> to make the indexing more obvious.
> 
> Also the SPI_CLK_MASK uses are a bit obscure.
> 
> Perhaps:
> ---
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
[]
> -static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
> +static const struct {
> +	unsigned int speed;
> +	unsigned int index;

Maybe index should be u8 as the one use
it's assigned to is also u8

> +} bcm63xx_spi_freq_table[] = {
>  	{ 20000000, SPI_CLK_20MHZ },
>  	{ 12500000, SPI_CLK_12_50MHZ },
>  	{  6250000, SPI_CLK_6_250MHZ },
> @@ -213,8 +216,8 @@ static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
>  
>  	/* Find the closest clock configuration */
>  	for (i = 0; i < SPI_CLK_MASK; i++) {
> -		if (t->speed_hz >= bcm63xx_spi_freq_table[i][0]) {
> -			clk_cfg = bcm63xx_spi_freq_table[i][1];
> +		if (t->speed_hz >= bcm63xx_spi_freq_table[i].speed) {
> +			clk_cfg = bcm63xx_spi_freq_table[i].index;
>  			break;
>  		}
>  	}
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
