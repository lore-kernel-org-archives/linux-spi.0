From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/12] spi: sh-msiof: Fix leaking of unused DMA descriptors
Date: Thu, 07 Aug 2014 02:07:44 +0200
Message-ID: <1888537.ONCuOO6jck@avalon>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be> <1407329949-5695-7-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1407329949-5695-7-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 06 August 2014 14:59:03 Geert Uytterhoeven wrote:
> If dmaengine_prep_slave_sg() or dmaengine_submit() fail, we may leak
> unused DMA descriptors.
> 
> As per Documentation/dmaengine.txt, once a DMA descriptor has been
> obtained, it must be submitted. Hence:
>   - First prepare and submit all DMA descriptors,
>   - Prepare the SPI controller for DMA,
>   - Start DMA by calling dma_async_issue_pending(),
>   - Make sure to call dmaengine_terminate_all() on all descriptors that
>     haven't completed.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/spi/spi-sh-msiof.c | 71 ++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 2a4354dcd661..887c2084130f 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -636,48 +636,38 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv
> *p, const void *tx, dma_cookie_t cookie;
>  	int ret;
> 
> -	if (tx) {
> -		ier_bits |= IER_TDREQE | IER_TDMAE;
> -		dma_sync_single_for_device(p->master->dma_tx->device->dev,
> -					   p->tx_dma_addr, len, DMA_TO_DEVICE);
> -		desc_tx = dmaengine_prep_slave_single(p->master->dma_tx,
> -					p->tx_dma_addr, len, DMA_TO_DEVICE,
> -					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> -		if (!desc_tx)
> -			return -EAGAIN;
> -	}
> -
> +	/* First prepare and submit the DMA request(s), as this may fail */
>  	if (rx) {
>  		ier_bits |= IER_RDREQE | IER_RDMAE;
>  		desc_rx = dmaengine_prep_slave_single(p->master->dma_rx,
>  					p->rx_dma_addr, len, DMA_FROM_DEVICE,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> -		if (!desc_rx)
> -			return -EAGAIN;
> -	}
> -
> -	/* 1 stage FIFO watermarks for DMA */
> -	sh_msiof_write(p, FCTR, FCTR_TFWM_1 | FCTR_RFWM_1);
> -
> -	/* setup msiof transfer mode registers (32-bit words) */
> -	sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
> -
> -	sh_msiof_write(p, IER, ier_bits);
> -
> -	reinit_completion(&p->done);
> +		if (!desc_rx) {
> +			ret = -EAGAIN;
> +			goto no_dma_rx;

You could return -EAGAIN directly here.

> +		}
> 
> -	if (rx) {
>  		desc_rx->callback = sh_msiof_dma_complete;
>  		desc_rx->callback_param = p;
>  		cookie = dmaengine_submit(desc_rx);
>  		if (dma_submit_error(cookie)) {
>  			ret = cookie;
> -			goto stop_ier;
> +			goto no_dma_rx;
>  		}
> -		dma_async_issue_pending(p->master->dma_rx);
>  	}
> 
>  	if (tx) {
> +		ier_bits |= IER_TDREQE | IER_TDMAE;
> +		dma_sync_single_for_device(p->master->dma_tx->device->dev,
> +					   p->tx_dma_addr, len, DMA_TO_DEVICE);
> +		desc_tx = dmaengine_prep_slave_single(p->master->dma_tx,
> +					p->tx_dma_addr, len, DMA_TO_DEVICE,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +		if (!desc_tx) {
> +			ret = -EAGAIN;
> +			goto no_dma_tx;
> +		}
> +
>  		if (rx) {
>  			/* No callback */
>  			desc_tx->callback = NULL;
> @@ -688,15 +678,30 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv
> *p, const void *tx, cookie = dmaengine_submit(desc_tx);
>  		if (dma_submit_error(cookie)) {
>  			ret = cookie;
> -			goto stop_rx;
> +			goto no_dma_tx;
>  		}
> -		dma_async_issue_pending(p->master->dma_tx);
>  	}
> 
> +	/* 1 stage FIFO watermarks for DMA */
> +	sh_msiof_write(p, FCTR, FCTR_TFWM_1 | FCTR_RFWM_1);
> +
> +	/* setup msiof transfer mode registers (32-bit words) */
> +	sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
> +
> +	sh_msiof_write(p, IER, ier_bits);
> +
> +	reinit_completion(&p->done);
> +
> +	/* Now start DMA */
> +	if (tx)
> +		dma_async_issue_pending(p->master->dma_rx);

if (tx) issue pending on dma_rx ? Shouldn't is be tx -> tx and rx -> rx below 
? I would also start rx before tx, but that might be an unnecessary 
precaution.

> +	if (rx)
> +		dma_async_issue_pending(p->master->dma_tx);
> +
>  	ret = sh_msiof_spi_start(p, rx);
>  	if (ret) {
>  		dev_err(&p->pdev->dev, "failed to start hardware\n");
> -		goto stop_tx;
> +		goto stop_dma;
>  	}
> 
>  	/* wait for tx fifo to be emptied / rx fifo to be filled */
> @@ -726,14 +731,14 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv
> *p, const void *tx, stop_reset:
>  	sh_msiof_reset_str(p);
>  	sh_msiof_spi_stop(p, rx);
> -stop_tx:
> +stop_dma:
>  	if (tx)
>  		dmaengine_terminate_all(p->master->dma_tx);
> -stop_rx:
> +no_dma_tx:
>  	if (rx)
>  		dmaengine_terminate_all(p->master->dma_rx);
> -stop_ier:
>  	sh_msiof_write(p, IER, 0);
> +no_dma_rx:
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart

