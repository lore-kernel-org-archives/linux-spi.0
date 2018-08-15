From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3] spi: orion: cosmetics - alias long direct_access
 variables
Date: Wed, 15 Aug 2018 09:10:06 +0200
Message-ID: <b9c9ad94-2e10-6f85-2540-c60882d9630a@denx.de>
References: <20180813205445.17113-1-zertsekel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Kosta Zertsekel <zertsekel@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Jan_Kundr=c3=a1t?= <jan.kundrat@cesnet.cz>,
        Ken Wilson <ken.wilson@opengear.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180813205445.17113-1-zertsekel@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 13.08.2018 22:54, Kosta Zertsekel wrote:
> This change increases the source code readability.
> Instead of using `spi->child[cs].direct_access.XXX` use `dir_acc->XXX`.
> Instead of using `orion_spi->child[cs].direct_access.vaddr` use `vaddr`.
> 
> Signed-off-by: Kosta Zertsekel <zertsekel@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   drivers/spi/spi-orion.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index d01a6adc726e..184ba91abeee 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -430,6 +430,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>   	int word_len;
>   	struct orion_spi *orion_spi;
>   	int cs = spi->chip_select;
> +	void __iomem *vaddr;
>   
>   	word_len = spi->bits_per_word;
>   	count = xfer->len;
> @@ -440,8 +441,9 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>   	 * Use SPI direct write mode if base address is available. Otherwise
>   	 * fall back to PIO mode for this transfer.
>   	 */
> -	if ((orion_spi->child[cs].direct_access.vaddr) && (xfer->tx_buf) &&
> -	    (word_len == 8)) {
> +	vaddr = orion_spi->child[cs].direct_access.vaddr;
> +
> +	if (vaddr && xfer->tx_buf && word_len == 8) {
>   		unsigned int cnt = count / 4;
>   		unsigned int rem = count % 4;
>   
> @@ -449,13 +451,11 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>   		 * Send the TX-data to the SPI device via the direct
>   		 * mapped address window
>   		 */
> -		iowrite32_rep(orion_spi->child[cs].direct_access.vaddr,
> -			      xfer->tx_buf, cnt);
> +		iowrite32_rep(vaddr, xfer->tx_buf, cnt);
>   		if (rem) {
>   			u32 *buf = (u32 *)xfer->tx_buf;
>   
> -			iowrite8_rep(orion_spi->child[cs].direct_access.vaddr,
> -				     &buf[cnt], rem);
> +			iowrite8_rep(vaddr, &buf[cnt], rem);
>   		}
>   
>   		return count;
> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>   
>   	/* Scan all SPI devices of this controller for direct mapped devices */
>   	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		struct orion_direct_acc *dir_acc;
>   		u32 cs;
>   
>   		/* Get chip-select number from the "reg" property */
> @@ -711,14 +712,13 @@ static int orion_spi_probe(struct platform_device *pdev)
>   		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
>   		 * support, once this gets implemented.
>   		 */
> -		spi->child[cs].direct_access.vaddr = devm_ioremap(&pdev->dev,
> -							    r->start,
> -							    PAGE_SIZE);
> -		if (!spi->child[cs].direct_access.vaddr) {
> +		dir_acc = &spi->child[cs].direct_access;
> +		dir_acc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
> +		if (!dir_acc->vaddr) {
>   			status = -ENOMEM;
>   			goto out_rel_axi_clk;
>   		}
> -		spi->child[cs].direct_access.size = PAGE_SIZE;
> +		dir_acc->size = PAGE_SIZE;
>   
>   		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
>   	}
> 

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
