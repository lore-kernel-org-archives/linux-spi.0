From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] spi: spi-atmel: Use correct enum for DMA transfer
 direction
Date: Mon, 26 Mar 2018 10:03:49 +0200
Message-ID: <b3fff78d-2a1e-b05a-483a-f2707fece63f@microchip.com>
References: <20180324104800.9934-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Radu Pirea <Radu.Pirea@microchip.com>, alexandre.belloni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180324104800.9934-1-stefan@agner.ch>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 24/03/2018 at 11:48, Stefan Agner wrote:
> Use enum dma_transfer_direction as required by the functions
> dmaengine_prep_slave_(sg|single)() instead of enum dma_data_direction.
> This won't change behavior in practice as the enum values are
> equivalent.
> 
> This fixes two warnings when building with clang:
>    drivers/spi/spi-atmel.c:771:12: warning: implicit conversion from enumeration
>        type 'enum dma_data_direction' to different enumeration type
>        'enum dma_transfer_direction'
>        [-Wenum-conversion]
>                                                       DMA_FROM_DEVICE,
>                                                       ^~~~~~~~~~~~~~~
>    ...
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Ok:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/spi/spi-atmel.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 4a11fc0d4136..6a7844616c65 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -768,14 +768,14 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
>   		rxdesc = dmaengine_prep_slave_single(rxchan,
>   						     as->dma_addr_rx_bbuf,
>   						     xfer->len,
> -						     DMA_FROM_DEVICE,
> +						     DMA_DEV_TO_MEM,
>   						     DMA_PREP_INTERRUPT |
>   						     DMA_CTRL_ACK);
>   	} else {
>   		rxdesc = dmaengine_prep_slave_sg(rxchan,
>   						 xfer->rx_sg.sgl,
>   						 xfer->rx_sg.nents,
> -						 DMA_FROM_DEVICE,
> +						 DMA_DEV_TO_MEM,
>   						 DMA_PREP_INTERRUPT |
>   						 DMA_CTRL_ACK);
>   	}
> @@ -787,14 +787,14 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
>   		memcpy(as->addr_tx_bbuf, xfer->tx_buf, xfer->len);
>   		txdesc = dmaengine_prep_slave_single(txchan,
>   						     as->dma_addr_tx_bbuf,
> -						     xfer->len, DMA_TO_DEVICE,
> +						     xfer->len, DMA_MEM_TO_DEV,
>   						     DMA_PREP_INTERRUPT |
>   						     DMA_CTRL_ACK);
>   	} else {
>   		txdesc = dmaengine_prep_slave_sg(txchan,
>   						 xfer->tx_sg.sgl,
>   						 xfer->tx_sg.nents,
> -						 DMA_TO_DEVICE,
> +						 DMA_MEM_TO_DEV,
>   						 DMA_PREP_INTERRUPT |
>   						 DMA_CTRL_ACK);
>   	}
> 


-- 
Nicolas Ferre
