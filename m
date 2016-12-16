From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [patch 2/3] spi: armada-3700: Set mode bits correctly
Date: Fri, 16 Dec 2016 11:30:01 +0100
Message-ID: <aacbdfad-e29f-9af0-215c-93ee026db570@free-electrons.com>
References: <20161216093325.GA13942@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161216093325.GA13942-mgFCXtclrQlZLf2FXnZxJA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Le 16/12/2016 à 10:33, Dan Carpenter a écrit :
> We set SPI_RX_DUAL twice instead of setting SPI_TX_DUAL.
>
> Fixes: 5762ab71eb24 ("spi: Add support for Armada 3700 SPI Controller")
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>
> diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> index 5c7508dc6f0b..40491be3365f 100644
> --- a/drivers/spi/spi-armada-3700.c
> +++ b/drivers/spi/spi-armada-3700.c
> @@ -825,7 +825,7 @@ static int a3700_spi_probe(struct platform_device *pdev)
>  	master->unprepare_message = a3700_spi_unprepare_message;
>  	master->set_cs = a3700_spi_set_cs;
>  	master->flags = SPI_MASTER_HALF_DUPLEX;
> -	master->mode_bits |= (SPI_RX_DUAL | SPI_RX_DUAL |
> +	master->mode_bits |= (SPI_RX_DUAL | SPI_TX_DUAL |
>  			      SPI_RX_QUAD | SPI_TX_QUAD);
>
>  	platform_set_drvdata(pdev, master);
>

Good catch,

Acked-by: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>


Thanks,
Romain
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
