From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 6/6] spi: Use Apple device properties in absence of
 ACPI resources
Date: Sun, 16 Jul 2017 20:57:28 +0300
Message-ID: <1500227848.29303.24.camel@linux.intel.com>
References: <cover.1499983092.git.lukas@wunner.de>
         <c137d15be96c954f405bda5acaaf730cccc8e601.1499983092.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c137d15be96c954f405bda5acaaf730cccc8e601.1499983092.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2017-07-14 at 00:36 +0200, Lukas Wunner wrote:
> MacBooks and MacBook Pros introduced since 2015 return empty _CRS data
> for SPI slaves, causing device initialization to fail.  Most of the
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
> spiSclkPeriod   /* period in ns */
> spiWordSize     /* in number of bits */
> spiBitOrder     /* 1 = MSB_FIRST, 0 = LSB_FIRST */
> spiSPO          /* clock polarity: 0 = low, 1 = high */
> spiSPH          /* clock phase: 0 = first, 1 = second */
> spiCSDelay      /* delay between cs and receive on reads in 10 us */
> resetA2RUsec    /* active-to-receive delay? */
> resetRecUsec    /* receive delay? */
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

(obj is better than o)

> Cc: Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reported-by: Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Ronald Tschalär <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>
> Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> ---
> Changes v2 -> v3:
> - Check buffer length for extra safety.  Rename "o" to "obj",
>   use 32 bit division to calculate max_speed_hz. (Andy)
> 
>  drivers/spi/spi.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 4fcbb0aa71d3..cce133057700 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1693,6 +1693,35 @@ static void of_register_spi_devices(struct
> spi_controller *ctlr) { }
>  #endif
>  
>  #ifdef CONFIG_ACPI
> +static void acpi_spi_parse_apple_properties(struct spi_device *spi)
> +{
> +	struct acpi_device *dev = ACPI_COMPANION(&spi->dev);
> +	const union acpi_object *obj;
> +
> +	if (!is_apple_system)
> +		return;
> +
> +	if (!acpi_dev_get_property(dev, "spiSclkPeriod",
> ACPI_TYPE_BUFFER, &obj)
> +	    && obj->buffer.length >= 4)
> +		spi->max_speed_hz  = NSEC_PER_SEC / *(u32 *)obj-
> >buffer.pointer;
> +
> +	if (!acpi_dev_get_property(dev, "spiWordSize",
> ACPI_TYPE_BUFFER, &obj)
> +	    && obj->buffer.length == 8)
> +		spi->bits_per_word = *(u64 *)obj->buffer.pointer;
> +
> +	if (!acpi_dev_get_property(dev, "spiBitOrder",
> ACPI_TYPE_BUFFER, &obj)
> +	    && obj->buffer.length == 8 && !*(u64 *)obj-
> >buffer.pointer)
> +		spi->mode |= SPI_LSB_FIRST;
> +
> +	if (!acpi_dev_get_property(dev, "spiSPO", ACPI_TYPE_BUFFER,
> &obj)
> +	    && obj->buffer.length == 8 &&  *(u64 *)obj-
> >buffer.pointer)
> +		spi->mode |= SPI_CPOL;
> +
> +	if (!acpi_dev_get_property(dev, "spiSPH", ACPI_TYPE_BUFFER,
> &obj)
> +	    && obj->buffer.length == 8 &&  *(u64 *)obj-
> >buffer.pointer)
> +		spi->mode |= SPI_CPHA;
> +}
> +
>  static int acpi_spi_add_resource(struct acpi_resource *ares, void
> *data)
>  {
>  	struct spi_device *spi = data;
> @@ -1766,6 +1795,8 @@ static acpi_status
> acpi_register_spi_device(struct spi_controller *ctlr,
>  				     acpi_spi_add_resource, spi);
>  	acpi_dev_free_resource_list(&resource_list);
>  
> +	acpi_spi_parse_apple_properties(spi);
> +
>  	if (ret < 0 || !spi->max_speed_hz) {
>  		spi_dev_put(spi);
>  		return AE_OK;

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
