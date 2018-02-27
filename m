From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] spi: atmel: init FIFOs before spi enable
Date: Tue, 27 Feb 2018 11:29:33 +0100
Message-ID: <9650154b-c0b4-48aa-1c98-8d86aa834202@microchip.com>
References: <1519727107-5821-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
To: Eugen Hristev <eugen.hristev@microchip.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519727107-5821-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 27/02/2018 at 11:25, Eugen Hristev wrote:
> The datasheet recommends initializing FIFOs before
> SPI enable. If we do not do it like this, there may be
> a strange behavior. We noticed that DMA does not work properly
> with FIFOs if we do not clear them beforehand or enable them
> before SPIEN.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Ok, good:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/spi/spi-atmel.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 6694709..0478758 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1489,6 +1489,11 @@ static void atmel_spi_init(struct atmel_spi *as)
>   {
>   	spi_writel(as, CR, SPI_BIT(SWRST));
>   	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
> +
> +	/* It is recommended to enable FIFOs first thing after reset */
> +	if (as->fifo_size)
> +		spi_writel(as, CR, SPI_BIT(FIFOEN));
> +
>   	if (as->caps.has_wdrbt) {
>   		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
>   				| SPI_BIT(MSTR));
> @@ -1499,9 +1504,6 @@ static void atmel_spi_init(struct atmel_spi *as)
>   	if (as->use_pdc)
>   		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
>   	spi_writel(as, CR, SPI_BIT(SPIEN));
> -
> -	if (as->fifo_size)
> -		spi_writel(as, CR, SPI_BIT(FIFOEN));
>   }
>   
>   static int atmel_spi_probe(struct platform_device *pdev)
> 


-- 
Nicolas Ferre
