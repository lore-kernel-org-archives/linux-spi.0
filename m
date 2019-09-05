From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH -next 35/36] spi: zynq-qspi: use
 devm_platform_ioremap_resource() to simplify code
Date: Thu, 5 Sep 2019 07:19:56 +0200
Message-ID: <fbd385ec-f24d-7628-5f63-03f4444976aa@xilinx.com>
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-36-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
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
In-Reply-To: <20190904135918.25352-36-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04. 09. 19 15:59, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/spi/spi-zynq-qspi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index 4a5326c..5cf6993 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -620,7 +620,6 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct zynq_qspi *xqspi;
> -	struct resource *res;
>  	u32 num_cs;
>  
>  	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
> @@ -630,8 +629,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>  	xqspi = spi_controller_get_devdata(ctlr);
>  	xqspi->dev = dev;
>  	platform_set_drvdata(pdev, xqspi);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	xqspi->regs = devm_ioremap_resource(&pdev->dev, res);
> +	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(xqspi->regs)) {
>  		ret = PTR_ERR(xqspi->regs);
>  		goto remove_master;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
