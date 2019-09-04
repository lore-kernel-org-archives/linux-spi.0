From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH -next 23/36] spi: spi-qcom-qspi: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 4 Sep 2019 13:46:49 -0700
Message-ID: <20190904204649.GF580@tuxbook-pro>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-24-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, eric@anholt.net, wahrenst@gmx.net,
        shc_work@mail.ru, agross@kernel.org, khilman@baylibre.com,
        matthias.bgg@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, kgene@kernel.org, krzk@kernel.org,
        andi@etezian.org, palmer@sifive.com, paul.walmsley@sifive.com,
        baohua@kernel.org, mripard@kernel.org, wens@csie.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org, linux-ke
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190904135918.25352-24-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed 04 Sep 06:59 PDT 2019, YueHaibing wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index a0ad73f..250fd60 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -424,7 +424,6 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct device *dev;
> -	struct resource *res;
>  	struct spi_master *master;
>  	struct qcom_qspi *ctrl;
>  
> @@ -440,8 +439,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&ctrl->lock);
>  	ctrl->dev = dev;
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ctrl->base = devm_ioremap_resource(dev, res);
> +	ctrl->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(ctrl->base)) {
>  		ret = PTR_ERR(ctrl->base);
>  		goto exit_probe_master_put;
> -- 
> 2.7.4
> 
> 
