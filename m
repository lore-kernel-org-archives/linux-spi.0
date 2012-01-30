From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/3] spi/atmel: add DT support
Date: Mon, 30 Jan 2012 11:56:53 -0700
Message-ID: <20120130185653.GP28397@ponder.secretlab.ca>
References: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
	<1327937271-23668-2-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1327937271-23668-2-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 30, 2012 at 04:27:50PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> the atmel_spi use only gpio for chip select
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> ---
>  .../devicetree/bindings/spi/spi_atmel.txt          |    6 ++++++
>  drivers/spi/spi-atmel.c                            |   13 ++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> new file mode 100644
> index 0000000..7ec3d8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> @@ -0,0 +1,6 @@
> +Atmel SPI device
> +
> +Required properties:
> +- compatible : should be "atmel,at91rm9200-spi".
> +- reg: Address and length of the register set for the device
> +- interrupts: Should contain macb interrupt
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 16d6a83..beeaa26 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -19,6 +19,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include <asm/io.h>
>  #include <mach/board.h>
> @@ -937,8 +938,9 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
>  	/* the spi->mode bits understood by this driver: */
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>  
> +	master->dev.of_node = pdev->dev.of_node;
>  	master->bus_num = pdev->id;
> -	master->num_chipselect = 4;
> +	master->num_chipselect = master->dev.of_node ? 0 : 4;

...continuing on from my comments on patch 1; this code will need to use
of_gpio_count() to find out how many SS lines there are.  Otherwise this patch
looks okay to me.

>  	master->setup = atmel_spi_setup;
>  	master->transfer = atmel_spi_transfer;
>  	master->cleanup = atmel_spi_cleanup;
> @@ -1064,11 +1066,20 @@ static int atmel_spi_resume(struct platform_device *pdev)
>  #define	atmel_spi_resume	NULL
>  #endif
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id atmel_spi_dt_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-spi" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
> +#endif
>  
>  static struct platform_driver atmel_spi_driver = {
>  	.driver		= {
>  		.name	= "atmel_spi",
>  		.owner	= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(atmel_spi_dt_ids),
>  	},
>  	.suspend	= atmel_spi_suspend,
>  	.resume		= atmel_spi_resume,
> -- 
> 1.7.7
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
