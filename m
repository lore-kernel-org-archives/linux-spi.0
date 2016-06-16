From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] acpi i2c: Initialize info.type from of_compatible
Date: Thu, 16 Jun 2016 11:11:45 +0300
Message-ID: <20160616081145.GU1740@lahna.fi.intel.com>
References: <cover.1466014238.git.leonard.crestez@intel.com>
 <13cb5b7766b1b25a2bb61ce0053a38f6f440907b.1466014238.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>,
	Jarkko Nikula <jarkko.nikula@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <13cb5b7766b1b25a2bb61ce0053a38f6f440907b.1466014238.git.leonard.crestez@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 15, 2016 at 09:30:28PM +0300, Crestez Dan Leonard wrote:
> When using devicetree i2c_board_info.type is set to the compatible
> string with the vendor prefix removed. For I2C devices described via
> ACPI the i2c_board_info.type string is set to the ACPI device name. When
> using ACPI and DT ids this string ends up something like "PRP0001:00".
> 
> If the of_compatible property is present try to use that instead. This
> makes it easier to instantiate i2c drivers through ACPI with DT ids.

Adding Jarkko -- he was the original author of I2C/SPI device naming in
ACPI. Since this only affects devices with PRP0001 in their _HID/_CID,
it should not break anything.

> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  drivers/i2c/i2c-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index af11b65..5ab1fb9 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -188,8 +188,14 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>  
>  	acpi_dev_free_resource_list(&resource_list);
>  
> +	if (adev->data.of_compatible) {

We may want to add acpi_is_of_compatible(adev) or similar at some point.

> +		ret = acpi_of_modalias(adev, info.type, sizeof(info.type));
> +		if (ret)
> +			return -EINVAL;
> +	} else
> +		strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));

Please use {} in the else branch as well. See Documentation/CodingStyle.

> +
>  	adev->power.flags.ignore_parent = true;
> -	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
>  	if (!i2c_new_device(adapter, &info)) {
>  		adev->power.flags.ignore_parent = false;
>  		dev_err(&adapter->dev,
> -- 
> 2.5.5
