From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI SPI slave device
Date: Thu, 3 Mar 2016 19:12:46 +0000
Message-ID: <20160303191246.GA14040@srcf.ucam.org>
References: <20160303174806.GB11728@srcf.ucam.org>
 <20160303174535.GA11728@srcf.ucam.org>
 <20160303185553.GA24603@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leif Liddy <leif.linux@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com,
	linux-spi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303185553.GA24603@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 03, 2016 at 07:55:53PM +0100, Lukas Wunner wrote:

> We could extend drivers/acpi/property.c:acpi_init_properties() to
> check if dmi_match(DMI_BOARD_VENDOR, "Apple Inc."), and instead of
> calling _DSD, call _DSM with Apple's UUID and populate adev->data
> with that. Or add the properties to the existing data, if any.

Just do it unconditionally, it's cheap.

> E.g. in the case of this SPI slave we need to fill in five values
> of struct spi_device and we would add a quirk for APP000D which
> retrieves each value via acpi_dev_get_property() instead of
> acpi_dev_get_resources().

Mm. It'd be nice to avoid having to keep a list of Apple devices - some 
sort of mapping function might be easier, returning the values from _CRS 
if they're present or from _DSM/_DSD otherwise?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
