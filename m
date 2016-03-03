From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ACPI SPI slave device
Date: Thu, 3 Mar 2016 19:55:53 +0100
Message-ID: <20160303185553.GA24603@wunner.de>
References: <20160303174806.GB11728@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leif Liddy <leif.linux@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com,
	linux-spi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303174806.GB11728@srcf.ucam.org>
 <20160303174535.GA11728@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Matthew,

On Thu, Mar 03, 2016 at 05:45:35PM +0000, Matthew Garrett wrote:
> On Thu, Mar 03, 2016 at 12:47:40PM +0100, Lukas Wunner wrote:
> 
> > I think you want to add a quirk to spi.c:acpi_spi_add_device()
> > which checks if acpi_dev_get_resources() returned nothing and
> > the HID of the acpi_device is APP000D: Search the namespace below
> > the acpi_device's handle for _CRS.UBUF (using acpi_get_handle()).
> > If this exists, call acpi_walk_resource_buffer() on it (with the
> > acpi_spi_add_resource callback). You need to somehow convert the
> > acpi_handle to an acpi_buffer, maybe that just involves filling in
> > acpi_buffer->pointer = acpi_handle and somehow determining the
> > length of the resource settings from the handle. Someone more
> > intimately familiar with the layout of the namespace in memory
> > should be able to answer this. Hopefully this will already get
> > you started, if not just ask questions.
> 
> If Apple are consistently using this mechanism to define resources, do 
> we want to extend acpi_dev_get_resources to attempt to call the _DSM 
> method as well?

What Apple is doing with their _DSM is functionally equivalent to the
_DSD (Device Specific Data) method in the ACPI spec. (Apple isn't using
_DSD at all.)

We could extend drivers/acpi/property.c:acpi_init_properties() to
check if dmi_match(DMI_BOARD_VENDOR, "Apple Inc."), and instead of
calling _DSD, call _DSM with Apple's UUID and populate adev->data
with that. Or add the properties to the existing data, if any.

Then whenever we feel the need we could just retrieve Apple's
properties with acpi_dev_get_property().

E.g. in the case of this SPI slave we need to fill in five values
of struct spi_device and we would add a quirk for APP000D which
retrieves each value via acpi_dev_get_property() instead of
acpi_dev_get_resources().

Alternatively we could evaluate the _DSM individually from the
quirk and obtain the values we need from the returned package.
But being able to get them with acpi_dev_get_property() might
be more generic, it's not unlikely that we need to retrieve
Apple's properties from other quirks as well.

The suggestion I made in my previous e-mail (to fetch UBUF) was
probably not so great in terms of maintainability since Apple
might change the name of the variable in a future version of the
DSDT, or on other machines.

Best regards,

Lukas
