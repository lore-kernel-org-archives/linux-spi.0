From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 17:52:16 +0200
Message-ID: <CAOMqctS5v9Z-Ryc1R906-iotc155du7ZiBTNQhGoV5ux4ESbag@mail.gmail.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk> <20150513153740.GC11677@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513153740.GC11677-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 13 May 2015 at 17:37, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Wed, May 13, 2015 at 12:26:04PM +0100, Mark Brown wrote:
>> On Tue, May 12, 2015 at 10:33:24PM +0200, Maxime Ripard wrote:
>>
>> > While this is nicer than the DT solution because of its accurate hardware
>> > representation, it's still not perfect because you might not have access to the
>> > DT, or you might be driving a completely generic device (such as a
>> > microcontroller) that might be used for something else in a different
>> > context/board.
>>
>> Greg, you're copied on this because this seems to be a generic problem
>> that should perhaps be solved at a driver model level - having a way to
>> bind userspace access to devices that we don't otherwise have a driver
>> for.  The subsystem could specify the UIO driver to use when no other
>> driver is available.
>
> That doesn't really work.  I've been talking to the ACPI people about
> this, and the problem is "don't otherwise have a driver for" is an
> impossible thing to prove, as you never know when a driver is going to
> be loaded from userspace.

Yes, exactly. That's why binding spidev in addition to regular drivers
or have spidev bind always and get unbound when another driver tries
to bind the CS is preferable. The latter is pretty much specifying an
UIO driver to use when no other driver is available in the light of
the fact that 'is available' might change over time. You can prove
that a driver is not available right now.

>
> You can easily bind drivers to devices today from userspace, why not
> just use the built-in functionality you have today if you "know" that
> there is no driver for this hardware.
>

And what exactly do you bind the driver to when there is no device
created with the built-in functionality you have today?

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
