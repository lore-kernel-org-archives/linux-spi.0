From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] spi: mediatek: add spi support for mt2712 IC
Date: Tue, 20 Jun 2017 12:15:45 +0200
Message-ID: <b9acde7c-5b82-01d5-8494-6da5533e08ef@gmail.com>
References: <1497946867-25708-1-git-send-email-leilk.liu@mediatek.com>
 <1497946867-25708-3-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
To: Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497946867-25708-3-git-send-email-leilk.liu@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 20/06/17 10:21, Leilk Liu wrote:
> this patch add support for mt2712 IC.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index ec7755b..86bf456 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -105,6 +105,10 @@ struct mtk_spi {
>   
>   static const struct mtk_spi_compatible mtk_common_compat;
>   
> +static const struct mtk_spi_compatible mt2712_compat = {
> +	.must_tx = true,
> +};
> +
>   static const struct mtk_spi_compatible mt7622_compat = {
>   	.must_tx = true,
>   	.enhance_timing = true,
> @@ -130,6 +134,9 @@ struct mtk_spi {
>   	{ .compatible = "mediatek,mt2701-spi",
>   		.data = (void *)&mtk_common_compat,
>   	},
> +	{ .compatible = "mediatek,mt2712-spi",
> +		.data = (void *)&mt2712_compat,
> +	},
>   	{ .compatible = "mediatek,mt6589-spi",
>   		.data = (void *)&mtk_common_compat,
>   	},
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
