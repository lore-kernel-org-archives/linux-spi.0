From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Sat, 2 Jul 2016 12:01:14 +0300
Message-ID: <20160702090114.GS23527@lahna.fi.intel.com>
References: <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
 <20160629183101.GN6247@sirena.org.uk>
 <20160629185155.GG1711@lahna.fi.intel.com>
 <20160629192059.GV6247@sirena.org.uk>
 <20160630124931.GD23527@lahna.fi.intel.com>
 <20160701101912.GL23527@lahna.fi.intel.com>
 <20160701145035.GP6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160701145035.GP6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 01, 2016 at 04:50:35PM +0200, Mark Brown wrote:
> On Fri, Jul 01, 2016 at 01:19:12PM +0300, Mika Westerberg wrote:
> 
> > Windows seems to have a similar spidev raw interface in their MITT test
> > suite here:
> 
> > https://msdn.microsoft.com/fi-fi/windows/hardware/drivers/spb/spi-tests-in-mitt
> 
> > It exposes three ACPI SPI devices with ACPI IDs of SPT0001, SPT0002 and
> > SPT0003. I'm thinking that instead of using the existing DT compatible
> > strings we could use these ACPI IDs in the driver.
> 
> Ugh :(  But yes, if there's existing ACPI IDs for this functionality
> clearly we should support those.  Probably with an equivalent warning
> about how they're only for non-production systems.

OK, good :)

Let me explain some background why I'm doing this. Maybe it brings
better alternatives.

There are these boards for Makers and IoT stuff which basically have pin
header where you can connect different low speed peripherals, like
sensors and so on. The main point is that you don't always know
beforehand what devices will be connected to the board. Now, it seems
that IoT/Maker folks solved this in userspace so that they are not using
existing drivers provided by Linux kernel but instead they are using raw
access to buses like I2C and SPI, and provide their own "drivers" for
those peripherals.

For I2C it is easy because we have i2c-dev and it does not require any
kind of firmware support. For SPI we need to be more careful because of
bus signals like chip selects. Instead of writing out-of-tree board files
to provide proper configuration for SPI (spidev) we can at least try to
take advantage of the boot firmware, like ACPI which already has
a way to describe devices connected to SPI bus.

Now, since spidev is just Linux software abstraction for raw access to
the SPI bus I don't think it is good idea to allocate special ACPI ID
just for that - it does not describe hardware. So instead I'm thinking
we could re-use those Windows ACPI IDs in the driver.

With this we can either stick these devices with the boot firmware
shipping with boards or alternatively provide overlays which can be
loaded to the existing firmware as needed. Users of these boards can
then take mainline Linux and use whatever existing IoT userspace
components.

I'm going to prepare a new patch adding these ACPI IDs to the spidev
early next week.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
