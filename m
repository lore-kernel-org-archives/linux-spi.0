From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RFT] spi: dw: Fix off-by-one for checking fifo depth
Date: Fri, 19 Dec 2014 13:46:07 +0200
Message-ID: <1418989567.17201.71.camel@linux.intel.com>
References: <1418976099.23257.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418976099.23257.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2014-12-19 at 16:01 +0800, Axel Lin wrote:
> The fifo depth could be from 2 to 256 from HW spec, so fix off-by-one for
> checking fifo depth.
> Without this patch, fifo is 258 after for loop iteration for the "no-match"
> case. So below line does not catch the "no-match" case.
>         dws->fifo_len = (fifo == 257) ? 0 : fifo;

Seems reasonable, but never tried because in case of Medfield device we
have fifo size defined.

I would try this in January.

> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
> Hi,
> I don't have this hardware handy, so please test it.
> 
> BTW, I'm wondering if it make sense to set dws->fifo_len to 0.
> Isn't it suppose to be 2 ~ 256?

For me it sounds like we have broken HW or wrong configuration (of the
driver). If kernel would have crashed in that case the investigation has
to be done.

Maybe warning message or even error if FIFO size doesn't lie in the
range?

> 
> Thanks.
>  drivers/spi/spi-dw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index d0d5542..74b27479 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -621,7 +621,7 @@ static void spi_hw_init(struct dw_spi *dws)
>  	if (!dws->fifo_len) {
>  		u32 fifo;
>  
> -		for (fifo = 2; fifo <= 257; fifo++) {
> +		for (fifo = 2; fifo <= 256; fifo++) {
>  			dw_writew(dws, DW_SPI_TXFLTR, fifo);
>  			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
>  				break;


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
