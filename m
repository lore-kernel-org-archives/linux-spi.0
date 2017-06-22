From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] ACPI / property: Support Apple _DSM properties
Date: Thu, 22 Jun 2017 11:06:55 +0300
Message-ID: <20170622080655.GS629@lahna.fi.intel.com>
References: <cover.1498044532.git.lukas@wunner.de>
 <8ce38be1389dfb0527961ccd0dedb609802b59c1.1498044532.git.lukas@wunner.de>
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
In-Reply-To: <8ce38be1389dfb0527961ccd0dedb609802b59c1.1498044532.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 21, 2017 at 08:05:53PM +0200, Lukas Wunner wrote:
> While the rest of the world has standardized on _DSD as the way to store
> device properties in AML (introduced with ACPI 5.1 in 2014), Apple has
> been using a custom _DSM to achieve the same for much longer (ever since
> they switched from DeviceTree-based PowerPC to Intel in 2005, verified
> with MacOS X 10.4.11).
> 
> The theory of operation on macOS is as follows:  AppleACPIPlatform.kext
> invokes mergeEFIproperties() and mergeDSMproperties() for each device to
> merge properties conveyed by EFI drivers as well as properties stored in
> AML into the I/O Kit registry from which they can be retrieved by
> drivers.  We've been supporting EFI properties since commit 58c5475aba67
> ("x86/efi: Retrieve and assign Apple device properties").  The present
> commit adds support for _DSM properties, thereby completing our support
> for Apple device properties.  The _DSM properties are made available
> under the primary fwnode, the EFI properties under the secondary fwnode.
> So for devices which possess both property types, they can all be
> elegantly accessed with the uniform API in <linux/property.h>.
> 
> Until recently we had no need to support _DSM properties, they contained
> only uninteresting garbage.  The situation has changed with MacBooks and
> MacBook Pros introduced since 2015:  Their keyboard is attached with SPI
> instead of USB and the _CRS data which is necessary to initialize the
> spi driver only contains valid information if OSPM responds "false" to
> _OSI("Darwin").  If OSPM responds "true", _CRS is empty and the spi
> driver fails to initialize.  The rationale is very simple, Apple only
> cares about macOS and Windows:  On Windows, _CRS contains valid data,
> whereas on macOS it is empty.  Instead, macOS gleans the necessary data
> from the _DSM properties.
> 
> Since Linux deliberately defaults to responding "true" to _OSI("Darwin"),
> we need to emulate macOS' behaviour by initializing the spi driver with
> data returned by the _DSM.
> 
> An out-of-tree driver for the SPI keyboard exists which currently binds
> to the ACPI device, invokes the _DSM, parses the returned package and
> instantiates an SPI device with the data gleaned from the _DSM:
> https://github.com/cb22/macbook12-spi-driver/commit/9a416d699ef4
> https://github.com/cb22/macbook12-spi-driver/commit/0c34936ed9a1
> 
> By adding support for Apple's _DSM properties in generic ACPI code, the
> out-of-tree driver will be able to register as a regular SPI device,
> significantly reducing its amount of code and improving its chances to
> be mainlined.
> 
> The SPI keyboard will not be the only user of this commit:  E.g. on the
> MacBook8,1, the UART-attached Bluetooth device likewise returns empty
> _CRS data if OSPM returns "true" to _OSI("Darwin").
> 
> The _DSM returns a Package whose format unfortunately deviates slightly
> from the _DSD spec:  The properties are marshalled up in a single Package
> as alternating key/value elements, unlike _DSD which stores them as a
> Package of 2-element Packages.  The present commit therefore converts
> the Package to _DSD format and the ACPI core can then treat the data as
> if Apple would follow the standard.
> 
> Well, except for one small annoyance:  The properties returned by the
> _DSM only ever have one of two types, Integer or Buffer.  The former is
> retrievable as usual with device_property_read_u64(), but the latter is
> not part of the _DSD spec and it is not possible to retrieve Buffer
> properties with the device_property_read_*() functions due to the type
> checking performed in drivers/acpi/property.c.  It is however possible
> to retrieve them with acpi_dev_get_property().  Apple is using the
> Buffer type somewhat sloppily to store null-terminated strings but also
> integers.  The real data type is not distinguishable by the ACPI core
> and the onus is on the caller to use the contents of the Buffer in an
> appropriate way.
> 
> In case Apple moves to _DSD in the future, this commit first checks for
> _DSD and falls back to _DSM only if _DSD is not found.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Federico Lorenzi <florenzi@gmail.com>
> Cc: Ronald Tschalär <ronald@innovation.ch>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/acpi/property.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 27a9294c843c..545188207b8d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/device.h>
> +#include <linux/dmi.h>
>  #include <linux/export.h>
>  
>  #include "internal.h"
> @@ -34,6 +35,121 @@ static const u8 ads_uuid[16] = {
>  	0xe6, 0xe3, 0xb8, 0xdb, 0x86, 0x58, 0xa6, 0x4b,
>  	0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b
>  };
> +/* Apple _DSM device properties GUID: a0b5b7c6-1318-441c-b0c9-fe695eaf949b */
> +static const u8 apple_prp_uuid[16] = {
> +	0xc6, 0xb7, 0xb5, 0xa0, 0x18, 0x13, 0x1c, 0x44,
> +	0xb0, 0xc9, 0xfe, 0x69, 0x5e, 0xaf, 0x94, 0x9b
> +};
> +
> +/**
> + * acpi_retrieve_apple_properties - retrieve and convert Apple _DSM properties
> + * @adev: ACPI device for which to retrieve the properties
> + *
> + * Invoke Apple's custom _DSM once to check the protocol version and once more
> + * to retrieve the properties.  They are marshalled up in a single package as
> + * alternating key/value elements, unlike _DSD which stores them as a package
> + * of 2-element packages.  Convert to _DSD format and make them available under
> + * the primary fwnode.
> + */
> +static void acpi_retrieve_apple_properties(struct acpi_device *adev)
> +{
> +	unsigned int i, j, version, newsize = 0, numprops, skipped = 0;
> +	union acpi_object *props, *newprops;
> +	void *free_space;
> +
> +	props = acpi_evaluate_dsm_typed(adev->handle, apple_prp_uuid, 1, 0,
> +					NULL, ACPI_TYPE_BUFFER);
> +	if (!props || !props->buffer.length)
> +		goto out_free;
> +
> +	version = props->buffer.pointer[0];
> +	ACPI_FREE(props);
> +	if (version != 3) {
> +		acpi_handle_err(adev->handle,
> +				"unsupported properties version %u\n", version);

I don't think this is error. More like debug if anything.

> +		return;
> +	}
> +
> +	props = acpi_evaluate_dsm_typed(adev->handle, apple_prp_uuid, 1, 1,
> +					NULL, ACPI_TYPE_PACKAGE);
> +	if (!props)
> +		return;
> +
> +	/* newsize = key length + value length of each tuple */
> +	numprops = props->package.count / 2;
> +	for (i = 0; i < numprops; i++) {
> +		union acpi_object *key = &props->package.elements[i * 2];
> +		union acpi_object *val = &props->package.elements[i * 2 + 1];
> +
> +		if ( key->type != ACPI_TYPE_STRING ||
> +		    (val->type != ACPI_TYPE_INTEGER &&
> +		     val->type != ACPI_TYPE_BUFFER)) {
> +			key->type = ACPI_TYPE_ANY; /* mark as to be skipped */
> +			skipped++;
> +			continue;
> +		}
> +		newsize += key->string.length + 1;
> +		if ( val->type == ACPI_TYPE_BUFFER)
> +			newsize += val->buffer.length;
> +	}
> +
> +	if (skipped)
> +		acpi_handle_err(adev->handle,
> +				"skipped %u properties: wrong type\n", skipped);

Same here.

> +	if (skipped == numprops)
> +		goto out_free;
> +
> +	/* newsize += top-level package + 3 objects for each key/value tuple */
> +	newsize	+= (1 + 3 * (numprops - skipped)) * sizeof(union acpi_object);
> +	newprops = ACPI_ALLOCATE_ZEROED(newsize);
> +	if (!newprops)
> +		goto out_free;
> +
> +	/* layout: top-level package | packages | key/value tuples | strings */
> +	newprops->type		   = ACPI_TYPE_PACKAGE;
> +	newprops->package.count	   = numprops - skipped;
> +	newprops->package.elements = &newprops[1];
> +	free_space		   = &newprops[1 + 3 * (numprops - skipped)];

I would prefer you you don't align the assignments:

	/* layout: top-level package | packages | key/value tuples | strings */
	newprops->type = ACPI_TYPE_PACKAGE;
	newprops->package.count = numprops - skipped;
	newprops->package.elements = &newprops[1];
	free_space = &newprops[1 + 3 * (numprops - skipped)];

This is consistent with the rest of the file.

> +
> +	for (i = 0, j = 0; i < numprops; i++) {
> +		union acpi_object *key = &props->package.elements[i * 2];
> +		union acpi_object *val = &props->package.elements[i * 2 + 1];
> +		unsigned int k	       = (1 + numprops - skipped) + j * 2;
> +		unsigned int v	       = k + 1; /* index into newprops */
> +
> +		if (key->type == ACPI_TYPE_ANY)
> +			continue; /* skipped */
> +
> +		newprops[1 + j].type		   = ACPI_TYPE_PACKAGE;
> +		newprops[1 + j].package.count	   = 2;
> +		newprops[1 + j].package.elements   = &newprops[k];

Ditto.

> +
> +		newprops[k].type		   = ACPI_TYPE_STRING;
> +		newprops[k].string.length	   = key->string.length;
> +		newprops[k].string.pointer	   = free_space;
> +		memcpy(free_space, key->string.pointer, key->string.length);
> +		free_space			  += key->string.length + 1;
> +
> +		newprops[v].type		   = val->type;
> +		if (val->type == ACPI_TYPE_INTEGER)
> +			newprops[v].integer.value  = val->integer.value;
> +		else {
> +			newprops[v].buffer.length  = val->buffer.length;
> +			newprops[v].buffer.pointer = free_space;
> +			memcpy(free_space, val->buffer.pointer,
> +						     val->buffer.length);
> +			free_space		  += val->buffer.length;
> +		}
> +		j++; /* not incremented for skipped properties */
> +	}
> +	WARN_ON(free_space != (void *)newprops + newsize);

Again, there is not need to scare the user if we can't parse these. We
can log an error here and give up but definitely no need to trigger
backtrace and register dump.

> +
> +	adev->data.properties = newprops;
> +	adev->data.pointer = newprops;
> +
> +out_free:
> +	ACPI_FREE(props);
> +}
>  
>  static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
>  					   const union acpi_object *desc,
> @@ -375,6 +491,10 @@ void acpi_init_properties(struct acpi_device *adev)
>  	if (acpi_of && !adev->flags.of_compatible_ok)
>  		acpi_handle_info(adev->handle,
>  			 ACPI_DT_NAMESPACE_HID " requires 'compatible' property\n");
> +
> +	if (!adev->data.pointer && IS_ENABLED(CONFIG_X86) &&
> +	    dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
> +		acpi_retrieve_apple_properties(adev);

I think it looks nicer if you move all those conditionals to
acpi_retrieve_apple_properties() and then do:

	if (!adev->data.pointer)
		acpi_retrieve_apple_properties(adev);
