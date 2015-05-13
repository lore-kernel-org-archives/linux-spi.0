From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 15:33:31 -0700
Message-ID: <20150513223331.GA26748@kroah.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513175034.GC4004@lukather>
 <20150513181736.GC16811@kroah.com>
 <20150513192640.GF4004@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513192640.GF4004@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, May 13, 2015 at 09:26:40PM +0200, Maxime Ripard wrote:
> On Wed, May 13, 2015 at 11:17:36AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, May 13, 2015 at 07:50:34PM +0200, Maxime Ripard wrote:
> > > Hi Greg,
> > > 
> > > On Wed, May 13, 2015 at 08:37:40AM -0700, Greg Kroah-Hartman wrote:
> > > > On Wed, May 13, 2015 at 12:26:04PM +0100, Mark Brown wrote:
> > > > > On Tue, May 12, 2015 at 10:33:24PM +0200, Maxime Ripard wrote:
> > > > > 
> > > > > > While this is nicer than the DT solution because of its accurate hardware
> > > > > > representation, it's still not perfect because you might not have access to the
> > > > > > DT, or you might be driving a completely generic device (such as a
> > > > > > microcontroller) that might be used for something else in a different
> > > > > > context/board.
> > > > > 
> > > > > Greg, you're copied on this because this seems to be a generic problem
> > > > > that should perhaps be solved at a driver model level - having a way to
> > > > > bind userspace access to devices that we don't otherwise have a driver
> > > > > for.  The subsystem could specify the UIO driver to use when no other
> > > > > driver is available.
> > > > 
> > > > That doesn't really work.  I've been talking to the ACPI people about
> > > > this, and the problem is "don't otherwise have a driver for" is an
> > > > impossible thing to prove, as you never know when a driver is going to
> > > > be loaded from userspace.
> > > > 
> > > > You can easily bind drivers to devices today from userspace, why not
> > > > just use the built-in functionality you have today if you "know" that
> > > > there is no driver for this hardware.
> > > 
> > > What we're really after here is that we want to have an spidev
> > > instance when we don't even have a device.
> > 
> > That's crazy, just create a device, things do not work without one.
> 
> Our use case is this one: we want to export spidev files so that "dev
> boards" with a header that allows to plug virtually anything on it
> (Raspberry Pi, Cubieboards, Xplained, and all the likes) without
> having to change the kernel and / or device tree.

You want to do that on a bus that is not self-describing or dynamic?
I too want a pony.  Please go kick the hardware engineer who designed
such a mess, we solved this problem 20+ years ago with "real" busses.

> That would mean that if we plug something to that port, no device will
> be created because the DT itself won't have that device declared in
> the first place.

Because you can't dynamically determine that something was plugged in,
of course.

> This patch is actually doing this: creating a new device for all the
> chipselects that are not in use that will be bound to the spidev
> driver.

I have yet to see a patch...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
