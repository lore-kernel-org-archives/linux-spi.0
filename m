From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] spi: sh-msiof: Use correct device for DMA mapping with IOMMU
Date: Wed, 09 Jul 2014 23:38:06 +0200
Message-ID: <70265909.OPtNRHeAkP@avalon>
References: <1404901277-31107-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1404901277-31107-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 09 July 2014 12:21:17 Geert Uytterhoeven wrote:
> To function correctly in the presence of an IOMMU, the DMA buffers must be
> mapped using the DMA channel's device instead of the MSIOF platform
> device's device.

Shouldn't you also update the dma_unmap_single() calls ?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
>  drivers/spi/spi-sh-msiof.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 9922ed3a4441..4f0f1cbc92ef 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -1026,12 +1026,14 @@ static int sh_msiof_request_dma(struct
> sh_msiof_spi_priv *p) if (!p->rx_dma_page)
>  		goto free_tx_page;
> 
> -	p->tx_dma_addr = dma_map_single(dev, p->tx_dma_page, PAGE_SIZE,
> +	p->tx_dma_addr = dma_map_single(&master->dma_tx->dev->device,
> +					p->tx_dma_page, PAGE_SIZE,
>  					DMA_TO_DEVICE);
>  	if (dma_mapping_error(dev, p->tx_dma_addr))
>  		goto free_rx_page;
> 
> -	p->rx_dma_addr = dma_map_single(dev, p->rx_dma_page, PAGE_SIZE,
> +	p->rx_dma_addr = dma_map_single(&master->dma_rx->dev->device,
> +					p->rx_dma_page, PAGE_SIZE,
>  					DMA_FROM_DEVICE);
>  	if (dma_mapping_error(dev, p->rx_dma_addr))
>  		goto unmap_tx_page;

-- 
Regards,

Laurent Pinchart

