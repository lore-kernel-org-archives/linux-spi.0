From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Clean up probe and remove functions
Date: Thu, 13 Feb 2014 16:14:14 +0100
Message-ID: <52FCE146.8080308@intel.com>
References: <20140213152841.390de00f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140213152841.390de00f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2/13/2014 3:28 PM, Jean Delvare wrote:
> While backporting 33cf00e5 ("spi: attach/detach SPI device to the ACPI
> power domain"), I noticed that the code changes were suboptimal:
>
> * Why use &spi->dev when we have dev at hand?
>
> * After fixing the above, spi is used only once, so we don't really
>    need a local variable for it.
>
> This results in the following clean-up.
>
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


> ---
> Untested, no hardware.
>
>   drivers/spi/spi.c |   12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> --- linux-3.14-rc2.orig/drivers/spi/spi.c	2014-02-13 14:42:09.309512009 +0100
> +++ linux-3.14-rc2/drivers/spi/spi.c	2014-02-13 14:53:36.204366691 +0100
> @@ -255,13 +255,12 @@ EXPORT_SYMBOL_GPL(spi_bus_type);
>   static int spi_drv_probe(struct device *dev)
>   {
>   	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
> -	struct spi_device		*spi = to_spi_device(dev);
>   	int ret;
>   
> -	acpi_dev_pm_attach(&spi->dev, true);
> -	ret = sdrv->probe(spi);
> +	acpi_dev_pm_attach(dev, true);
> +	ret = sdrv->probe(to_spi_device(dev));
>   	if (ret)
> -		acpi_dev_pm_detach(&spi->dev, true);
> +		acpi_dev_pm_detach(dev, true);
>   
>   	return ret;
>   }
> @@ -269,11 +268,10 @@ static int spi_drv_probe(struct device *
>   static int spi_drv_remove(struct device *dev)
>   {
>   	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
> -	struct spi_device		*spi = to_spi_device(dev);
>   	int ret;
>   
> -	ret = sdrv->remove(spi);
> -	acpi_dev_pm_detach(&spi->dev, true);
> +	ret = sdrv->remove(to_spi_device(dev));
> +	acpi_dev_pm_detach(dev, true);
>   
>   	return ret;
>   }
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
