From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Fri, 25 Oct 2013 15:55:29 +0300
Message-ID: <526A6A41.6020909@linux.intel.com>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <1382703540-3769-2-git-send-email-jarkko.nikula@linux.intel.com> <6032482.JJ4PNSSnIp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6032482.JJ4PNSSnIp-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

On 10/25/2013 03:52 PM, Rafael J. Wysocki wrote:
>   
> +static void i2c_dev_set_name(struct i2c_adapter *adap,
> +			     struct i2c_client *client)
> +{
> +#if IS_ENABLED(CONFIG_ACPI)
> +	if (ACPI_HANDLE(&client->dev)) {
> ACPI_HANDLE() already contains an "is CONFIG_ACPI enabled?" check, so the #if
> around the if (ACPI_HANDLE()) {} is redundant.
>
> Similarly for the SPI patch.
>
Well, acpi_bus_get_device() is not available for non-ACPI builds and at 
least the gcc I used for test build didn't optimize that block away.

-- 
Jarkko

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
