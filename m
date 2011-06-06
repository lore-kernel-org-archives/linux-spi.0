From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 14:57:43 +0200
Message-ID: <201106061457.43999.arnd@arndb.de>
References: <20110605071725.26517.11573.stgit@ponder>
	<201106061321.07400.arnd@arndb.de>
	<20110606141636.150c54b5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Michael Buesch <mb-fseUSCV1ubazQB+pC5nmwQ@public.gmane.org>, linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>,
	Alexandre Bounine <alexandre.bounine-49Rm3DX9dRQ@public.gmane.org>,
	Stefan Richter <stefanr-MtYdepGKPcBMYopoZt5u/LNAH6kLmebB@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Matt Porter <mporter-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110606141636.150c54b5-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 06 June 2011, Jean Delvare wrote:
> On Mon, 6 Jun 2011 13:21:07 +0200, Arnd Bergmann wrote:
> > A top-level /bus would work for me, and I guess would also address Russell's
> > concern. Regarding bus-specific drivers, we're gradually moving those out
> > of the bus specific directories anyway, basically the only bus directory
> > that really has device driver in it is USB at this point. It makes some
> > sense to have a bus-specific low-level user space interface driver like
> > sg or uio in the bus directory, but everything else should really belong
> > into some other subsystem.
> 
> Err, what about I2C and SPI? Aren't drivers/i2c/busses and drivers/spi
> full of "device drivers"? Or are these what you call "bus-specific
> drivers"? Maybe we need to define all the terms before the discussion
> continues further.

drivers/i2c/busses and drivers/spi are full of what I would call "bus
drivers" or "host drivers". They bind to a device from another bus
(platform, pci, ...) and export devices of their own type (i2c, spi, ...).
This is what all bus drivers do.

An i2c or spi device driver would in turn bind to that device and
provide a functionality not specific to that bus (e.g. hwmon, input,
leds, rtc or media).

> > (...)
> > This is about to get worse as we introduce new subsystems (e.g. iommu,
> > irq, clocksource, eeprom, nvram, ...) into which we are moving
> > code from arch/arm, drivers/char and drivers/misc. Having buses and
> > drivers in a separate hierarchy would make the drivers directory and
> > the respective menuconfig list more clearly structured IMHO.
> 
> This gets interesting. Would you suggest for example that i2c-core.c
> goes to bus/i2c, and drivers/i2c/busses becomes drivers/i2c? And that
> CONFIG_I2C is somewhere in menuconfig, and the hardware driver
> selection for drivers/i2c is in a totally different place?

No, all of drivers/i2c would go into bus/i2c or drivers/bus/i2c, there
is no point splitting that. The part that would no go there is the various
drivers that are already not under drivers/i2c but are for devices
connected to an i2c bus.

The confusion is probably that in case of drivers/scsi and drivers/usb,
both bus and device drivers are in the same subdirectories. If we move
drivers/usb to bus/usb, I would probably recommend to split
drivers/usb/{serial,storage,atm,misc} out of it and move it to
drivers/{tty/usb-serial,block/usb,net/usb/atm,misc/usb} though, to
make it look more like PCI or i2c that already have a clean split.

> While I am surprised, I am not necessarily objecting. But it seems that
> you should better define what your actual plan is, before asking us if
> we agree with it.

My original plan was to think this through a bit more, but Grant posted
the big spi reorganization, so I jumped in on that because it wouldn't
be nice to have to move all those drivers again.

	Arnd

------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger.
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Discover what all the cheering's about.
Get your free trial download today. 
http://p.sf.net/sfu/quest-dev2dev2 
