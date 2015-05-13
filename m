From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 21:23:31 +0200
Message-ID: <CAMuHMdVnW8+J4dGiM3p8DOKj7RRv74Dh6+LU1ntCtCreLW8g0Q@mail.gmail.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
	<20150513112604.GI3066@sirena.org.uk>
	<20150513153740.GC11677@kroah.com>
	<20150513175034.GC4004@lukather>
	<20150513181736.GC16811@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513181736.GC16811-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, May 13, 2015 at 8:17 PM, Greg Kroah-Hartman
<gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Wed, May 13, 2015 at 07:50:34PM +0200, Maxime Ripard wrote:
>> On Wed, May 13, 2015 at 08:37:40AM -0700, Greg Kroah-Hartman wrote:
>> > On Wed, May 13, 2015 at 12:26:04PM +0100, Mark Brown wrote:
>> > > On Tue, May 12, 2015 at 10:33:24PM +0200, Maxime Ripard wrote:
>> > >
>> > > > While this is nicer than the DT solution because of its accurate hardware
>> > > > representation, it's still not perfect because you might not have access to the
>> > > > DT, or you might be driving a completely generic device (such as a
>> > > > microcontroller) that might be used for something else in a different
>> > > > context/board.
>> > >
>> > > Greg, you're copied on this because this seems to be a generic problem
>> > > that should perhaps be solved at a driver model level - having a way to
>> > > bind userspace access to devices that we don't otherwise have a driver
>> > > for.  The subsystem could specify the UIO driver to use when no other
>> > > driver is available.
>> >
>> > That doesn't really work.  I've been talking to the ACPI people about
>> > this, and the problem is "don't otherwise have a driver for" is an
>> > impossible thing to prove, as you never know when a driver is going to
>> > be loaded from userspace.
>> >
>> > You can easily bind drivers to devices today from userspace, why not
>> > just use the built-in functionality you have today if you "know" that
>> > there is no driver for this hardware.
>>
>> What we're really after here is that we want to have an spidev
>> instance when we don't even have a device.
>
> That's crazy, just create a device, things do not work without one.

One simple way that works today is to create a device tree overlay with a
device that's compatible with "spidev". That does violate DT policy, as it
doesn't describe the hardware. But it works. This can be done from userspace,
so we (the naggers about incorrect description of the hardware) will never
see the abusive dtso.

Alternatively, you can write some kernel code that does more or less the same
thing, i.e. create a device for "spidev", but without any DT involved.
If you add remove support, and make this controllable through sysfs, I think
this could be a viable solution. It would be similar to gpio export.
A DT overlay with the real device can still take over, if you instruct the
removal of the "spidev" device through sysfs first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
