From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: rockchip: fix warning of static check
Date: Tue, 22 Mar 2016 14:56:04 +0200
Message-ID: <56F140E4.8010906@mentor.com>
References: <1458646574-12830-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458646574-12830-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Shawn,

On 22.03.2016 13:36, Shawn Lin wrote:
> Let's improve the check with -EPROBE_DEFER, otherwise
> we may pass on null pointer to PTR_ERR. That causes the
> static checker warning: passing zero to 'PTR_ERR'.
> 
> Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  drivers/spi/spi-rockchip.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index bfeb0d4..2cb36d9 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -726,20 +726,24 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>  	rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
>  	if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
>  		/* Check tx to see if we need defer probing driver */
> -		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
> +		if (rs->dma_tx.ch == ERR_PTR(-EPROBE_DEFER)) {

won't it be easier to change dma_request_slave_channel() to
dma_request_chan() or dma_request_slave_channel_reason() and replace strange
IS_ERR_OR_NULL() check with IS_ERR() one?

AFAIU that's almost what has been suggested by Doug and it is a better
fix than this one published.

At the moment check for IS_ERR_OR_NULL() is too aggressive and quite
confusing, because dma_request_slave_channel() never returns NULL.

>  			ret = -EPROBE_DEFER;
>  			goto err_get_fifo_len;
>  		}
>  		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
> +		rs->dma_tx.ch = NULL;
>  	}
>  
>  	rs->dma_rx.ch = dma_request_slave_channel(rs->dev, "rx");
> -	if (!rs->dma_rx.ch) {
> -		if (rs->dma_tx.ch) {
> +	if (IS_ERR_OR_NULL(rs->dma_rx.ch)) {
> +		if (rs->dma_tx.ch == ERR_PTR(-EPROBE_DEFER)) {

Same as above.

>  			dma_release_channel(rs->dma_tx.ch);
>  			rs->dma_tx.ch = NULL;
> +			ret = -EPROBE_DEFER;
> +			goto err_get_fifo_len;
>  		}
>  		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
> +		rs->dma_rx.ch = NULL;
>  	}
>  
>  	if (rs->dma_tx.ch && rs->dma_rx.ch) {
> 

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
