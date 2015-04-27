From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 17:44:34 +0200
Message-ID: <CAOMqctSW=yDAHGSNAMkueK9aP4eh5eM_N9SkRjHBQY74UwfkCA@mail.gmail.com>
References: <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather> <553CF8F2.6070204@redhat.com>
 <20150427101016.GM22845@sirena.org.uk> <CAOMqctTivbDfvTO1dzVi+j=8JOvmGCdLOTnqb6U9R_TG8Hkypg@mail.gmail.com>
 <CAMuHMdXev+8B6SE=PFVruSJb9yC09BT0bMLponHOM2Os6rLMZA@mail.gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBC5T7GUQKGQEUYCOG3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAMuHMdXev+8B6SE=PFVruSJb9yC09BT0bMLponHOM2Os6rLMZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 27 April 2015 at 17:13, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Mon, Apr 27, 2015 at 4:28 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> When you have a serial port and just connect serial device to it with
>> no special requirement you just specify the serial port in DT and talk
>> to the device directly without any DT foo.
>>
>> When there is a BT module with reset lines and a kernel driver you
>> write in DT that you have such and such BT module with such and such
>> reset lines on the uart so the driver picks it up.
>>
>> Same for USB attached on-board WiFi - that some USB device needs
>> special handling does not mean you have to specify your keyboard in DT
>> to connect it to an USB port.
>>
>> What you are mandating here, basically, is equivalent of requiring a
>> DT overlay to connect an USB keyboard or mouse because it is a device
>> connected in hardware to the USB port and DT is supposed to describe
>> the hardware.
>
> Unlike the spi bus, the USB bus is a discoverable bus. So you can probe
> for connected devices. No need to put them in DT (but you can, if the
> firmware does the probing and updates the DTB. E.g. Open Firmware did
> that for PCI (which was not hot-pluggable)).
>
> Unlike the spi bus, you can (more or less) find out if a device is attached
> to a uart, by listening to the bus, and waiting for a start bit.
>
> I do agree that it would be nice to put the other end of the uart link in DT,
> as you can't always know what you're talking to. Is it a modem? Is it a
> printer? Is it a BT module? Is it Super Grover? Is it Mega Mindy?

And the point is that it can be any of those and you can swap them. So
the DT cannot and will not describe the other end of the bus. There is
some point where the static part of the hardware configuration ends
and pluggable devices start and DT has to deal with that. Sticking
your head into the sand and pretending there is no connector on the
device will only give you a fork.

When the DT is unusable for me and it is unusable for other people
then either a change gets upstream which would be nice or it's bound
to be floating around the net as a patchset which would be annoying
but has happened in the past and will again.

And we are not really discussing some fundamental change to the kernel
that might have unexpected effects on unrelated subsystems. We are
just having a bikeshedding debate if and how a SPI connector is
represented in DT.

Thanks

Michal
