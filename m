From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [RFC 23/42] drivers/spi: don't check resource with
 devm_ioremap_resource
Date: Sat, 11 May 2013 14:24:35 +0900
Message-ID: <002b01ce4e07$d3087ed0$79197c70$@samsung.com>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'Mark Brown' <broonie@kernel.org>,
	'Grant Likely' <grant.likely@linaro.org>,
	'Ben Dooks' <ben-linux@fluff.org>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Barry Song' <baohua.song@csr.com>,
	'Stephen Warren' <swarren@wwwdotorg.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>
To: 'Wolfram Sang' <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, May 10, 2013 5:17 PM, Wolfram Sang wrote:
> 
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/spi/spi-bcm63xx.c        |    8 +-------
>  drivers/spi/spi-ep93xx.c         |    8 +-------
>  drivers/spi/spi-omap2-mcspi.c    |    7 +------
>  drivers/spi/spi-s3c64xx.c        |    7 +------
>  drivers/spi/spi-sirf.c           |    7 +------
>  drivers/spi/spi-tegra114.c       |    7 +------
>  drivers/spi/spi-tegra20-sflash.c |    5 -----
>  drivers/spi/spi-tegra20-slink.c  |    7 +------
>  8 files changed, 7 insertions(+), 49 deletions(-)
> 

[.....]

> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 5000586..fd763cc 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1243,12 +1243,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> -	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (mem_res == NULL) {
> -		dev_err(&pdev->dev, "Unable to get SPI MEM resource\n");
> -		return -ENXIO;
> -	}
> -

It breaks 'sdd->sfr_start' assignment as below:

1272         sdd->sfr_start = mem_res->start;


Best regards,
Jingoo Han

>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_warn(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> @@ -1318,6 +1312,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	/* the spi->mode bits understood by this driver: */
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> 
> +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
>  	if (IS_ERR(sdd->regs)) {
>  		ret = PTR_ERR(sdd->regs);
