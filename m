From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/4] ACPI / scan: Recognize Apple SPI and I2C slaves
Date: Thu, 29 Jun 2017 10:34:20 +0300
Message-ID: <20170629073420.GZ629@lahna.fi.intel.com>
References: <cover.1498636759.git.lukas@wunner.de>
 <9f06a7ce1cc6dd4cb33004c7d37adc1a5c0f80e2.1498636759.git.lukas@wunner.de>
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
In-Reply-To: <9f06a7ce1cc6dd4cb33004c7d37adc1a5c0f80e2.1498636759.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 28, 2017 at 07:20:19PM +0200, Lukas Wunner wrote:
> SPI and I2C slaves are enumerated by their respective parents rather
> than the ACPI core.  They are recognized by presence of _CRS resources,
> which however are missing on Macs.  Check for presence of device
> properties instead.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Federico Lorenzi <florenzi@gmail.com>
> Reported-and-tested-by: Ronald Tschalär <ronald@innovation.ch>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes v1 -> v2:
> - Newly inserted patch in v2 to fix an enumeration issue. (Ronald)
> 
>  drivers/acpi/scan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d4ff2cd1f738..c565e74bd2dd 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1444,6 +1444,12 @@ static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
>  	struct list_head resource_list;
>  	bool is_spi_i2c_slave = false;
>  
> +	/* Macs use device properties in lieu of _CRS resources */
> +	if (IS_ENABLED(CONFIG_X86) && dmi_match(DMI_SYS_VENDOR, "Apple Inc.") &&

Do we really need these checks?

> +	    (device_property_present(&device->dev, "spiSclkPeriod") ||
> +	     device_property_present(&device->dev, "i2cAddress")))
> +		return true;
> +
>  	INIT_LIST_HEAD(&resource_list);
>  	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
>  			       &is_spi_i2c_slave);
> -- 
> 2.11.0
