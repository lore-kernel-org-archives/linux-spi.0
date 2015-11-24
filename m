From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: mediatek: revise mtk_spi_probe() failure flow
Date: Tue, 24 Nov 2015 19:12:42 +0100
Message-ID: <5654A89A.3090202@gmail.com>
References: <1448332712-29039-1-git-send-email-leilk.liu@mediatek.com>
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
In-Reply-To: <1448332712-29039-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 24/11/15 03:38, Leilk Liu wrote:
> This patch revises failure flow while pm_runtime_enable().

Please write a proper commit message explaining what this patch does.

>
> Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/spi/spi-mt65xx.c |   15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 6c1a96e..00a36da 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -607,7 +607,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
>   	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
> -		goto err_disable_clk;
> +		clk_disable_unprepare(mdata->spi_clk);
> +		goto err_put_master;
>   	}
>
>   	clk_disable_unprepare(mdata->spi_clk);
> @@ -617,7 +618,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
>   	ret = devm_spi_register_master(&pdev->dev, master);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
> -		goto err_put_master;
> +		goto err_disable_runtime_pm;
>   	}
>
>   	if (mdata->dev_comp->need_pad_sel) {
> @@ -626,14 +627,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
>   				"pad_num does not match num_chipselect(%d != %d)\n",
>   				mdata->pad_num, master->num_chipselect);
>   			ret = -EINVAL;
> -			goto err_put_master;
> +			goto err_disable_runtime_pm;
>   		}
>
>   		if (!master->cs_gpios && master->num_chipselect > 1) {
>   			dev_err(&pdev->dev,
>   				"cs_gpios not specified and num_chipselect > 1\n");
>   			ret = -EINVAL;
> -			goto err_put_master;
> +			goto err_disable_runtime_pm;
>   		}
>
>   		if (master->cs_gpios) {
> @@ -644,7 +645,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
>   				if (ret) {
>   					dev_err(&pdev->dev,
>   						"can't get CS GPIO %i\n", i);
> -					goto err_put_master;
> +					goto err_disable_runtime_pm;
>   				}
>   			}
>   		}
> @@ -652,8 +653,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
>
>   	return 0;
>
> -err_disable_clk:
> -	clk_disable_unprepare(mdata->spi_clk);
> +err_disable_runtime_pm:
> +	pm_runtime_disable(&pdev->dev);
>   err_put_master:
>   	spi_master_put(master);
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
