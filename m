From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: Check conflicting CS based on spi->chip_select
 instead of device name
Date: Thu, 9 Jan 2014 16:27:29 +0200
Message-ID: <20140109142729.GA2494@intel.com>
References: <1389273835-8615-1-git-send-email-mika.westerberg@linux.intel.com>
 <20140109140646.GT31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140109140646.GT31886-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 09, 2014 at 02:06:46PM +0000, Mark Brown wrote:
> On Thu, Jan 09, 2014 at 03:23:55PM +0200, Mika Westerberg wrote:
> 
> > In case of a buggy BIOS that lists multiple SPI devices sharing the same
> > chip select (even though they should use different) the current code fails
> > to detect that and allows the devices to be added to the bus.
> 
> This actually also points out another issue - if we have two instances
> of a device on different buses they could end up with the same
> dev_name() if they have the same chip select.  Hrm.

I don't think that can happen, at least in case of ACPI, since each ACPI
device has unique name, such as 'INT33C0:00' - the ':00' suffix is the
"instance" number ACPI core gives for devices.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
