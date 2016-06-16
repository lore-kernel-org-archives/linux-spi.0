From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/3] acpi spi: Initialize modalias from of_compatible
Date: Thu, 16 Jun 2016 11:12:57 +0300
Message-ID: <20160616081257.GV1740@lahna.fi.intel.com>
References: <cover.1466014238.git.leonard.crestez@intel.com>
 <40e5cbb0aa638c619fc7fe9f1dbfaa50e888c2ac.1466014238.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40e5cbb0aa638c619fc7fe9f1dbfaa50e888c2ac.1466014238.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 15, 2016 at 09:30:29PM +0300, Crestez Dan Leonard wrote:
> When using devicetree spi_device.modalias is set to the compatible
> string with the vendor prefix removed. For SPI devices described via
> ACPI the i2c_board_info.type string is initialized by acpi_device_hid.
> When using ACPI and DT ids this string ends up something like "PRP0001".
> 
> Change acpi_register_spi_device to use the of_compatible property if
> present. This makes it easier to instantiate spi drivers through ACPI
> with DT ids.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 77e6e45..eef5ac2 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1680,11 +1680,19 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
>  		return AE_OK;
>  	}
>  
> +	if (adev->data.of_compatible) {
> +		ret = acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias));
> +		if (ret) {
> +			spi_dev_put(spi);
> +			return AE_NOT_FOUND;
> +		}
> +	} else
> +		strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));

Same here, use {} in the else branch.

> +
>  	if (spi->irq < 0)
>  		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
>  
>  	adev->power.flags.ignore_parent = true;
> -	strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
>  	if (spi_add_device(spi)) {
>  		adev->power.flags.ignore_parent = false;
>  		dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
> -- 
> 2.5.5
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
