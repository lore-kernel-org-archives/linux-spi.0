From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Fri, 1 Jul 2016 12:11:29 +0200
Message-ID: <CAOMqctRL7VYtXjHYk2kijthCwb=cN0fFnswOqE-fC9b1aWOr0Q@mail.gmail.com>
References: <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk> <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk> <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk> <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk> <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
 <5774E07D.1060706@emutex.com> <20160701093613.GF6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Dan O'Donovan" <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160701093613.GF6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 1 July 2016 at 11:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 30, 2016 at 10:03:57AM +0100, Dan O'Donovan wrote:
>
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

Sorry about that.
To get a reasonably portable access to e-mail I use web e-mail client
and it only knows about auto-wrapping.

>
>> In case its relevant, I'd like add to this point by emphasising that
>> there is an increasing number of "maker" boards available, such as UP,
>
> We know.
>
>> which expose an open SPI bus interface on a pin header with the
>> intention that a primary use of that SPI interface is decided at
>> application level.  'spidev' is the adopted method for making that SPI
>> interface accessible to those applications, and those boards do
>> typically ship with Linux kernel that either (i) use
>
> It's not the case that these boards (even when used with flying wires)
> universally want or use spidev, people will want to use existing drivers
> for devices that have them, and equally there are a bunch of non-maker
> applications for spidev.  It's not like there is a special kind of
> silicon that only makers use here.

Sure. The thing is that like quarter or so of the external expansion
SPI boards are used with userspace driver.
Either there is no kernel driver or it is unsuitable for the particular
application.

You say that people should describe the hardware to the kernel
regardless.

That's not going to happen. The hardware description in kernel
has no meaning when all the kernel does is provide a communication
channel for use by userspace application.

So people using several devices with spidev want to change the
application but not the kernel configuration. Changing the kernel
configuration only makes sense when you want a different service
from the kernel as a result. Otherwise it's needless obstruction
that people can and naturally will avoid.

And people here does not mean one person connecting random
things to an EVB to design a STB or tablet.
With maker boards people can mean all the people using a particular
board with the software that was preinstalled on it.

>
>> Anyway, I would love to see a solution integrated for this, whatever
>> the appropriate solution may be.
>
> There's a bunch of work going on to make overlays easier to use with
> connectors which will hopefully help a lot here.  The other big bit that
> seems to be missing is automating the process of going from schematic
> capture for the modules to DTs so that people can design something and
> get the bits needed for the software as trivially as possible.

That's nice for the cases when you do want to use a kernel driver.
I think it's easy enough to write overlays even without automatic conversion
from schematic when the application calls for it.

That's not what this is about, however.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
