From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: fix checkpatch warnings and error
Date: Tue, 05 Feb 2013 13:22:05 +0000
Message-ID: <20130205132206.099D53E0E27@localhost>
References: <00a701cdff7b$b365dcb0$1a319610$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <00a701cdff7b$b365dcb0$1a319610$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 31 Jan 2013 15:25:01 +0900, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Fix checkpatch warnings and error as below:
>   ERROR: "foo * bar" should be "foo *bar"
>   WARNING: please, no space before tabs
>   WARNING: quoted string split across lines
>   WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-s3c64xx.c |   33 +++++++++++++--------------------
>  1 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 4dd7b7c..ae8ef6d 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -62,7 +62,7 @@
>  #define S3C64XX_SPI_CLKSEL_SRCMSK	(3<<9)
>  #define S3C64XX_SPI_CLKSEL_SRCSHFT	9
>  #define S3C64XX_SPI_ENCLK_ENABLE	(1<<8)
> -#define S3C64XX_SPI_PSR_MASK 		0xff
> +#define S3C64XX_SPI_PSR_MASK		0xff
>  
>  #define S3C64XX_SPI_MODE_CH_TSZ_BYTE		(0<<29)
>  #define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD	(1<<29)
> @@ -743,8 +743,7 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>  		       sdd->regs + S3C64XX_SPI_SLAVE_SEL);
>  
>  		if (status) {
> -			dev_err(&spi->dev, "I/O Error: "
> -				"rx-%d tx-%d res:rx-%c tx-%c len-%d\n",
> +			dev_err(&spi->dev, "I/O Error: rx-%d tx-%d res:rx-%c tx-%c len-%d\n",
>  				xfer->rx_buf ? 1 : 0, xfer->tx_buf ? 1 : 0,
>  				(sdd->state & RXBUSY) ? 'f' : 'p',
>  				(sdd->state & TXBUSY) ? 'f' : 'p',
> @@ -801,7 +800,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
>  
>  	/* Acquire DMA channels */
>  	while (!acquire_dma(sdd))
> -		msleep(10);
> +		usleep_range(10000, 11000);
>  
>  	pm_runtime_get_sync(&sdd->pdev->dev);
>  
> @@ -843,16 +842,14 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
>  
>  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
>  	if (!cs) {
> -		dev_err(&spi->dev, "could not allocate memory for controller"
> -					" data\n");
> +		dev_err(&spi->dev, "could not allocate memory for controller data\n");
>  		of_node_put(data_np);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
>  	if (!gpio_is_valid(cs->line)) {
> -		dev_err(&spi->dev, "chip select gpio is not specified or "
> -					"invalid\n");
> +		dev_err(&spi->dev, "chip select gpio is not specified or invalid\n");
>  		kfree(cs);
>  		of_node_put(data_np);
>  		return ERR_PTR(-EINVAL);
> @@ -1078,8 +1075,8 @@ static int s3c64xx_spi_get_dmares(
>  	if (!sdd->pdev->dev.of_node) {
>  		res = platform_get_resource(pdev, IORESOURCE_DMA, tx ? 0 : 1);
>  		if (!res) {
> -			dev_err(&pdev->dev, "Unable to get SPI-%s dma "
> -					"resource\n", chan_str);
> +			dev_err(&pdev->dev, "Unable to get SPI-%s dma resource\n",
> +				chan_str);
>  			return -ENXIO;
>  		}
>  		dma_data->dmach = res->start;
> @@ -1135,8 +1132,7 @@ static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
>  		gpio_free(sdd->gpios[idx]);
>  }
>  
> -static struct s3c64xx_spi_info * s3c64xx_spi_parse_dt(
> -						struct device *dev)
> +static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
>  {
>  	struct s3c64xx_spi_info *sci;
>  	u32 temp;
> @@ -1148,16 +1144,14 @@ static struct s3c64xx_spi_info * s3c64xx_spi_parse_dt(
>  	}
>  
>  	if (of_property_read_u32(dev->of_node, "samsung,spi-src-clk", &temp)) {
> -		dev_warn(dev, "spi bus clock parent not specified, using "
> -				"clock at index 0 as parent\n");
> +		dev_warn(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
>  		sci->src_clk_nr = 0;
>  	} else {
>  		sci->src_clk_nr = temp;
>  	}
>  
>  	if (of_property_read_u32(dev->of_node, "num-cs", &temp)) {
> -		dev_warn(dev, "number of chip select lines not specified, "
> -				"assuming 1 chip select line\n");
> +		dev_warn(dev, "number of chip select lines not specified, assuming 1 chip select line\n");
>  		sci->num_cs = 1;
>  	} else {
>  		sci->num_cs = temp;
> @@ -1247,8 +1241,8 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  	if (pdev->dev.of_node) {
>  		ret = of_alias_get_id(pdev->dev.of_node, "spi");
>  		if (ret < 0) {
> -			dev_err(&pdev->dev, "failed to get alias id, "
> -						"errno %d\n", ret);
> +			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
> +				ret);
>  			goto err0;
>  		}
>  		sdd->port_id = ret;
> @@ -1347,8 +1341,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>  		goto err8;
>  	}
>  
> -	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
> -					"with %d Slaves attached\n",
> +	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
>  					sdd->port_id, master->num_chipselect);
>  	dev_dbg(&pdev->dev, "\tIOmem=[0x%x-0x%x]\tDMA=[Rx-%d, Tx-%d]\n",
>  					mem_res->end, mem_res->start,
> -- 
> 1.7.2.5
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
