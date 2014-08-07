From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] spi: sh-msiof: Return early in sh_msiof_dma_once() where possible
Date: Thu, 07 Aug 2014 14:52:16 +0200
Message-ID: <4241726.9GIeKRM7S3@avalon>
References: <CAMuHMdUd3OKqDwhLSCMW-rEQSnWky+saN5TgC005rkmNPfEL+g@mail.gmail.com> <1407413263-20177-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1407413263-20177-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Thursday 07 August 2014 14:07:42 Geert Uytterhoeven wrote:
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Feel free to fold into commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
> ("spi: sh-msiof: Fix leaking of unused DMA descriptors")
> ---
>  drivers/spi/spi-sh-msiof.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 887c2084130f..0d9ccd0953de 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -642,18 +642,14 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv
> *p, const void *tx, desc_rx =
> dmaengine_prep_slave_single(p->master->dma_rx,
>  					p->rx_dma_addr, len, DMA_FROM_DEVICE,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> -		if (!desc_rx) {
> -			ret = -EAGAIN;
> -			goto no_dma_rx;
> -		}
> +		if (!desc_rx)
> +			return -EAGAIN;
> 
>  		desc_rx->callback = sh_msiof_dma_complete;
>  		desc_rx->callback_param = p;
>  		cookie = dmaengine_submit(desc_rx);
> -		if (dma_submit_error(cookie)) {
> -			ret = cookie;
> -			goto no_dma_rx;
> -		}
> +		if (dma_submit_error(cookie))
> +			return cookie;
>  	}
> 
>  	if (tx) {
> @@ -738,7 +734,6 @@ no_dma_tx:
>  	if (rx)
>  		dmaengine_terminate_all(p->master->dma_rx);
>  	sh_msiof_write(p, IER, 0);
> -no_dma_rx:
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart

