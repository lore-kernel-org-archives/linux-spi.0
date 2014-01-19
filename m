From: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Sun, 19 Jan 2014 15:39:34 +0530
Message-ID: <CAD6G_RTwMJ5DgkCB7wcYw+2p---DqU4KCVJ3CUnHFfCJ0ui_Jw@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
	<CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
	<52D7A237.8@freescale.com>
	<CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
	<20140117020226.GB27652@shlinux2.ap.freescale.net>
	<CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
	<20140117065401.GA6140@shlinux2.ap.freescale.net>
	<CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
	<52DB3864.2040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, angus.clark-qxv4g6HH51o@public.gmane.org,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52DB3864.2040606-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jan 19, 2014 at 7:58 AM, Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
>
> =D3=DA 2014=C4=EA01=D4=C217=C8=D5 16:39, Jagan Teki =D0=B4=B5=C0:
>
>> On Fri, Jan 17, 2014 at 12:24 PM, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org=
>
>> wrote:
>>>
>>> On Fri, Jan 17, 2014 at 12:36:08PM +0530, Jagan Teki wrote:
>>>>>>
>>>>>> My basic question is like I have a qspi spi controller in my SOC=
 and I
>>>>>> designed two boards B1 and B2
>>>>>
>>>>> okay.
>>>>>
>>>>>> B1 with quad spi controller connected with non-flash as a slave =
and B2
>>>>>> with quad spi controller connected
>>>>>> with quad flash as a slave.
>>>>>
>>>>> You can use the framework for B2. But for B1, you should not use =
the
>>>>> framework,
>>>>> since this framework is just for the SPI-NOR. If you do not conne=
cted
>>>>> with
>>>>> a NOR, i think it's better to code another driver for your contro=
ller.
>>>>
>>>> Means we have two separate controller drivers for same controller =
one
>>>> with spi-nor and
>>>> another with spi is it?
>>>
>>> Take drivers/spi/spi-imx.c for example, if you connect a NOR to it,=
 you
>>> only
>>> need to add a NOR device node in the device tree. In the probe, it =
will
>>> call
>>> the m25p80.c to probe the NOR device.
>>>
>>> But if we connect other device to it. you should set another device=
 node
>>> for it.
>>>
>>> I am not sure if your controller driver can works as the spi-imx.c
>>
>> My question here was - this new framework suggest to write a two
>> different controller
>> drivers one is for non spi-nor and spi-nor models? do you agree that=
?
>
>
>
> If your controller can either connects to a NOR, or can connects to o=
ther
> devices, it means your controller is a _BUS_.
> You just need to write the bus driver for your controller, such as th=
e
> spi-imx.c and drivers/bus/imx-weim.c do.
>
> Since you have connect a device to your controller. you also need to =
write a
> driver for your device, such as the m25p80.c is
> for your spi nor device.
>
> Just think about that how do you code your driver for SPI NOR _withou=
t_ this
> framework:
> do your driver need to call the m25p80.c? if you do call the m25p80.c=
, you
> actually write your so-called "two drivers" :)

I'm still not convinced here, sorry!
Let me explain more with example, Just take your (q)spi controller as a=
n example
B_FSL1 designed with - serial flash
B_FSL2 designed with - touch screen

With this design If we follow current we just need one controller
driver (drivers/spi/spi-fsl.c)
to serve touch screen and serial flash from upper layers.

MTD core                Input core
-------------           -------------------------------
m25p80.c             spi  touchscreen driver  (drivers/input/touchscree=
n)
----------------------------------------------------
                          SPI core
----------------------------------------------------
      controller driver (drivers/spi/spi-fsl.)
----------------------------------------------------

But with your new SPI-NOR

MTD core
------------
SPI-NOR              Input core
-----------           ------------------
fsl-quadspi.c     spi  touchscreen driver  (drivers/input/touchscreen)
----------------      ------------------------------
                         SPI Core
                         -----------------------------
                         controller driver (drivers/spi/spi-fsl.c)
                         -----------------------------------------

Here see we have two separate drivers for the same controller as it off=
ers two
functionalities. and also it never talk to Linux SPI subsystem which is=
 not a
good for me as intern hw is SPI-based it must talk to subsystem to make=
 use of
Linux SPI API's.

And also you mentioned SPI-NOR controller is not a SPI controller what =
does that
means because it's a NOR flash which is of SPI protocol based.

I understand that your framework doing good things in matured manner, b=
ut
seems like it's confuse to me to follow common standards - Just my
opinion, may be I'm incorrect.

One more thing question - I have 1-wire spi controller which I was
used for flash in
one board and keyboard in another board, so if I follow your framework
I need to write
a driver in drivers/mtd/spi-nor/foo-spi.c and one more in
drivers/spi/spi-foo.c - correct?

>
>
> This framework does nSPot change any logic for the current kernel, ex=
cept
> adding a layer. With the new layer, we can code the
> driver for the controllers which is a SPI-NOR controller, not a SPI b=
us
> controller.
>
>
>
>>
>> And also one important note from your design was spi-nor mode is
>> completely bypassing
>> Linux spi core is that the good idea?
>>
> yes. I think it's a good idea.
>
> As Mark even pointed, the freescale's Quadspi controller is not a SPI
> controller, it is a SPI-NOR controller, it does _not_ need the
> LINUX SPI core.

--=20
Thanks,
Jagan.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
