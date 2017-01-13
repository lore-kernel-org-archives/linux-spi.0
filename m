From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [patch] spi: s3c64xx: potential oops on probe error
Date: Fri, 13 Jan 2017 09:52:38 +0100
Message-ID: <50005d2c-9a1d-45f5-fe6c-7877d35cf442@samsung.com>
References: <CGME20170113074414epcas3p2474dd2512aa5b64989bee3696c7c48f8@epcas3p2.samsung.com>
 <20170113074253.GA30524@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Kukjin Kim <kgene@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20170113074253.GA30524@mwanda>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dan,


On 2017-01-13 08:42, Dan Carpenter wrote:
> We accidentally mixed up freeing the rx and tx channels which would a
> leak and an oops.
>
> Fixes: 3d63a47a380a ("spi: s3c64xx: Don't request/release DMA channels for each SPI transfer")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Right, my fault. Thanks for the fix!
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 849ee82..b8cd356 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1147,7 +1147,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>   		if (IS_ERR(sdd->tx_dma.ch)) {
>   			dev_err(&pdev->dev, "Failed to get TX DMA channel\n");
>   			ret = PTR_ERR(sdd->tx_dma.ch);
> -			goto err_release_tx_dma;
> +			goto err_release_rx_dma;
>   		}
>   	}
>   
> @@ -1197,10 +1197,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>   	pm_runtime_set_suspended(&pdev->dev);
>   
>   	if (!is_polling(sdd))
> -		dma_release_channel(sdd->rx_dma.ch);
> -err_release_tx_dma:
> -	if (!is_polling(sdd))
>   		dma_release_channel(sdd->tx_dma.ch);
> +err_release_rx_dma:
> +	if (!is_polling(sdd))
> +		dma_release_channel(sdd->rx_dma.ch);
>   err_disable_io_clk:
>   	clk_disable_unprepare(sdd->ioclk);
>   err_disable_src_clk:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
