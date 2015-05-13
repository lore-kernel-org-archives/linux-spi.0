From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 17:31:05 +0200
Message-ID: <CAOMqctTd7xG6mwX9AojTH4uaGDY06xOgDFUP437VDiE0rp0sXA@mail.gmail.com>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk> <20150513125102.GA2628@lukather> <20150513143610.GT2761@sirena.org.uk>
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
In-Reply-To: <20150513143610.GT2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 13 May 2015 at 16:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, May 13, 2015 at 02:51:02PM +0200, Maxime Ripard wrote:
>
>> I'd say we're also ok because if we delegate the device driving logic
>> to userspace, we should expect it to know what it does to first drive
>> the device properly, but also to open the right device for this.
>
>> What's the worst that could happen in such a case? The data are output
>> without any chipselect line being driven by the controller? Isn't that
>> supposed to be ignored by the devices?
>
> I'm more worried about the chip select line being connected to the
> "make the board catch fire" signal or whatever (more realistically
> causing us to drive against some other external component) if the extra
> chip selects weren't pinmuxed away.

They would not be pinmuxed away if

1) they are unused by anything else and cs happens to be the default
2) they are used by a device not in DT

right?

For the latter case we might want some way to disable unused
chipselects as well as for the cosmetic issue of multitude of useless
devices popping up.

But you know, unused i2c bus can be also connected to "make the board
catch fire" trace and nobody would notice until somebody has the great
idea to probe it. Incidentally, both i2c and spi cs are active-low
iirc.

>> > This still leaves us in the situation where if we do know the device
>> > that is connected we have to explicitly bind it in spidev which is
>> > apparently unreasonably difficult for people.
>
>> You can still do that, but the point is that you don't have to.
>
> Right, but that's not what I'd expect to happen (and seems to make it
> easier for people to not list things in the DT at all which doesn't seem
> great).  If we're going to make it available by default I'd expect to be
> able to use a userspace driver with anything that doesn't have a driver
> bound rather than with devices that explicitly don't have any
> identification.

Remember that spidev can and is used for boards which have spi
*CONNECTOR* to which you can connect some random gadget and use a
userspace program to communicate with it.

It is cool that you can load a dt overlay if the gadget happens to
have a kernel driver.

However, what identification do you write in the dt when there is no
need to use a kernel driver at all?

The option to create a node with 'spidev' compatible was rejected as broken.

The option to add new compatible to the spidev driver every time you
want to connect a new device was rejected as absurdly complex for end
users who have a board with system already preinstalled because it
requires adding the compatible in the spidev source and rebuilding the
kernel.

So this patch implements another option which is to bind spidev
*always*. The configuration of the port is then not recorded in the DT
and it's up to the user to visually check the port or apply other
relevant heuristic and run the correct userspace application.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
