From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Sun, 26 Apr 2015 20:53:16 +0200
Message-ID: <CAOMqctT1sC5PWLLXr0By_-5GaJK0nKoGOxHiwpaFZtBFmWkDbQ@mail.gmail.com>
References: <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather> <CAOMqctR5NiuZ2T3wYOpqu6Ez1yk7U9VoxDZHBT6uEqftRN_Z-g@mail.gmail.com>
 <20150426155404.GL5627@lukather>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBRPI6SUQKGQETGLGZNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150426155404.GL5627@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 26 April 2015 at 17:54, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Sun, Apr 26, 2015 at 05:33:36PM +0200, Michal Suchanek wrote:
>> On 26 April 2015 at 16:33, Maxime Ripard
>> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> > On Sun, Apr 26, 2015 at 04:14:33PM +0200, Michal Suchanek wrote:
>> >> On 26 April 2015 at 14:51, Maxime Ripard
>> >> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> >> > On Sun, Apr 26, 2015 at 02:38:18PM +0200, Michal Suchanek wrote:
>> >> >> On 26 April 2015 at 13:56, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> =
wrote:
>> >> >> >
>> >> >> >> On 26.04.2015, at 13:23, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wr=
ote:
>> >> >> >> I think there is actual a use for just binding spidev as spidev=
,
>> >> >> >> think e.g. the spi pins on the raspberry pi.
>> >> >> >>
>> >> >> >> How do you deal we suggest with such a situation ?
>> >> >> >
>> >> >> > I actually asked the same question a few days ago on the spi lis=
t
>> >> >> > (in thread: "spi: spidev: Warn loudly if instantiated from DT as=
 =E2=80=9Cspidev=E2=80=9D)
>> >> >> > and the summary was:
>> >> >> >
>> >> >> > You can still do as before, but you have to accept that long
>> >> >> > irritating warning.
>> >> >> >
>> >> >> > Or you patch spidev.c to include your pattern of choice for comp=
atiblity
>> >> >>
>> >> >> So the suggestion is to add a compatible string like olimex,uext-s=
lot
>> >> >> to spidev and use that compatible in the DT?
>> >> >
>> >> > No, you add a compatible for the device that is connected to the bu=
s
>> >> > through that slot.
>> >>
>> >> There is no device connected in the slot by design. The slot is there
>> >> for connecting random stuff you find in your mailbox or other drawers
>> >> and boxes.
>> >
>> > I know. Our point is add a compatible for that random device you find
>> > in your mailbox.
>>
>> That would be mailbox,device-tbd I suppose?
>
> If you can find a programming model and a matching datasheet for that
> device, I suppose, yes.
>
>> >> >> That can certainly be done but adding a new compatible for every b=
oard
>> >> >> that has some random pins looks like a needless nuisance to me.
>> >> >> Especially compared to i2c where you can just open the bus so long=
 as
>> >> >> ti is enabled.
>> >> >>
>> >> >> >
>> >> >> > Or you implement the following proposal (which needs a volunteer=
):
>> >> >> >> On 23.04.2015, at 09:42, Geert Uytterhoeven <geert@linux-m68k.o=
rg> wrote:
>> >> >> >>
>> >> >> >> So what you need is a way to handover from generic spidev to a =
device-specific
>> >> >> >> driver, cfr. what graphics drivers do when the device has been =
bound to by
>> >> >> >> vesafb or simplefb.
>> >> >> >>
>> >> >> >> Could this be implemented in a generic way in the spi or DT cod=
e?
>> >> >> >
>> >> >> > ...
>> >> >> >> On 23.04.2015, at 12:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> >> >> >> On Thu, Apr 23, 2015 at 09:45:16AM +0200, Geert Uytterhoeven wr=
ote:
>> >> >> >>
>> >> >> >>> I guess this has been suggested before: the spi core could pro=
vide spidev
>> >> >> >>> access to all spi client devices which are not bound by a driv=
er?
>> >> >> >>
>> >> >> >> I don't know if it's been suggested before, certainly nobody di=
d the
>> >> >> >> work to make it happen.  I don't think I have a massive objecti=
on in
>> >> >> >> principal.
>> >> >
>> >> > Actually, I did it a year ago, and it looked at the time that it
>> >> > wasn't what should be done either.
>> >>
>> >> There is nothing like unclaimed device. Either there is a device and
>> >> driver for it may in principle be loaded later as a module or the chi=
p
>> >> select is reserved for use from userspace.
>> >
>> > I never said it was perfect.
>> >
>> >> Userspace driver is valid option and should have the ability to have
>> >> the chip select reserved.
>> >
>> > Whether an userspace driver is a valid option can spawn a whole debate
>> > by its own, but it's true that we should be able to have it exported
>> > to the userspace.
>> >
>> > However, having a spidev compatible is not the solution to that
>> > problem.
>>
>> Having to patch the kernel to use an unknown device with userspace
>> driver is not the answer either.
>>
>> Devices which are not performance critical and don't use existing
>> kernel frameworks don't have any use for kernel driver.
>>
>> In fact, writing a kernel driver for them is counter-productive
>> because you will have to write from scratch when you connect the
>> device to a box running another OS due to interface *and* license
>> difference.
>
> And here is the debate...
>
>> Also for driver prototyping you need a compatible which makes the
>> device accessible.
>>
>> If no spidev general compatible is available people will just use
>> compatible for some random device which happens to bind to spidev and
>> will send many letters of thanks to the DT maintainers when the device
>> used for this purpose suddenly grows a Linux driver.
>
> If people do dumb things, they should expect it to backfire.

Yes, dumb things like not allowing people to say in the DT that the
board actually has pins on it connected to a SPI bus. Which is the
actual hardware which should be described in the DT.

Do you have to describe a modem or terminal emulator in DT to connect
it to your serial port? You just describe the port. So here you have a
SPI port and it should be described in the DT as faithfully as the
serial port.

>
>> >> > https://lkml.org/lkml/2014/4/28/612
>> >> >
>> >> >> But how do you know there is a device?
>> >> >>
>> >> >> Devices on i2c can be probed. On spi you just transfer random data=
 and
>> >> >> hope it does something useful. Some devices have readable register=
s
>> >> >> and can be probed in a device-specific way but others are write-on=
ly.
>> >> >
>> >> > Well, what's the point of communicating with a non-existent device =
in
>> >> > the first place?
>> >>
>> >> I have multitude of SPI devices which are not part of the board and
>> >> hence its DT and can be connected to the board with jumper wires.
>> >>
>> >> Most of them don't have a linux driver or compatible to bind with.
>> >
>> > Then create such a compatible...
>>
>> I will if and when the device is usable.
>
> That's backward. The fact that your "driver" works really doesn't
> depend on what the device actually is.

Indeed.

However, for the device to have a compatible the compatible must be
specified in a driver and then I need a driver for the device to
record the compatible in.

Or do you suggest that I patch the compatible into spidev, write a
driver for it, and then back out the compatible from spidev and check
in the compatible again with the driver?

Now that is backwards.

Thanks

Michal

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
