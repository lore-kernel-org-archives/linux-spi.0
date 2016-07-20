From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v2 3/3] acpi spi: Initialize modalias from of_compatible
Date: Wed, 20 Jul 2016 14:21:55 +0300
Message-ID: <a9507dd1-93cf-547a-3bf1-1d7a18fcc761@intel.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1d26e956f12fcd86ad915659adeb86e242b96ac7.1468409668.git.leonard.crestez@intel.com>
 <20160719102213.GZ30372@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jarkko Nikula <jarkko.nikula@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160719102213.GZ30372@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/19/2016 01:22 PM, Mark Brown wrote:
> On Wed, Jul 13, 2016 at 02:53:42PM +0300, Crestez Dan Leonard wrote:
>> When using devicetree spi_device.modalias is set to the compatible
>> string with the vendor prefix removed. For SPI devices described via
>> ACPI the i2c_board_info.type string is initialized by acpi_device_hid.
>> When using ACPI and DT ids this string ends up something like "PRP0001".
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

So the prefix should be something like "spi: acpi: "?

>> Change acpi_register_spi_device to use the of_compatible property if
>> present. This makes it easier to instantiate spi drivers through ACPI
>> with DT ids.
> 
> This is basically fine but...
> 
>> +	if (adev->data.of_compatible) {
>> +		ret = acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias));
>> +		if (ret) {
>> +			spi_dev_put(spi);
>> +			return AE_NOT_FOUND;
>> +		}
> 
> The only reason this could fail currently is that there wasn't a
> compatible in the first place so why don't we just handle it like the no
> compatible case?  It's probably not realistic but it seems like there's
> a small chance this could regress some platform if we do add more error
> detection in acpi_of_modalias().

If acpi_of_modalias fails for some new reason wouldn't it be better to
fail explicitly rather than ignore it?

-- 
Regards,
Leonard
