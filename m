From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 4/9] spi: atmel-quadspi: remove unnecessary cast
Date: Wed, 30 Jan 2019 18:20:05 +0100
Message-ID: <20190130181955.48309a21@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-5-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-5-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 Jan 2019 15:08:35 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The cast is done implicitly.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/spi/atmel-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index e156c345705b..3643f0c851b0 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -389,7 +389,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  
>  static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
>  {
> -	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
> +	struct atmel_qspi *aq = dev_id;
>  	u32 status, mask, pending;
>  
>  	status = atmel_qspi_readl(aq, QSPI_SR);
