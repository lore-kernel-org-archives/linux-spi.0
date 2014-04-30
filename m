From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 30 Apr 2014 22:00:18 +0200
Message-ID: <DA3907EB-0C1B-42FB-B288-9E33F6E24E3E@martin.sperl.org>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com> <20140429183758.GH15125@sirena.org.uk> <24BF05CB-35FF-42E8-BE5C-A5E4E3D0C52A@martin.sperl.org> <20140430181429.GD3000@lukather>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140430181429.GD3000@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 30.04.2014, at 20:14, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> I'd really be in favor of using the DT overlays for this. All this is
> nice, but very fragile. You can't really handle any weird
> configurations that you might encounter, like weird interrupt
> controllers that might be requiring more informations, or you don't
> set any interrupt parents, and this parameter list will basically be
> an ever-growing list of parameters to deal with all kind of crazy
> corner-cases, and I'm not sure it's something we want.
> 
Problem is getting DT overlays included in the kernel it seems...

I agree arguments will tend to increase, but the "core" stuff would be
not changing all that often, as there are only so many parameters of
spi_device that can get set/configured anyway.

Everything else is either a driver specific parameter that the driver
supports itself or we have to resort to some voodoo magic blob 
kind of thing.

But for the most part we want to configure simple devices for those
boards: ADCs, LCD-Displays, Network Controller,...

These typically do not have that many parameters of their own that 
have to be set up during probing/initialization (mostly interrupt flags,
maybe some extra GPIO, maybe an attached clock speed).

The other stuff gets typically set up via other interfaces 
(netlink et.al) anyway. So I do not see that many parameters that 
would realistically get set.

Also note that this should allow people to do simple stuff quickly 
- like spidev - not complex stuff.

So from the support-perspective of an end-users it is easier to say:
* echo "cs=1:...." > /sys/bus/spi_root/spi0/register
* if it does not work: 
  echo "cs=1" > /sys/bus/spi_root/spi0/register
* and run again slightly modified: 
  echo "cs=1:...." > /sys/bus/spi_root/spi0/register

than:
* install dt compiler with 
* create that file (dt) and modify the settings
* run the compiler
* copy the compiled DT-overlay to /lib/firmware
* echo "..." > /sys/devices/bone_capemgr.*/slots
* reboot if it does not work...
* run steps 2 to 5 again and see if it works...

SPIDEV is for people wanting to do rapid development.

The register part + kernel-driver is the next step up in complexity, 
where spidev is not fast enough for some reason, or does not provide
for all the needs (shared access,...).

The complex clock example of yours is something that would fall in the 
DT-overlay case - these things are most likely too complicated for 
the simple user and requires extensive knowledge of the design.
Those people tend to know how to build a kernel and compile DTs.

Different tools for different level of complexities.

> You listed only ARM boards, that are not supposed to be non-DT. RPi is
> using DT fine, just like the beaglebones. I don't really see why we
> should care about !DT cases.
I listed those ARM boards because I have most experience with them.

I do not know how those INTEL Galileo boards work, but I doubt 
they run DT - ACPI more likely.
But people still want to do rapid development on those using existing
arduino shields, so the DT-overlay requirement would cut them off.

Same for future ARM64 devices where there seems to be a push by 
vendors to move to ACPI for those systems - not DT.

Other examples are the WIFI router, most of which also have SPI 
interfaces and people have done all sorts of things with them - not 
all run ARM either - at least all those WIFI routers I have seen
so far do not run DT-kernels...

So there is more to it than just ARM and we should be able to handle
the "easy" cases for all systems independent from how we configure 
the rest of the system.

Also the proposed setting is along the same lines as GPIO management
via /sys/class/gpio.

Following your argument we should not have this interface either
but use DT for these GPIOs as well - similar argument for I2C...

Still we have them and they are heavily used by those dev-boards,
so why not something along the same lines also for SPI?

Ciao,
	Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
