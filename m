From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Sun, 26 Apr 2015 16:14:33 +0200
Message-ID: <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
References: <cover.1430034797.git.hramrach@gmail.com> <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com>
 <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
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
Return-path: <linux-sunxi+bncBCQMLUOX54MBB4XF6OUQKGQES7EZ35Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150426125113.GF5627@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 26 April 2015 at 14:51, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Sun, Apr 26, 2015 at 02:38:18PM +0200, Michal Suchanek wrote:
>> On 26 April 2015 at 13:56, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> >
>> >> On 26.04.2015, at 13:23, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> >> I think there is actual a use for just binding spidev as spidev,
>> >> think e.g. the spi pins on the raspberry pi.
>> >>
>> >> How do you deal we suggest with such a situation ?
>> >
>> > I actually asked the same question a few days ago on the spi list
>> > (in thread: "spi: spidev: Warn loudly if instantiated from DT as =E2=
=80=9Cspidev=E2=80=9D)
>> > and the summary was:
>> >
>> > You can still do as before, but you have to accept that long
>> > irritating warning.
>> >
>> > Or you patch spidev.c to include your pattern of choice for compatibli=
ty
>>
>> So the suggestion is to add a compatible string like olimex,uext-slot
>> to spidev and use that compatible in the DT?
>
> No, you add a compatible for the device that is connected to the bus
> through that slot.

There is no device connected in the slot by design. The slot is there
for connecting random stuff you find in your mailbox or other drawers
and boxes.

>
>> That can certainly be done but adding a new compatible for every board
>> that has some random pins looks like a needless nuisance to me.
>> Especially compared to i2c where you can just open the bus so long as
>> ti is enabled.
>>
>> >
>> > Or you implement the following proposal (which needs a volunteer):
>> >> On 23.04.2015, at 09:42, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wr=
ote:
>> >>
>> >> So what you need is a way to handover from generic spidev to a device=
-specific
>> >> driver, cfr. what graphics drivers do when the device has been bound =
to by
>> >> vesafb or simplefb.
>> >>
>> >> Could this be implemented in a generic way in the spi or DT code?
>> >
>> > ...
>> >> On 23.04.2015, at 12:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> >> On Thu, Apr 23, 2015 at 09:45:16AM +0200, Geert Uytterhoeven wrote:
>> >>
>> >>> I guess this has been suggested before: the spi core could provide s=
pidev
>> >>> access to all spi client devices which are not bound by a driver?
>> >>
>> >> I don't know if it's been suggested before, certainly nobody did the
>> >> work to make it happen.  I don't think I have a massive objection in
>> >> principal.
>
> Actually, I did it a year ago, and it looked at the time that it
> wasn't what should be done either.

There is nothing like unclaimed device. Either there is a device and
driver for it may in principle be loaded later as a module or the chip
select is reserved for use from userspace.

Userspace driver is valid option and should have the ability to have
the chip select reserved.

>
> https://lkml.org/lkml/2014/4/28/612
>
>> But how do you know there is a device?
>>
>> Devices on i2c can be probed. On spi you just transfer random data and
>> hope it does something useful. Some devices have readable registers
>> and can be probed in a device-specific way but others are write-only.
>
> Well, what's the point of communicating with a non-existent device in
> the first place?

I have multitude of SPI devices which are not part of the board and
hence its DT and can be connected to the board with jumper wires.

Most of them don't have a linux driver or compatible to bind with.

>
>> So binding spidev is in my view just saying that you are going to
>> transfer random data from userspace on this bus.
>
> Yes, to a device connected on that bus.

Yes, so I have this red rectangular PCB, blue PCB, and red square PCB
and blue very thin rectangular PCB.

Please enlighten me how to add DT bindings for these and the PCB which
is in the mail and I did not pick up at the post office yet.

Of course, I have some hope that the chips on the PCBs are at least
somewhat compatible with what I ordered but I cannot be sure until I
test that.

Thanks

Michal

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
