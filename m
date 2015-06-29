From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Fwd: [alsa-devel] [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
	of WM510205 codec via ACPI (resend)
Date: Mon, 29 Jun 2015 09:35:56 +0100
Message-ID: <20150629083556.GG6321@opensource.wolfsonmicro.com>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com> <20150625073618.GH827@lahna.fi.intel.com> <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com> <20150625145853.GP14071@sirena.org.uk> <20150625154407.GE6321@opensource.wolfsonmicro.com> <20150625155612.GS14071@sirena.org.uk> <CAKor6TdZNTLnhxpruqDxe4nQsDL+e6xgVHOtVdz4LuFisKNsoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TdZNTLnhxpruqDxe4nQsDL+e6xgVHOtVdz4LuFisKNsoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jun 29, 2015 at 10:12:47AM +0200, Christian Hartmann wrote:
> Hi,
> 
> I do not want to guess and I also want to minimize the try&error circle,
> some questions are open yet:
> 
> 
> 2015-06-25 17:56 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> > On Thu, Jun 25, 2015 at 04:44:07PM +0100, Charles Keepax wrote:
> >> On Thu, Jun 25, 2015 at 03:58:53PM +0100, Mark Brown wrote:
> >> > On Thu, Jun 25, 2015 at 02:18:23PM +0200, Christian Hartmann wrote:
> >
> >> > >                 Name (_HID, "WM510205")  // _HID: Hardware ID
> >> > >                 Name (_CID, "WM510205")  // _CID: Compatible ID
> >> > >                 Name (_DDN, "Wolfson Microelectronics Audio WM5102")
> >
> >> > Separately to the chip select discussion one thing to highlight here is
> >> > that for some reason the BIOS is listing the device as "WM510205" rather
> >> > than "WM5102" - do those extra numbers mean anything and does this mean
> >> > that WM50120[1-4] and possibly higher numbers are also valid?
> >
> >> From my brief discussions with the Windows guys here on this
> >> basically those last two digits are being used to inform the
> >> Windows driver of use-case setup. So here it will set things up
> >> for whatever the Window's driver considers to be setup "5".
> >
> > Yay for scalability and abstraction.
> >
> >> I think from the Linux side we can safely ignore those last two
> >> digits. I expect that all systems of the same make and model
> >> would report the same last two digits but that it might change
> >> between models if the Windows driver is expected to something
> >> differently for that model.
> >
> > Well, we might want to consider using this to set our platform data
> > instead of the machine ID if people have just been copying a smallish
> > set of reference designs, it might might make for a slightly smaller set
> > of ID tables than the machine ID based stuff does.
> >
> > Due to the way ACPI ID matching works we'll also need to add every
> > suffix individually to the table, we're looking for complete matches not
> > substring matches here.
> 
> 
> I saw in the file mfd/arizona/core.h
> the ENUMs of the arizona_type and one of my first tries
> was to simple add a new type (like WM510205 = 5,) but it was not clear
> to me if this will work as expect. I had added in all
> arizona-{core,spi,i2c) files the WM510205 but that was undeclared,
> cause I did not added this ENUM yet...
> 
> What do you think??

I think you are confusing two things here. You shouldn't need to
add any new entries to the arizona_type enum there is already an
entry for wm5102. "WM510205" is what needs to go into the ACPI
match table, we were just discussing that it is probably enough
to look up some fixed pdata to configure the driver for this
device, rather than needing to seperately check the machine ID.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
