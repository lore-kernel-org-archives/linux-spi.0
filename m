From: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Thu, 26 May 2016 23:04:18 +0200
Message-ID: <574764D2.5060709@weinigel.se>
References: <20160524183256.GP8206@sirena.org.uk> <5744E51A.1040506@gmail.com>
 <20160525174932.GA10753@rob-hp-laptop> <5745E9B6.5090204@gmail.com>
 <20160525184442.GE8206@sirena.org.uk> <57464D0A.1030706@weinigel.se>
 <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
 <574657BB.6070300@weinigel.se> <20160526100753.GB16172@sirena.org.uk>
 <5746D6CE.5020605@weinigel.se> <20160526184746.GF16172@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160526184746.GF16172-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/26/2016 08:47 PM, Mark Brown wrote:
> On Thu, May 26, 2016 at 12:58:22PM +0200, Christer Weinigel wrote:
> 
>> One of the main drivers behind devicetree was that Linus got fed 
>> up with the churn for all platform device changes in arch/arm.
>> I faintly recall him writing that he would be rather unhappy if 
>> that just got replaced with churn for devicetree dts files.
> 
> Since device trees are hardware descriptions they really shouldn't 
> be churning at all - if they are that's an indication that we're 
> failing at device tree.

I meant churn from the sheer number of platforms.  According to
gsmarena.com there were over 600 new Android devices released last
year.  Each and every one of them is a Linux platform.  I've
personally worked on *counts on fingers* 8 different custom Linux
platforms during the last year.  That's a lot of new device tree files
if all of them were to end up in the mainline kernel.

My point is that I don't think it would be doable to get every
devicetree file out there into the mainline kernel; it's not even
desirable.  devicetree files for custom platforms are a lot like
userspace applications, the devicetree implementation is an ABI, and
devicetrees for a lot of different platforms are built for that ABI.

Using "the dts file is not in mainline" or "there is no user of that
devicetree feature in mainline" as an argument for breaking existing
dts files is in my opinion not a good argument.  That will be a change
that is visible to userspace (because device names will change).

>> For platforms based on a FPGA such as the Xilinx Zync it's even 
>> more pointless to submit dts files to mainline.  When you have 
>> "hardware" that can be reconfigured the device tree files can't 
>> be set in stone. If I use Xilinx tools [1] to add one more UART
>> I have just added new hardware this needs to be reflected in the 
>> devicetree for the devices to be usable in Linux.  And something 
>> like aliases which provides a stable device name can be very 
>> useful here.
> 
> Right, but it doesn't follow that aliases are what we should be 
> doing here - both Rob and myself have mentioned providing a way to 
> label the actual SPI devices themselves, this seems like a more 
> robust way of doing things.

That would be good.  It would probably be clearer to have
"i2c-sensors" than "i2c3".  But it won't solve all of the issues that
were flagged as bad with aliases.  For example, someone mentioned that
even if aliases worked with devicetree fragments there could be
collisions in the numbering f aliases.  As long as user assigned names
are used there are going to be mistakes and collisions are going to
happen.  Some nut like me will come along and build lots of
temperature sensors and have multiple buses to talk to them, and then
you end up with half a dozen "i2c-sensors" busses :-)

http://zoo.weinigel.se/misc/temp-chain.jpg

These are actually dallas one-wire sensors, but you get the point.

The only way to guarantee uniqueness would be to use uuids or
something inherently unique like bus addresses (where collisions would
break other things anyway) , but then we're back to things not being
that user friendly again.

> Just numbering the buses provides a partial solution for some 
> systems with usability drawbacks (you need to know the number to 
> name mapping somehow), naming devices is both more direct and more 
> general.

Except that being able to assign static bus numbers devicetree is
something that works _now_ and at least for me it is good enough.
Being able to assign bus numbers makes life for me and the colleagues
I have to support a lot easier.  The whole reason I started looking at
assigning bus numbers to spi ports was a very frustrated colleague
complaining about the seemingly random bus number assignment. To be
able to put stickers on the pin headers on a board saying "spi1",
"spi2" and "spi3" and being able to refer to those numbers in in an
email makes things a lot easier.

It would probably be better if some future devicetree extension would
allow abitrary user-friendly naming of devices, but in the absence of
that I'd take numbers every time.  If I'd have to wait for a perfect
solution before doing something I'd never get anything done.  A dumb
and ok solution is often "better" than a complex one.

  /Christer
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
