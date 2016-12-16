From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [patch 3/3] spi: armada-3700: Remove unnecessary condition
Date: Fri, 16 Dec 2016 11:30:22 +0100
Message-ID: <2fe5a622-4071-d44a-22c5-521d263e0e5a@free-electrons.com>
References: <20161216093359.GB13942@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161216093359.GB13942-mgFCXtclrQlZLf2FXnZxJA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Le 16/12/2016 à 10:33, Dan Carpenter a écrit :
> We checked that "a3700_spi->wait_mask & cause" was set at the beginning
> of the function so we don't need to check again here.
>
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>
> diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> index 5c7508dc6f0b..e98d464b3ff0 100644
> --- a/drivers/spi/spi-armada-3700.c
> +++ b/drivers/spi/spi-armada-3700.c
> @@ -340,8 +340,7 @@ static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
>  	spireg_write(a3700_spi, A3700_SPI_INT_STAT_REG, cause);
>
>  	/* Wake up the transfer */
> -	if (a3700_spi->wait_mask & cause)
> -		complete(&a3700_spi->done);
> +	complete(&a3700_spi->done);
>
>  	return IRQ_HANDLED;
>  }
>


Good catch,

Acked-by: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>


Thanks,
Romain

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
