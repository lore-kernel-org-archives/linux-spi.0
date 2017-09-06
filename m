From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 5/8] spi: sh-msiof: Wait for Tx FIFO empty after DMA
Date: Wed, 6 Sep 2017 20:57:40 +0300
Message-ID: <75325ad0-f454-d79e-b11c-28e12808d552@cogentembedded.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
 <20170906070507.26223-6-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
To: Dirk Behme <dirk.behme@de.bosch.com>,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-6-dirk.behme@de.bosch.com>
Content-Language: en-MW
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 09/06/2017 10:05 AM, Dirk Behme wrote:

> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> 
> When Tx DMA is only used, Tx FIFO is still not empty after DMA callback.
> This patch waits for sweeping data out of the Tx FIFO.
> 
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> [adjust context]
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>   drivers/spi/spi-sh-msiof.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 660b03ed6770..a960e8da123d 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -638,6 +638,17 @@ static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p,
>   				dev_err(&p->pdev->dev, "Tx DMA timeout\n");
>   				return -ETIMEDOUT;
>   			}
> +			if (!rx) {
> +				sh_msiof_write(p, IER, IER_TEOFE);
> +
> +				/* wait for tx fifo to be emptied */
> +				if (!wait_for_completion_timeout(&p->done,
> +								 HZ)) {
> +					dev_err(&p->pdev->dev,
> +					"Tx fifo to be emptied timeout\n");

    Please indent this line properly, messages can violate 80-column limit.

> +					return -ETIMEDOUT;
> +				}
> +			}
>   		}
>   		if (rx) {
>   			if (!wait_for_completion_timeout(&p->done_dma_rx,
[...]

MBR, Sergei
