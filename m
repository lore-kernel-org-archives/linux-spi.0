From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH -next 15/36] spi: meson-spicc: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 16:13:41 +0200
Message-ID: <231852cf-274a-797c-1c01-c7264629a915@baylibre.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-16-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
To: YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, wahrenst@gmx.net, shc_work@mail.ru,
        agross@kernel.org, khilman@baylibre.com, matthias.bgg@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, kgene@kernel.org,
        krzk@kernel.org, andi@etezian.org, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904135918.25352-16-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/09/2019 15:58, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/spi/spi-meson-spicc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index 7fe4488..f3f1044 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -503,7 +503,6 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  {
>  	struct spi_master *master;
>  	struct meson_spicc_device *spicc;
> -	struct resource *res;
>  	int ret, irq, rate;
>  
>  	master = spi_alloc_master(&pdev->dev, sizeof(*spicc));
> @@ -517,8 +516,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
>  	spicc->pdev = pdev;
>  	platform_set_drvdata(pdev, spicc);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	spicc->base = devm_ioremap_resource(&pdev->dev, res);
> +	spicc->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(spicc->base)) {
>  		dev_err(&pdev->dev, "io resource mapping failed\n");
>  		ret = PTR_ERR(spicc->base);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
