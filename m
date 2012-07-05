From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/2] spi/s3c64xx: Convert to devm_request_and_ioremap()
Date: Thu, 05 Jul 2012 10:41:04 +0200
Message-ID: <4FF55320.4020107@samsung.com>
References: <1341418316-26190-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1341418316-26190-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/04/2012 06:11 PM, Mark Brown wrote:
> Saves some error handling and a small amount of code.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c |   25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index f4e2341..b7aeb5d 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1028,19 +1028,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  	/* the spi->mode bits understood by this driver: */
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>  
> -	if (request_mem_region(mem_res->start,
> -			resource_size(mem_res), pdev->name) == NULL) {
> -		dev_err(&pdev->dev, "Req mem region failed\n");
> -		ret = -ENXIO;
> -		goto err0;
> -	}
> -
> -	sdd->regs = ioremap(mem_res->start, resource_size(mem_res));
> -	if (sdd->regs == NULL) {
> -		dev_err(&pdev->dev, "Unable to remap IO\n");
> -		ret = -ENXIO;
> -		goto err1;
> -	}
> +	sdd->regs = devm_request_and_ioremap(&pdev->dev, mem_res);

It doesn't seem right. Why is is the check for valid sdd->regs removed ?
This should have rather been:

+	sdd->regs = devm_request_and_ioremap(&pdev->dev, mem_res);
+	if (sdd->regs == NULL) {
+		dev_err(&pdev->dev, "Failed to request memory region\n");
+		return -ENXIO;
+	}

Currently whne devm_request_and_ioremap() fails and returns NULL kernel oops
would happen right on first writel() in s3c64xx_spi_hwninit().


Thanks,
Sylwester

>  	if (sci->cfg_gpio == NULL || sci->cfg_gpio(pdev)) {
>  		dev_err(&pdev->dev, "Unable to config gpio\n");
> @@ -1124,10 +1112,6 @@ err4:
>  	clk_put(sdd->clk);
>  err3:
>  err2:
> -	iounmap((void *) sdd->regs);
> -err1:
> -	release_mem_region(mem_res->start, resource_size(mem_res));
> -err0:
>  	platform_set_drvdata(pdev, NULL);
>  	spi_master_put(master);
>  
> @@ -1138,7 +1122,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
>  	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
> -	struct resource	*mem_res;
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> @@ -1154,12 +1137,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
>  	clk_disable(sdd->clk);
>  	clk_put(sdd->clk);
>  
> -	iounmap((void *) sdd->regs);
> -
> -	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (mem_res != NULL)
> -		release_mem_region(mem_res->start, resource_size(mem_res));
> -
>  	platform_set_drvdata(pdev, NULL);
>  	spi_master_put(master);
