From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ACPI / scan: Recognize Apple SPI and I2C slaves
Date: Thu, 29 Jun 2017 12:22:22 +0300
Message-ID: <20170629092222.GC629@lahna.fi.intel.com>
References: <cover.1498636759.git.lukas@wunner.de>
 <9f06a7ce1cc6dd4cb33004c7d37adc1a5c0f80e2.1498636759.git.lukas@wunner.de>
 <20170629073420.GZ629@lahna.fi.intel.com>
 <20170629084604.swuzzxsdiiosqurz@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170629084604.swuzzxsdiiosqurz-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jun 29, 2017 at 10:46:04AM +0200, Lukas Wunner wrote:
> On Thu, Jun 29, 2017 at 10:34:20AM +0300, Mika Westerberg wrote:
> > On Wed, Jun 28, 2017 at 07:20:19PM +0200, Lukas Wunner wrote:
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -1444,6 +1444,12 @@ static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
> > >  	struct list_head resource_list;
> > >  	bool is_spi_i2c_slave = false;
> > >  
> > > +	/* Macs use device properties in lieu of _CRS resources */
> > > +	if (IS_ENABLED(CONFIG_X86) && dmi_match(DMI_SYS_VENDOR, "Apple Inc.") &&
> > 
> > Do we really need these checks?
> 
> With these checks present, searching for the properties can be optimized
> away on ARM and skipped on x86 non-Macs.  (Each property query requires
> decoding the _DSD Package and performing an O(n) search of the properties.)

Well, you add dmi_match() that gets called every time and I was under
the impression that we already performed _DSD decode when the property
set was initially parsed.

Those checks just uglify the code IMHO.

No strong feelings though, so up to Rafael to decide :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
