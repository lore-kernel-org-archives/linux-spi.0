From: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Subject: Re: [PATCH 1/5] spi-topcliff-pch: add tx-memory clear after complete
 transmitting
Date: Tue, 04 Oct 2011 18:15:26 +0900
Message-ID: <4E8ACEAE.3040400@dsn.lapis-semi.com>
References: <1315295914-6862-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315295914-6862-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

1 month has passed. You look very busy, right ?
We've been long waiting for your accept.
Could you review these patch series ?

Thanks in advance.

(2011/09/06 16:58), Tomoya MORINAGA wrote:
> Currently, in case of reading date from SPI flash,
> command is sent twice.
> The cause is that tx-memory clear processing is missing .
> This patch adds the tx-momory clear processing.
> 
> Signed-off-by: Tomoya MORINAGA<tomoya-linux@dsn.okisemi.com>
> ---
>   drivers/spi/spi-topcliff-pch.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index 540c290..1b98b7e 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -839,6 +839,11 @@ static void pch_spi_start_transfer(struct pch_spi_data *data)
> 
>   	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_rx_p, dma->nent,
>   			    DMA_FROM_DEVICE);
> +
> +	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_tx_p, dma->nent,
> +			    DMA_FROM_DEVICE);
> +	memset(data->dma.tx_buf_virt, 0, PAGE_SIZE);
> +
>   	async_tx_ack(dma->desc_rx);
>   	async_tx_ack(dma->desc_tx);
>   	kfree(dma->sg_tx_p);


-- 
tomoya
ROHM Co., Ltd.
