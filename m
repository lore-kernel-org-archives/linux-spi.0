From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Compatibility with direction which is used in samsung DMA operation
Date: Fri, 09 Mar 2012 14:58:56 -0700
Message-ID: <20120309215856.802E73E0880@localhost>
References: <000501cce62e$87b4d100$971e7300$%kim@samsung.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Kyoungil Kim' <ki0351.kim@samsung.com>
To: Kyoungil Kim <ki0351.kim@samsung.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000501cce62e$87b4d100$971e7300$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 08 Feb 2012 15:54:40 +0900, Kyoungil Kim <ki0351.kim@samsung.com> wrote:
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>

I'm sorry, I don't understand the reason for the patch.  Please help a poor
maintainer out and include the reason *why* the patch is needed in the
commit text.

(repost with a proper commit log message).

g.

> ---
>  drivers/spi/spi-s3c64xx.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index f3b7f6a..1972377 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -239,7 +239,7 @@ static void s3c64xx_spi_dmacb(void *data)
>  	struct s3c64xx_spi_dma_data *dma = data;
>  	unsigned long flags;
>  
> -	if (dma->direction == DMA_FROM_DEVICE)
> +	if (dma->direction == DMA_DEV_TO_MEM)
>  		sdd = container_of(data,
>  			struct s3c64xx_spi_driver_data, rx_dma);
>  	else
> @@ -248,7 +248,7 @@ static void s3c64xx_spi_dmacb(void *data)
>  
>  	spin_lock_irqsave(&sdd->lock, flags);
>  
> -	if (dma->direction == DMA_FROM_DEVICE) {
> +	if (dma->direction == DMA_DEV_TO_MEM) {
>  		sdd->state &= ~RXBUSY;
>  		if (!(sdd->state & TXBUSY))
>  			complete(&sdd->xfer_completion);
> @@ -268,7 +268,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>  	struct samsung_dma_prep info;
>  	struct samsung_dma_config config;
>  
> -	if (dma->direction == DMA_FROM_DEVICE) {
> +	if (dma->direction == DMA_DEV_TO_MEM) {
>  		sdd = container_of((void *)dma,
>  			struct s3c64xx_spi_driver_data, rx_dma);
>  
> @@ -1028,9 +1028,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  	sdd->pdev = pdev;
>  	sdd->sfr_start = mem_res->start;
>  	sdd->tx_dma.dmach = dmatx_res->start;
> -	sdd->tx_dma.direction = DMA_TO_DEVICE;
> +	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
>  	sdd->rx_dma.dmach = dmarx_res->start;
> -	sdd->rx_dma.direction = DMA_FROM_DEVICE;
> +	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
>  
>  	sdd->cur_bpw = 8;
>  
> -- 
> 1.7.1
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
