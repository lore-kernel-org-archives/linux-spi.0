From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Wed, 29 Jun 2016 05:32:48 +0200
Message-ID: <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com> <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com> <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com> <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk> <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk> <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160628205736.GE17217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 28 June 2016 at 22:57, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jun 28, 2016 at 10:02:59PM +0200, Michal Suchanek wrote:
>
>> Of course I could add "my-shiny-new-board" compatible to the device
>> tree and spidev. Then when I build my-shiny-new-board2 and it happens
>> to also use userspace driver I will not bother to update the
>> compatible nor will anyone else doing this. So it's equivalent to
>> having "foobar123" in there from the start. Your proposed solution is
>> so complex that it will never be used as intended even if changing the
>> compatible on the node and driver could be both accomplished by an
>> echo to sysfs.
>
> If you are describing the connected SPI device as the board rather than
> the actual device you're doing things wrong, and if you have the same
> thing on two boards then /of course/ they should list the same
> compatible string so the existing software stack should work.  If people
> just use some random board description that happens to work right now
> even if it doesn't match their actual hardware then they're no worse off
> than with your hacks but we've been pushing people to do something long
> term supportable so a bunch of other people who paid attention will be
> better off.

ok, so my-shiny-new-spi-expansion-board and my-dhiny-new-expansion-board-2

It's unsupportable to pretend people will change the hardware
descriptio, either. It won't happen.

>
>> >  If the tooling around this is too hard to use then that
>> > seems like a useful thing to work on, having simple ways for people to
>> > describe modules they build for maker type systems (ideally integrated
>> > with schematic capture software) would be great for example.
>
>> Again, what simple to use tooling do you use to describe the modem you
>> connect to a serial port in the kernel (ideally integrated with
>> schematic capture software)? I use none. I just connect the modem. I
>> want to do that with all SPI devices that I do not intend to use with
>> an in-kernel driver above the spi master driver that provides the
>> communication channel as is the case with the serial modem.
>
> This has been gone through repeatedly.  There's obvious differences here
> - quite apart from anything else dedicated SPI connectors that are
> completely fixed function and also not part of a bigger expansion
> connector are rather rare and are a clear subset of the more general
> plugin module case.

The thing is that there are two common use cases. One is to get an
expansion board designed to connect to your big expansion connector.

The other is to get a generic expansion board and jumper wires. Of
course, you will not use all pins of your expansion connector this
way. On the other hand using the remaining pins becomes challenging
because of the jumper wires you just added. You can use some of the
remaining pins as GPIO or add more jumper wires and use some of the
remaining functions of the connector for another expansion board.

> The way we handle serial ports is currently not
> ideal anyway, and the general software stacks sitting on top of serial
> ports are very different to those for SPI.

Of course they are different. It's different communication channel
with different set of supported devices on the other end.

>
>> It is not my very specific use case. It's common use case for
>> devboards which have spi connectors.
>
> That's really not that common - it *is* common to have expansion
> connectors, but single function ones not so much and certainly not in
> sufficient numbers that it's worth doing something that only works for
> them alone (and then only in cases where spidev happens to be the best
> way to control the device which is a further subset).

It's not about single function connector. It's about using the
particular bus available on the connector. Devices using multiple
buses are very rare so even if you have specially designed expansion
board it rarely uses more than one function of the connector.

> There's also the
> fact that the limited connectors are more commonly found on the more
> expensive eval boards which of course tend to have users who are more
> technically experienced than the maker boards and should really not
> struggle with basic tasks.

On the other hand, expansion boards that designed for a particular
multi-function connector are much more expensive than generic boards
that just have a device on them and make the signals required to use
the device available on pin header which can be wired to any board.
Also the range of devices available on generic expansion board is much
larger than that available for a particular connector - be it Arduino
compatible, Pi compatible, Beagleboard compatible or anything else.

So it's very common to get a shiny new generic expansion board, look
at the pin signal description, wire these, look at the chip printing
and

1) it reads something like ds1301 and I see kernel driver for this -
mod the DT or write an overlay
2) it reads something like rc522 or pn533 and there is no kernel
driver or I want to use userspace driver although there is kernel
driver available - do something to talk to this from userspace

I don't see how case 2) differs from using a serial modem
significantly. For serial attached expansion boards or i2c ones all
that is required is to find which serial port or i2c bus to use. You
can talk to the device right away. For spi you have to do something to
load spidev.

The 'do something to load spidev' should be something that

 - is the same for any board used in 2). If it isn't people will us it
interchangeably anyway because from the kernel point of view there is
no change. You may pretend you are pushing for accurate hardware
description but that won't happen.
 - is something that can be prepared beforehand for users of a
devboard by the devboard distributor in their pre-built linux image

>
>> If this particular way to solve the problem does not fit with the
>> driver model does any of the previously listed ones fit better,
>> perhaps with some changes?
>
>> Or since you are familiar with the driver model perhaps you are away
>> of a solution that was not mentioned so far that would accomplish this
>> and fits with the driver model?
>
> The answer remains the same, describe your module with a DT overlay and
> load the overlay.  Or modify your DT directly if you like given that the
> board is probably not enumerable anyway, especially if it's a flying
> wire job.  If you want to bind devices at runtime you'll need new_id.

And the answer is always the same. That's not gonna happen. It's too
complex solution for a task that boils down to the same for every spi
expansion board used in 2) - load spidev. You are repeating yourself
uselessly.

>
>> Or if this use case does not fit into the driver model at all then
>> perhaps the driver model needs updating to catch up with real world?
>
> The problem isn't that the driver model can't cope, the problem is that
> you are flat out refusing to do anything that involves describing the
> hardware.

Because it does not make sense to describe the hardware for this use case.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
