From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/4] spi: mediatek: remove needless pair of
 writel()/readl()
Date: Fri, 20 Nov 2015 17:56:10 +0100
Message-ID: <564F50AA.50000@gmail.com>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-3-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
To: Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447986080-31410-3-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 20/11/15 03:21, Leilk Liu wrote:
> It's not need to re-read and re-write SPI_CMD_REG, so remove it.
>
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c |    3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 7840067..6c1a96e 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -154,9 +154,6 @@ static int mtk_spi_prepare_message(struct spi_master *master,
>   		reg_val |= SPI_CMD_CPOL;
>   	else
>   		reg_val &= ~SPI_CMD_CPOL;
> -	writel(reg_val, mdata->base + SPI_CMD_REG);
> -
> -	reg_val = readl(mdata->base + SPI_CMD_REG);
>
>   	/* set the mlsbx and mlsbtx */
>   	if (chip_config->tx_mlsb)
>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
