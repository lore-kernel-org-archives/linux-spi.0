From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH -next 16/36] spi: spi-meson-spifc: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 16:14:12 +0200
Message-ID: <f4afcae3-8796-2ce4-0377-918536d5bf3e@baylibre.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-17-yuehaibing@huawei.com>
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
In-Reply-To: <20190904135918.25352-17-yuehaibing@huawei.com>
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
>  drivers/spi/spi-meson-spifc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
> index f7fe9b1..c7b0399 100644
> --- a/drivers/spi/spi-meson-spifc.c
> +++ b/drivers/spi/spi-meson-spifc.c
> @@ -286,7 +286,6 @@ static int meson_spifc_probe(struct platform_device *pdev)
>  {
>  	struct spi_master *master;
>  	struct meson_spifc *spifc;
> -	struct resource *res;
>  	void __iomem *base;
>  	unsigned int rate;
>  	int ret = 0;
> @@ -300,8 +299,7 @@ static int meson_spifc_probe(struct platform_device *pdev)
>  	spifc = spi_master_get_devdata(master);
>  	spifc->dev = &pdev->dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(spifc->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base)) {
>  		ret = PTR_ERR(base);
>  		goto out_err;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
