From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [patch 1/3] spi: armada-3700: Signedness bug in probe
Date: Fri, 16 Dec 2016 10:36:29 +0100
Message-ID: <e1c6a534-6b6c-a83f-390f-b65654ff2bcf@free-electrons.com>
References: <20161216082443.GA7031@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161216082443.GA7031-mgFCXtclrQlZLf2FXnZxJA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Le 16/12/2016 à 10:33, Dan Carpenter a écrit :
> We need "irq" to be an int because platform_get_irq() returns negative
> error codes.
>
> Fixes: 5762ab71eb24 ("spi: Add support for Armada 3700 SPI Controller")
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>
> diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> index e89da0af45d2..5c7508dc6f0b 100644
> --- a/drivers/spi/spi-armada-3700.c
> +++ b/drivers/spi/spi-armada-3700.c
> @@ -108,7 +108,7 @@ struct a3700_spi {
>  	struct spi_master *master;
>  	void __iomem *base;
>  	struct clk *clk;
> -	unsigned int irq;
> +	int irq;
>  	unsigned int flags;
>  	bool xmit_data;
>  	const u8 *tx_buf;
>

It is already fixed, see 
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=f6f0083cca66e673cca6fa26b52b107b5570081d

And no we cannot just replace the type of the irq field like this 
because devm_request_irq/request_irq require an unsigned int as "irq" 
parameter.

Romain

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
