From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH 2/2] spi: spi-ep93xx: change PTR_ERR argument
Date: Sun, 30 Aug 2015 20:31:42 +0200
Message-ID: <55E34C0E.5000702@bfs.de>
References: <1440957911-7687-1-git-send-email-Julia.Lawall@lip6.fr> <1440957911-7687-3-git-send-email-Julia.Lawall@lip6.fr>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1440957911-7687-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



Am 30.08.2015 20:05, schrieb Julia Lawall:
> Apply PTR_ERR to the value that was recently assigned.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,y;
> @@
> 
> if (IS_ERR(x) || ...) {
>   ... when any
>       when != IS_ERR(...)
> (
>    PTR_ERR(x)
> |
> *  PTR_ERR(y)
> )
>   ... when any
> }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/spi/spi-ep93xx.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index bb00be8..1a7696c 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -567,7 +567,8 @@ static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
>  	txd = ep93xx_spi_dma_prepare(espi, DMA_MEM_TO_DEV);
>  	if (IS_ERR(txd)) {
>  		ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
> -		dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n", PTR_ERR(rxd));
> +		dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n",
> +			PTR_ERR(txd));
>  		msg->status = PTR_ERR(txd);
>  		return;
>  	}
>

I improve readability i would suggest:

ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
msg->status = PTR_ERR(txd);
dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n",msg->status):
return;


just my 2 cents,

re,
 wh
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
