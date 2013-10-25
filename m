From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Fri, 25 Oct 2013 14:52:08 +0200
Message-ID: <6032482.JJ4PNSSnIp@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <1382703540-3769-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1382703540-3769-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, October 25, 2013 03:18:59 PM Jarkko Nikula wrote:
> Current I2C adapter id - client address "x-00yy" based device naming scheme
> is not always stable enough to be used in name based matching, for instance
> within ALSA SoC subsystem.
> 
> This is problematic in PC kind of platforms where I2C adapter numbers can
> change due variable amount of bus controllers, probe order, add-on cards or
> just because of BIOS settings.
> 
> This patch addresses the problem by using the ACPI device name with
> "i2c-" prefix for ACPI enumerated I2C slaves. For them device name
> "x-00yz" becomes "i2c-INTABCD:ij" after this patch.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I'm not sure when would acpi_bus_get_device fail and how realistic is that here.
> I put minimalistic error handling here which just falls back to old
> adapter-addr naming scheme.
> ---
>  drivers/i2c/i2c-core.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 111b2c6..8d6f3e5 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -613,6 +613,25 @@ void i2c_unlock_adapter(struct i2c_adapter *adapter)
>  }
>  EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
>  
> +static void i2c_dev_set_name(struct i2c_adapter *adap,
> +			     struct i2c_client *client)
> +{
> +#if IS_ENABLED(CONFIG_ACPI)
> +	if (ACPI_HANDLE(&client->dev)) {

ACPI_HANDLE() already contains an "is CONFIG_ACPI enabled?" check, so the #if
around the if (ACPI_HANDLE()) {} is redundant.

Similarly for the SPI patch.

> +		struct acpi_device *adev;
> +		if (!acpi_bus_get_device(ACPI_HANDLE(&client->dev), &adev)) {
> +			dev_set_name(&client->dev, "i2c-%s",
> +				     dev_name(&adev->dev));
> +			return;
> +		}
> +	}
> +#endif
> +	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
> +	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
> +		     client->addr | ((client->flags & I2C_CLIENT_TEN)
> +				     ? 0xa000 : 0));
> +}
> +
>  /**
>   * i2c_new_device - instantiate an i2c device
>   * @adap: the adapter managing the device
> @@ -671,10 +690,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>  	client->dev.of_node = info->of_node;
>  	ACPI_HANDLE_SET(&client->dev, info->acpi_node.handle);
>  
> -	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
> -	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
> -		     client->addr | ((client->flags & I2C_CLIENT_TEN)
> -				     ? 0xa000 : 0));
> +	i2c_dev_set_name(adap, client);
>  	status = device_register(&client->dev);
>  	if (status)
>  		goto out_err;
> 

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
