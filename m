From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 3/4] ACPI / scan: Recognize Apple SPI and I2C slaves
Date: Thu, 29 Jun 2017 10:46:04 +0200
Message-ID: <20170629084604.swuzzxsdiiosqurz@wunner.de>
References: <cover.1498636759.git.lukas@wunner.de>
 <9f06a7ce1cc6dd4cb33004c7d37adc1a5c0f80e2.1498636759.git.lukas@wunner.de>
 <20170629073420.GZ629@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170629073420.GZ629@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 29, 2017 at 10:34:20AM +0300, Mika Westerberg wrote:
> On Wed, Jun 28, 2017 at 07:20:19PM +0200, Lukas Wunner wrote:
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1444,6 +1444,12 @@ static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
> >  	struct list_head resource_list;
> >  	bool is_spi_i2c_slave = false;
> >  
> > +	/* Macs use device properties in lieu of _CRS resources */
> > +	if (IS_ENABLED(CONFIG_X86) && dmi_match(DMI_SYS_VENDOR, "Apple Inc.") &&
> 
> Do we really need these checks?

With these checks present, searching for the properties can be optimized
away on ARM and skipped on x86 non-Macs.  (Each property query requires
decoding the _DSD Package and performing an O(n) search of the properties.)

So I'd say yes?

Thanks,

Lukas

> 
> > +	    (device_property_present(&device->dev, "spiSclkPeriod") ||
> > +	     device_property_present(&device->dev, "i2cAddress")))
> > +		return true;
> > +
> >  	INIT_LIST_HEAD(&resource_list);
> >  	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
> >  			       &is_spi_i2c_slave);
> > -- 
> > 2.11.0
