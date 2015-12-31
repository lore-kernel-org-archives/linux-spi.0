From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: mediatek: merge all identical compat to
 mtk_common_compat
Date: Thu, 31 Dec 2015 09:32:07 +0100
Message-ID: <5684E807.30300@gmail.com>
References: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
 <1451530743-8995-2-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451530743-8995-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 31/12/15 03:59, Leilk Liu wrote:
> This patch merge all identical compat into on mtk_common_compat
> and used for all compatible soc.
>
> Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>   drivers/spi/spi-mt65xx.c |   15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 563954a..3573c09 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -95,8 +95,7 @@ struct mtk_spi {
>   	const struct mtk_spi_compatible *dev_comp;
>   };
>
> -static const struct mtk_spi_compatible mt6589_compat;
> -static const struct mtk_spi_compatible mt8135_compat;
> +static const struct mtk_spi_compatible mtk_common_compat;
>   static const struct mtk_spi_compatible mt8173_compat = {
>   	.need_pad_sel = true,
>   	.must_tx = true,
> @@ -112,9 +111,15 @@ static const struct mtk_chip_config mtk_default_chip_info = {
>   };
>
>   static const struct of_device_id mtk_spi_of_match[] = {
> -	{ .compatible = "mediatek,mt6589-spi", .data = (void *)&mt6589_compat },
> -	{ .compatible = "mediatek,mt8135-spi", .data = (void *)&mt8135_compat },
> -	{ .compatible = "mediatek,mt8173-spi", .data = (void *)&mt8173_compat },
> +	{ .compatible = "mediatek,mt6589-spi",
> +		.data = (void *)&mtk_common_compat,
> +	},
> +	{ .compatible = "mediatek,mt8135-spi",
> +		.data = (void *)&mtk_common_compat,
> +	},
> +	{ .compatible = "mediatek,mt8173-spi",
> +		.data = (void *)&mt8173_compat,
> +	},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
