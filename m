From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] spi/atmel: add DT support
Date: Fri, 23 Nov 2012 14:37:29 +0100
Message-ID: <50AF7C19.8000306@atmel.com>
References: <20121121151713.1F8873E0A47@localhost>
	<1353674679-13158-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1353674679-13158-1-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 11/23/2012 01:44 PM, Jean-Christophe PLAGNIOL-VILLARD :
> the atmel_spi use only gpio for chip select
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>

Seems simple and nice:

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
> Hi Grant,
> 
> 	can we have this for 3.8
> 	This patch is presetnt on the ML sing Feb 2012 and was depinding on
> 	the cs-gpio dt that you just apply
> 
> Best Regards,
> J.
>  .../devicetree/bindings/spi/spi_atmel.txt          |   26 ++++++++++++++++++++
>  drivers/spi/spi-atmel.c                            |   17 ++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> new file mode 100644
> index 0000000..07e04cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> @@ -0,0 +1,26 @@
> +Atmel SPI device
> +
> +Required properties:
> +- compatible : should be "atmel,at91rm9200-spi".
> +- reg: Address and length of the register set for the device
> +- interrupts: Should contain spi interrupt
> +- cs-gpios: chipselects
> +
> +Example:
> +
> +spi1: spi@fffcc000 {
> +	compatible = "atmel,at91rm9200-spi";
> +	reg = <0xfffcc000 0x4000>;
> +	interrupts = <13 4 5>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	cs-gpios = <&pioB 3 0>;
> +	status = "okay";
> +
> +	mmc-slot@0 {
> +		compatible = "mmc-spi-slot";
> +		reg = <0>;
> +		gpios = <&pioC 4 0>;	/* CD */
> +		spi-max-frequency = <25000000>;
> +	};
> +};
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 61fb0ec..1615222 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -20,6 +20,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/platform_data/atmel.h>
> +#include <linux/of.h>
>  
>  #include <asm/io.h>
>  #include <asm/gpio.h>
> @@ -768,6 +769,10 @@ static int atmel_spi_setup(struct spi_device *spi)
>  
>  	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
>  	npcs_pin = (unsigned int)spi->controller_data;
> +
> +	if (gpio_is_valid(spi->cs_gpio))
> +		npcs_pin = spi->cs_gpio;
> +
>  	asd = spi->controller_state;
>  	if (!asd) {
>  		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
> @@ -937,8 +942,9 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
>  	/* the spi->mode bits understood by this driver: */
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>  
> +	master->dev.of_node = pdev->dev.of_node;
>  	master->bus_num = pdev->id;
> -	master->num_chipselect = 4;
> +	master->num_chipselect = master->dev.of_node ? 0 : 4;
>  	master->setup = atmel_spi_setup;
>  	master->transfer = atmel_spi_transfer;
>  	master->cleanup = atmel_spi_cleanup;
> @@ -1064,11 +1070,20 @@ static int atmel_spi_resume(struct platform_device *pdev)
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
> 


-- 
Nicolas Ferre

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
