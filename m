From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] spi: sh-msiof: Fix transmit-only DMA transfers
Date: Thu, 07 Aug 2014 14:51:54 +0200
Message-ID: <1519133.I1M5gTHUZc@avalon>
References: <CAMuHMdUd3OKqDwhLSCMW-rEQSnWky+saN5TgC005rkmNPfEL+g@mail.gmail.com> <1407413263-20177-1-git-send-email-geert+renesas@glider.be> <1407413263-20177-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1407413263-20177-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Thursday 07 August 2014 14:07:43 Geert Uytterhoeven wrote:
> Fix tx/rx mixup, which broke transmit-only transfers.
> 
> Introduced by commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
> ("spi: sh-msiof: Fix leaking of unused DMA descriptors").
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Feel free to fold into commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
> ("spi: sh-msiof: Fix leaking of unused DMA descriptors")
> ---
>  drivers/spi/spi-sh-msiof.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 0d9ccd0953de..5ee13a2d93df 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -689,9 +689,9 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv
> *p, const void *tx, reinit_completion(&p->done);
> 
>  	/* Now start DMA */
> -	if (tx)
> -		dma_async_issue_pending(p->master->dma_rx);
>  	if (rx)
> +		dma_async_issue_pending(p->master->dma_rx);
> +	if (tx)
>  		dma_async_issue_pending(p->master->dma_tx);
> 
>  	ret = sh_msiof_spi_start(p, rx);

-- 
Regards,

Laurent Pinchart

