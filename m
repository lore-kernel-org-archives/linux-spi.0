From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] mtd: m25p80: Revive dual read support
Date: Tue, 22 Apr 2014 23:48:08 +0800
Message-ID: <20140422154806.GA4230@localhost.localdomain>
References: <1398170732-19773-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398170732-19773-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Apr 22, 2014 at 02:45:31PM +0200, Geert Uytterhoeven wrote:
> Commit 03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI
> nor framework") accidentally removed support for Dual SPI read transfers.
> Add it back.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
>  drivers/mtd/devices/m25p80.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 1557d8f672c1..ed7e0a1bed3c 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -221,6 +221,8 @@ static int m25p_probe(struct spi_device *spi)
>  
>  	if (spi->mode & SPI_RX_QUAD)
>  		mode = SPI_NOR_QUAD;
> +	else if (spi->mode & SPI_RX_DUAL)
> +		mode = SPI_NOR_DUAL;
>  	ret = spi_nor_scan(nor, spi_get_device_id(spi), mode);
>  	if (ret)
>  		return ret;
sorry for the mistake.

Acked-by: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
