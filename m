From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mips: bcm63xx: spi: Fix checkpatch.pl warnings
Date: Mon, 19 Jun 2017 10:21:51 -0700
Message-ID: <2d01bbe8-33bd-9aea-8906-0fe54bb2c334@gmail.com>
References: <1497890980-4334-1-git-send-email-aravind.thk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497890980-4334-1-git-send-email-aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/19/2017 09:49 AM, Aravind Thokala wrote:
> This patch fixes the checkpatch.pl warnings on the driver
> file.
> 
> Signed-off-by: Aravind Thokala <aravind.thk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The subject should be spi/bcm63xx: Fix checkpatch warnings to be
consistent with previous submissions done to that file.

With that:

Reviewed-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/spi/spi-bcm63xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 247f71b..84c7356 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -147,7 +147,7 @@ struct bcm63xx_spi {
>  
>  	/* Platform data */
>  	const unsigned long	*reg_offsets;
> -	unsigned		fifo_size;
> +	unsigned int		fifo_size;
>  	unsigned int		msg_type_shift;
>  	unsigned int		msg_ctl_width;
>  
> @@ -191,7 +191,7 @@ static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
>  #endif
>  }
>  
> -static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
> +static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
>  	{ 20000000, SPI_CLK_20MHZ },
>  	{ 12500000, SPI_CLK_12_50MHZ },
>  	{  6250000, SPI_CLK_6_250MHZ },
> 


-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
