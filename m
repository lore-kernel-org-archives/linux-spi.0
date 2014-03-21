From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: fix spi-atmel.c printk format warnings
Date: Fri, 21 Mar 2014 17:02:31 +0100
Message-ID: <532C6297.5050704@atmel.com>
References: <532C6085.9070203@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Andrew Morton" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <532C6085.9070203-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21/03/2014 16:53, Randy Dunlap :
> From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> 
> Fix printk format warning by using %p extension 'ad' for dma_addr_t.
> 
> drivers/spi/spi-atmel.c:1228:3: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat]
> drivers/spi/spi-atmel.c:1228:3: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t' [-Wformat]
> 
> Signed-off-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/spi/spi-atmel.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> I thought that a patch for this was already posted but I can't find it...
> Applies to mainline.
> 
> --- linux-next-20140321.orig/drivers/spi/spi-atmel.c
> +++ linux-next-20140321/drivers/spi/spi-atmel.c
> @@ -1226,10 +1226,10 @@ static int atmel_spi_transfer_one_messag
>  
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  		dev_dbg(&spi->dev,
> -			"  xfer %p: len %u tx %p/%08x rx %p/%08x\n",
> +			"  xfer %p: len %u tx %p/%pad rx %p/%pad\n",
>  			xfer, xfer->len,
> -			xfer->tx_buf, xfer->tx_dma,
> -			xfer->rx_buf, xfer->rx_dma);
> +			xfer->tx_buf, &xfer->tx_dma,
> +			xfer->rx_buf, &xfer->rx_dma);
>  	}
>  
>  msg_done:
> 
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
