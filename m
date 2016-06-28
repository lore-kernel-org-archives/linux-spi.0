From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Tue, 28 Jun 2016 14:40:41 +0200
Message-ID: <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com> <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com> <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160627221259.GA10054-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 27 June 2016 at 22:32, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jun 27, 2016 at 09:40:38PM +0200, Michal Suchanek wrote:
>
>> No. It's for buses that have some inherent identification. It's not for
>
>> 1) generate random compatible and stick it in device tree
>
> Don't generate a random compatible, generate one that accurately
> describes your hardware.

Ok, what compatible do you generate to connect a serial modem or use a
serial console?

I just want to use the SPI bus and not a compatible.

There is no hardware other than pin header. You are preparing a
factory image for a devboard with a pin header that can be used for
connecting SPI devices. Some devices have fine kernel drivers and for
these you prepare fine overlays. Some devices have fine userspace
drivers and you do NOT want kernel driver for them even if it is
available later on. What compatible do you put in the factory image so
that the user can just connect an external device and run a
corresponding application to use it?

>
>> also AFAIK new_id is not automagic and not all buses have it.
>
> Yes, this is the bit I've been trying to prompt you to implement rather
> than going off doing something broken.

The new_id part is also broken. How do you new_id a port that can be
used to connect a serial modem, serial console, SLIP line, or pretty
much anything else the user pleases? I'm sure users will be happy if
you enforce to new_id  any use of a serial port once serial bus is
done.

>
>> So it would have to be implemented on SPI. How? On PCI new_id is a PCI
>> id. What is it on SPI? ACPI PnP id? DT compatible? How do you tell?
>
> Those sound like sensible ideas.

There is slight problem that SPI bus can have *both* ACPI PnP IDs and
DT compatibles. so you cannot tell which one it is. Even if you put in
all the infra to tell if the particular bus uses one or the other it
still does not solve the basic problem that SPI is generic
communication bus and users want to just send and receive data on the
bus.

>
>> And why when the bus does not even have IDs?
>
> Identifiers are just a useful way of describing what the hardware is,
> the fact that some of them can be read back from hardware isn't terribly
> important here.

Maybe the fact that some buses are useful for just sending random data
that the kernel does not understand and has no business meddling with
is important then.



On 28 June 2016 at 00:12, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Mon, Jun 27, 2016 at 09:40:38PM +0200, Michal Suchanek wrote:
>> On 27 June 2016 at 21:09, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
>> > On Mon, Jun 27, 2016 at 09:02:32PM +0200, Michal Suchanek wrote:
>> >> The spi bus has no autodetection whatsoever. The 'detection' of the
>> >> device that's suposed to be on the other side completely relies on user
>> >> supplied information coming from devicetree on many platforms. It is
>> >> completely reasonable then to allow the user to supply the information
>> >> at runtime by doing echo 'somedevice' >
>> >> /sys/bus/spi/drivers/somedriver/bind
>> >> This fails if somedriver does not have in its id table compatible of
>> >> somedevice so just skip this check for manual driver binding.
>> >
>> > That's what the new_id file is for, right?
>> >
>>
>> No. It's for buses that have some inherent identification. It's not for
>>
>> 1) generate random compatible and stick it in device tree
>> 2) reboot with new devicetree or load overlay
>> 3) write the random compatible you just generated to new_id file so
>> you can bind drivers to your device
>>
>> You could have saved yourself a lot of hassle just ignoring the ID completely.
>
> Um, all devices have to have an "id" the driver core enforces this.
>
> Now your bus can ignore them, or do whatever it wants, but really, you
> can't just try to wave them away.

What id has a serial modem or a serial console?

None as far as I can tell. You just connect a serial cable (or not )
and write random data to the port. The protocol is defined by
userspace application and the kernel has no business telling it what
it should be like.

>
>> Do you have to go through that to connect a different modem to your
>> serial port?
>
> As has been said numerous times, there is no serial port bus, but people
> are working on it.
>
> And no, you don't, and serial _devices_ work just fine with the driver
> model.

Then how does the serial bus work so that you do not have to new_id a
modem or serial console and it just works as if there was no bus?

>
>> Or even a new i2c device to i2c bus?
>
> If you have an unknown i2c device, yes you do.

No, you don't. You can just talk to any devices you like from
userspace so long as the address is not used by a kernel driver.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
