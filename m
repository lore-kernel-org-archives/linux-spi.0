From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Tue, 14 Jan 2014 16:00:17 +0800
Message-ID: <1389686417.3309.8.camel@rzhang1-mobl4>
References: <1389620911-3890-1-git-send-email-rui.zhang@intel.com>
	 <20140113173525.GF29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140113173525.GF29039-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2014-01-13 at 17:35 +0000, Mark Brown wrote:
> On Mon, Jan 13, 2014 at 09:48:31PM +0800, Zhang Rui wrote:
> > ACPI enumerated devices has ACPI style _HID and _CID strings,
> > all of these strings can be used for both driver loading and matching.
> 
> > But currently, in Platform, I2C and SPI bus, only the ACPI style
> > driver matching is supported by invoking acpi_driver_match_device()
> > in bus .match() callback.
> 
> I don't understand what this means, sorry.

sorry, I should be clearer about this.

>   As far as I can tell "ACPI
> style _HID and _CID strings" are something different to "ACPI style
> driver matching" but what that actually means is not at all clear to me
> so I don't know what problem this is intended to fix.
> 
I gave a more detailed description about the problem in the changelog of
patch 2/4.

Take the following piece of code for example,
static const struct acpi_device_id xxx_acpi_match[] = {
        { "INTABCD", 0 },
        { }
};
MODULE_DEVICE_TABLE(acpi, xxx_acpi_match);

this can be seen in a platform/I2C/SPI driver that supports an ACPI
enumerated device, right?

If this piece of code is used in a platform driver for
an ACPI enumerated platform device, the platform DRIVER module_alias
is "acpi:INTABCD", but the uevent attribute of its platform device node
is "platform:INTABCD:00" (PREFIX:platform_device->name).
If this piece of code is used in an I2C driver for an ACPI enumerated
i2c device, the i2c driver module_alias is "acpi:INTABCD", but
the uevent of its i2c device node is
"i2c:INTABCD:00" (PREFIX:i2c_client->name).
If this piece of code is used in an *SPI* driver for an ACPI enumerated
spi device, the spi driver module_alias is "acpi:INTABCD", but
the uevent of its spi device node is
"spi:INTABCD" (PREFIX:spi_device->modalias).

thus when the device node is created, the driver will not be loaded
automatically because their modalias do not match.

> Please also always remember to CC maintainers on patches.
> 
okay, will resend the patches later.

thanks,
rui
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 349ebba..ab70eda 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -58,6 +58,11 @@ static ssize_t
> >  modalias_show(struct device *dev, struct device_attribute *a, char *buf)
> >  {
> >  	const struct spi_device	*spi = to_spi_device(dev);
> > +	int len;
> > +
> > +	len = acpi_device_modalias(dev, buf, PAGE_SIZE);
> > +	if (len != -ENODEV)
> > +		return len;
> >  
> >  	return sprintf(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
> >  }
> 
> What does this do and why can't acpi_driver_match_device() handle this
> like it does for other ACPI devices?  We don't need to add such code for
> other firmware interfaces...
