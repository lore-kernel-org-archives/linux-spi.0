From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 6/6] spi: s3c64xx: add device tree support
Date: Fri, 13 Jul 2012 07:38:38 +0900
Message-ID: <4FFF51EE.4080609@samsung.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
	<1342021265-11212-7-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1342021265-11212-7-git-send-email-thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07/12/12 00:41, Thomas Abraham wrote:
> Add support for device based discovery.
>
> Signed-off-by: Thomas Abraham<thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Jaswinder Singh<jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Grant Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
>   .../devicetree/bindings/spi/spi-samsung.txt        |  113 ++++++++
>   drivers/spi/spi-s3c64xx.c                          |  305 +++++++++++++++++---
>   2 files changed, 378 insertions(+), 40 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
>

[snip]

> @@ -989,49 +1057,166 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
>   	flush_fifo(sdd);
>   }
>
> +static int __devinit s3c64xx_spi_get_dmares(
> +			struct s3c64xx_spi_driver_data *sdd, bool tx)
> +{
> +	struct platform_device *pdev = sdd->pdev;
> +	struct s3c64xx_spi_dma_data *dma_data;
> +	struct property *prop;
> +	struct resource *res;
> +	char prop_name[15], *chan_str;
> +
> +	if (tx) {
> +		dma_data =&sdd->tx_dma;
> +		dma_data->direction = DMA_TO_DEVICE;
> +		chan_str = "tx";
> +	} else {
> +		dma_data =&sdd->rx_dma;
> +		dma_data->direction = DMA_FROM_DEVICE;
> +		chan_str = "rx";
> +	}
> +
> +	if (!sdd->pdev->dev.of_node) {
> +		res = platform_get_resource(pdev, IORESOURCE_DMA, tx ? 0 : 1);
> +		if (!res) {
> +			dev_err(&pdev->dev, "Unable to get SPI-%s dma "
> +					"resource\n", chan_str);
> +			return -ENXIO;
> +		}
> +		dma_data->dmach = res->start;
> +		return 0;
> +	}
> +
> +	sprintf(prop_name, "%s-dma-channel", chan_str);
> +	prop = of_find_property(pdev->dev.of_node, prop_name, NULL);
> +	if (!prop) {
> +		dev_err(&pdev->dev, "%s dma channel property not specified\n",
> +					chan_str);
> +		return -ENXIO;
> +	}
> +
> +	dma_data->dmach = DMACH_DT_PROP;

Thomas, the DMACH_DT_PROP is available only on pl330 now. So seems occur 
following build error with s3c6400_defconfig.

drivers/spi/spi-s3c64xx.c: In function 's3c64xx_spi_get_dmares':
drivers/spi/spi-s3c64xx.c:1098: error: 'DMACH_DT_PROP' undeclared (first 
use in this function)
drivers/spi/spi-s3c64xx.c:1098: error: (Each undeclared identifier is 
reported only once
drivers/spi/spi-s3c64xx.c:1098: error: for each function it appears in.)
make[3]: *** [drivers/spi/spi-s3c64xx.o] Error 1
make[2]: *** [drivers/spi] Error 2

> +	dma_data->dma_prop = prop;
> +	return 0;
> +}

[snip]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
