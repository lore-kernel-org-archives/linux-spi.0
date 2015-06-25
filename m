From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Fwd: [alsa-devel] [PATCH 1/1] SPI : spi-pxa2xx : fix spi init of
 WM510205 codec via ACPI (resend)
Date: Thu, 25 Jun 2015 17:01:05 +0300
Message-ID: <20150625140105.GP827@lahna.fi.intel.com>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com>
 <20150625073618.GH827@lahna.fi.intel.com>
 <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jun 25, 2015 at 02:18:23PM +0200, Christian Hartmann wrote:
> Hi Mika, Dan et al.
> 
> @Dan : thank you, I will use get_maintainer.pl as of now.
> 
> @Mika: you mean I should prepare a new DSDT table and in this case
> overwrite the SPI  value there with the 0 and load it (the DSDT table
> ) into a custom kernel build ?? I will do this (cause all what I want
> is to enable the codec and to hear sound)

I thought that you are developing a new system where you can affect the
firmware/BIOS source.

Obviously this is not the case so you have close to zero possibility to
get the vendor to fix the broken firmware :-/

> currently I have in the extracted DSDT table from this device the SPI1
> controller for the "AUDI" device as seen in this snippet :
> 
>     Scope (_SB)
>     {
>         Device (LPEA)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
>             Name (_HID, "80860F28" /* Intel SST Audio DSP */)  //
> _HID: Hardware ID
>             Name (_CID, "80860F28" /* Intel SST Audio DSP */)  //
> _CID: Compatible ID
>             Name (_DDN, "Intel(R) Low Power Audio Controller -
> 80860F28")  // _DDN: DOS Device Name
>             Name (_SUB, "17AA7004")  // _SUB: Subsystem ID
>             Name (_UID, One)  // _UID: Unique ID
>             Name (_DEP, Package (0x01)  // _DEP: Dependencies
>             {
>                 ^SPI1.AUDI
>             })
>             Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
>             {
>                 PLPE
>             })
> 
> .... some lines later follows the AUDI device with
>             Device (AUDI)
>             {
>                 Name (_HID, "WM510205")  // _HID: Hardware ID
>                 Name (_CID, "WM510205")  // _CID: Compatible ID
>                 Name (_DDN, "Wolfson Microelectronics Audio WM5102")
> // _DDN: DOS Device Name
>                 Method (_CRS, 0, NotSerialized)  // _CRS: Current
> Resource Settings
>                 {
>                     Name (SBUF, ResourceTemplate ()
>                     {
>                         SpiSerialBus (0x0001, PolarityLow, FourWireMode, 0x08,
>                             ControllerInitiated, 0x007A1200, ClockPolarityLow,
>                             ClockPhaseFirst, "\\_SB.SPI1",
>                             0x00, ResourceConsumer, ,
>                             )

This is wrong as, like I said the Intel Baytrail SPI host controller
only supports one native chipselect. 

>                         GpioInt (Edge, ActiveLow, ExclusiveAndWake,
> PullNone, 0x0000,
>                             "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0004
>                             }
>                         GpioIo (Exclusive, PullDefault, 0x0000,
> 0x0000, IoRestrictionOutputOnly,
>                             "\\_SB.I2C7.PMIC", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0003
>                             }
>                         GpioIo (Exclusive, PullDefault, 0x0000,
> 0x0000, IoRestrictionOutputOnly,
>                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0017
>                             }
>                     })
>                     Return (SBUF) /* \_SB_.SPI1.AUDI._CRS.SBUF */
>                 }
> ....
> 
> I t makes sense to me, to change the current value(s) in the DSDT and
> I have read about it to use a custom DSDT table but I am not 100% sure
> yet (until I have tested it).
> 
> If I understand you correct, than all I have to do is to change the
> 'SPI1' string in this dsdt to SPI0 like
> ^SPI1.AUDI to ^SPI0.AUDI and this block here
> SpiSerialBus (0x0001, PolarityLow, FourWireMode, 0x08,
>                             ControllerInitiated, 0x007A1200, ClockPolarityLow,
>                             ClockPhaseFirst, "\\_SB.SPI1",
>                             0x00, ResourceConsumer, ,
> 
> becomes
> SpiSerialBus (0x0000, PolarityLow, FourWireMode, 0x08,
>                             ControllerInitiated, 0x007A1200, ClockPolarityLow,
>                             ClockPhaseFirst, "\\_SB.SPI0",
>                             0x00, ResourceConsumer, ,

Only change the chipselect above. \\SB.SPI1 is the host controller and
that's probably correct.

It is worth a try using the custom DSDT. If it brings you working audio
then we need to figure out how to work this around in the kernel.

BTW, does the audio work in Windows?

I somehow suspect that it just ignores the chipselect in the SPI driver
which might explain why it works (if it works, that is).
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
