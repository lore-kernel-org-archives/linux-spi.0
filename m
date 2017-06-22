From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] spi: Use Apple device properties in absence of ACPI
 resources
Date: Thu, 22 Jun 2017 11:10:48 +0300
Message-ID: <20170622081048.GT629@lahna.fi.intel.com>
References: <cover.1498044532.git.lukas@wunner.de>
 <19c49c0351e452bff28199abcc6b3a11ec6949b2.1498044532.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19c49c0351e452bff28199abcc6b3a11ec6949b2.1498044532.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 21, 2017 at 08:05:53PM +0200, Lukas Wunner wrote:
> MacBooks and MacBook Pros introduced since 2015 return empty _CRS data
> for SPI slaves, causing device initialization to fail.  Most of the
> information that would normally be conveyed via _CRS is available
> through ACPI device properties instead, so take advantage of them.
> 
> The meaning and appropriate usage of the device properties was reverse
> engineered by Ronald Tschalär and carried over from these commits
> authored by him:
> 
> https://github.com/cb22/macbook12-spi-driver/commit/9a416d699ef4
> https://github.com/cb22/macbook12-spi-driver/commit/0c34936ed9a1
> 
> According to Ronald, the device properties have the following meaning:
> 
> spiSclkPeriod   /* period in ns */
> spiWordSize     /* in number of bits */
> spiBitOrder     /* 1 = MSB_FIRST, 0 = LSB_FIRST */
> spiSPO          /* clock polarity: 0 = low, 1 = high */
> spiSPH          /* clock phase: 0 = first, 1 = second */
> spiCSDelay      /* delay between cs and receive on reads in 10 us */
> resetA2RUsec    /* active-to-receive delay? */
> resetRecUsec    /* receive delay? */
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Federico Lorenzi <florenzi@gmail.com>
> Cc: Ronald Tschalär <ronald@innovation.ch>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/spi/spi.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 89254a55eb2e..a4066b75d02b 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -21,6 +21,8 @@
>  #include <linux/cache.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dmi.h>
> +#include <linux/math64.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> @@ -1685,6 +1687,29 @@ static void of_register_spi_devices(struct spi_master *master) { }
>  #endif
>  
>  #ifdef CONFIG_ACPI
> +static void acpi_spi_parse_apple_properties(struct spi_device *spi)
> +{
> +	struct acpi_device *dev = ACPI_COMPANION(&spi->dev);
> +	const union acpi_object *o;
> +
> +	if (!acpi_dev_get_property(dev, "spiSclkPeriod", ACPI_TYPE_BUFFER, &o))
> +		spi->max_speed_hz  = div64_u64(NSEC_PER_SEC,
> +					       *(u64 *)o->buffer.pointer);
> +
> +	if (!acpi_dev_get_property(dev, "spiWordSize", ACPI_TYPE_BUFFER, &o))
> +		spi->bits_per_word = *(u64 *)o->buffer.pointer;
> +
> +	if (!acpi_dev_get_property(dev, "spiBitOrder", ACPI_TYPE_BUFFER, &o) &&
> +	    !*(u64 *)o->buffer.pointer)
> +		spi->mode |= SPI_LSB_FIRST;
> +	if (!acpi_dev_get_property(dev, "spiSPO", ACPI_TYPE_BUFFER, &o) &&
> +	     *(u64 *)o->buffer.pointer)
> +		spi->mode |= SPI_CPOL;
> +	if (!acpi_dev_get_property(dev, "spiSPH", ACPI_TYPE_BUFFER, &o) &&
> +	     *(u64 *)o->buffer.pointer)
> +		spi->mode |= SPI_CPHA;
> +}
> +
>  static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>  {
>  	struct spi_device *spi = data;
> @@ -1758,6 +1783,11 @@ static acpi_status acpi_register_spi_device(struct spi_master *master,
>  				     acpi_spi_add_resource, spi);
>  	acpi_dev_free_resource_list(&resource_list);
>  
> +	/* Zero ACPI resources?  Try Apple device properties instead. */
> +	if (!ret && IS_ENABLED(CONFIG_X86) &&
> +	    dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
> +		acpi_spi_parse_apple_properties(spi);

Same comment here, move the conditionals to
acpi_spi_parse_apple_properties() and then do

	if (!ret)
		acpi_spi_parse_apple_properties(spi);
