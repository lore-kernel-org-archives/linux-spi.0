From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 02/16] of_spi: add generic binding support to specify cs
 gpio
Date: Thu, 15 Nov 2012 16:50:48 +0000
Message-ID: <20121115165048.543FE3E194B@localhost>
References: <1349850454-21127-1-git-send-email-wenyou.yang@atmel.com>
 <1349850454-21127-3-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1349850454-21127-3-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On Wed, 10 Oct 2012 14:27:20 +0800, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> 
> This will allow to use gpio for chip select with no modification in the
> driver binding
> 
> When use the cs-gpios, the gpio number will be passed via the cs_gpio field
> and the number of chip select will automatically increased.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Signed-off-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> This patch based on the original patch from Jean-Christophe, 
>  	0002-of_spi-add-generic-binding-support-to-specify-cs-gpi.patch,
> and merged the patch from Richard Genoud,
> 	0016-BUG-SPI-array-out-of-bound-no-CS.patch.
> which fix the BUG of spi array out of bound 
> 
>  Documentation/devicetree/bindings/spi/spi-bus.txt |    6 +++
>  drivers/spi/spi.c                                 |   55 +++++++++++++++++++--
>  include/linux/spi/spi.h                           |    3 ++
>  3 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index e782add..c253379 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -12,6 +12,7 @@ The SPI master node requires the following properties:
>  - #size-cells     - should be zero.
>  - compatible      - name of SPI bus controller following generic names
>      		recommended practice.
> +- cs-gpios	  - (optional) gpios chip select.
>  No other properties are required in the SPI bus node.  It is assumed
>  that a driver for an SPI bus device will understand that it is an SPI bus.
>  However, the binding does not attempt to define the specific method for
> @@ -21,6 +22,8 @@ assumption that board specific platform code will be used to manage
>  chip selects.  Individual drivers can define additional properties to
>  support describing the chip select layout.
>  
> +If cs-gpios is used the number of chip select will automatically increased.
> +
>  SPI slave nodes must be children of the SPI master node and can
>  contain the following properties.
>  - reg             - (required) chip select address of device.
> @@ -34,6 +37,9 @@ contain the following properties.
>  - spi-cs-high     - (optional) Empty property indicating device requires
>      		chip select active high
>  
> +If a gpio chipselect is used for the SPI slave the gpio number will be passed
> +via the controller_data
> +
>  SPI example for an MPC5200 SPI bus:
>  	spi@f00 {
>  		#address-cells = <1>;
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 84c2861..74e6577 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -30,6 +30,7 @@
>  #include <linux/slab.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
> +#include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/export.h>
>  #include <linux/sched.h>
> @@ -327,6 +328,7 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
>  	spi->dev.parent = &master->dev;
>  	spi->dev.bus = &spi_bus_type;
>  	spi->dev.release = spidev_release;
> +	spi->cs_gpio = -EINVAL;
>  	device_initialize(&spi->dev);
>  	return spi;
>  }
> @@ -344,15 +346,16 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
>  int spi_add_device(struct spi_device *spi)
>  {
>  	static DEFINE_MUTEX(spi_add_lock);
> -	struct device *dev = spi->master->dev.parent;
> +	struct spi_master *master = spi->master;
> +	struct device *dev = master->dev.parent;
>  	struct device *d;
>  	int status;
>  
>  	/* Chipselects are numbered 0..max; validate. */
> -	if (spi->chip_select >= spi->master->num_chipselect) {
> +	if (spi->chip_select >= master->num_chipselect) {
>  		dev_err(dev, "cs%d >= max %d\n",
>  			spi->chip_select,
> -			spi->master->num_chipselect);
> +			master->num_chipselect);
>  		return -EINVAL;
>  	}
>  
> @@ -376,6 +379,9 @@ int spi_add_device(struct spi_device *spi)
>  		goto done;
>  	}
>  
> +	if (master->cs_gpios)
> +		spi->cs_gpio = master->cs_gpios[spi->chip_select];
> +
>  	/* Drivers may modify this initial i/o setup, but will
>  	 * normally rely on the device being setup.  Devices
>  	 * using SPI_CS_HIGH can't coexist well otherwise...
> @@ -946,6 +952,45 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
>  }
>  EXPORT_SYMBOL_GPL(spi_alloc_master);
>  
> +#ifdef CONFIG_OF
> +static int of_spi_register_master(struct spi_master *master)
> +{
> +	int nb, i;
> +	int *cs;
> +	struct device_node *np = master->dev.of_node;
> +
> +	if (!np)
> +		return 0;
> +
> +	nb = of_gpio_named_count(np, "cs-gpios");
> +
> +	if (nb < 1)
> +		return 0;
> +
> +	cs = devm_kzalloc(&master->dev,
> +			  sizeof(int) * (master->num_chipselect + nb),
> +			  GFP_KERNEL);
> +	master->cs_gpios = cs;
> +
> +	if (!master->cs_gpios)
> +		return -ENOMEM;
> +
> +	memset(cs, -EINVAL, master->num_chipselect);
> +	cs += master->num_chipselect;
> +	master->num_chipselect += nb;

The problem with this approach is the gpio cs get appended to the
'native' cs lines which gets really confusing. If cs-gpios is provided,
then num_chipselect should become the *greater* of either the number of
native chip selects or the number of gpios provided. Otherwise the user
has no way to figure out how reg values will map to gpios. The first
cs-gpio entry could end up getting mapped to something like cs4.

So if for example the controller has 2 CS lines, and the cs-gpios
property looks like this:

	cs-gpios = <&gpio1 0 0> <0> <&gpio1 1 0> <&gpio1 2 0>;

Then it should be configured so that num_chipselect = 4 with the
following mapping:

cs0 : &gpio1 0 0
cs1 : native
cs2 : &gpio1 1 0
cs3 : &gpio1 2 0

Otherwise the patch looks pretty good.

g.
