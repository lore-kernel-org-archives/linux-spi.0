From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 14:35:48 +0200
Message-ID: <CAOMqctTTwhjqLONixMyWiGuOHbmruKNp8QT8vw+y5hMp-wPtKQ@mail.gmail.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513112604.GI3066-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 13 May 2015 at 13:26, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 12, 2015 at 10:33:24PM +0200, Maxime Ripard wrote:
>
>> While this is nicer than the DT solution because of its accurate hardware
>> representation, it's still not perfect because you might not have access to the
>> DT, or you might be driving a completely generic device (such as a
>> microcontroller) that might be used for something else in a different
>> context/board.
>
> Greg, you're copied on this because this seems to be a generic problem
> that should perhaps be solved at a driver model level - having a way to
> bind userspace access to devices that we don't otherwise have a driver
> for.  The subsystem could specify the UIO driver to use when no other
> driver is available.
>
>> Solve this by registering automatically spidev devices for all the unused chip
>> selects when a master registers itself against the spi core.
>
> So, aside from the concern about this being generic the other thing here
> is that we often have devices offering more chip selects than can
> physically be used in a system but not doing anything to ensure that the
> invalid ones can't be used.  It's unclear to me if that's OK or not, it
> might be since it's root only I think but I need to think it through a
> bit.

Presumably you could add dt nodes for the chipselects and specify they
are disabled but it does not work for me currently.

This is mostly a cosmetic issue. The chipselects were always there but
now they are visible. Unlike the case when you explicitly bind spidev
using dt node the unusable chipselects are also bound.

>
>> This also adds an i2cdev-like feeling, where you get all the spidev devices all
>> the time, without any modification.
>
> I2C is a bit safer here here since it's a shared bus so you can't do
> anything to devices not connected to the bus by mistake.

This is quite safe too. Unless the device chipselect is activated the
device should ignore whatever you write on the bus - unless you get
the chipselect polarity wrong.

But you can get i2c address and lots of other things wrong too.

>
>> +             /*
>> +              * This is far from perfect since an addition might be
>> +              * done between here and the call to spi_add_device,
>> +              * but we can't hold the lock and call spi_add_device
>> +              * either, as it would trigger a deadlock.
>> +              *
>> +              * If such a race occurs, spi_add_device will still
>> +              * catch it though, as it also checks for devices
>> +              * being registered several times on the same chip
>> +              * select.
>> +             */
>> +             status = bus_for_each_dev(&spi_bus_type, NULL, spi,
>> +                                       spi_dev_check);
>> +             if (status) {
>> +                     dev_dbg(&master->dev, "Chipselect already in use.. Skipping.");
>> +                     spi_dev_put(spi);
>> +                     continue;
>> +             }
>
> This still leaves us in the situation where if we do know the device
> that is connected we have to explicitly bind it in spidev which is
> apparently unreasonably difficult for people.  I'm also concerned about
> the interactions with DT overlays here - what happens if a DT overlay
> or other dynamic hardware instantiation comes along later and does bind
> something to this chip select?  It seems like we should be able to
> combine the two models, and the fact that we only create these devices
> with a Kconfig option is a bit of an interesting thing here.

It does not bind anything because the chiselect is busy. That's why I
use a patch which disregards spidev when determining if a chiselect is
busy. That has the problem that you can access devices in use by
kernel using spidev then. Ideally spidev (as checked by module alias
or whatever) would be unbound when other driver requests the
chipselect and rebound when the driver quits.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
