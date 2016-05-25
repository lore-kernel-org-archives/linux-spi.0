From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 13:19:24 +0100
Message-ID: <20160525121923.GK1337@leverpostej>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk>
 <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk>
 <5744A402.8050409@weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5744A402.8050409-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, May 24, 2016 at 08:57:06PM +0200, Christer Weinigel wrote:
> On 05/24/2016 08:32 PM, Mark Brown wrote:
> > On Tue, May 24, 2016 at 08:03:48PM +0200, Christer Weinigel wrote:
> >> On 05/24/2016 07:20 PM, Mark Brown wrote:
> > 
> >>> I'm not sure this is something we want to support at all, I
> >>> can't immediately see anything that does this deliberately in
> >>> the SPI code and obviously the "bus number" is something of a
> >>> Linux specific concept which would need some explanation if we
> >>> were going to document it.  It's something I'm struggling a bit
> >>> to see a robust use case for that isn't better served by
> >>> parsing sysfs, what's the goal here?
> > 
> >> If this isn't something that should be in the
> >> Documentation/devicetree because it's not generig enough, where
> >> should Linux-specific interpretations such as this be
> >> documented?
> > 
> > I'm not clear that we want to document this at all since I am not
> > clear that there is a sensible use case for doing it.  I did ask
> > for one but you've not articulated one in this reply.  I am much
> > less gung ho than Grant on this one, even as a Linux specific
> > interface it seems very legacy.
> 
> It's bloody convenient.  I'm working with a Zync board right now where
> we have multiple SPI ports.  Being able to label the ports on the
> board spi1, spi2 and spi3 and having spidev devices show up as
> /dev/spidev1.0 instead of dynamic assignment makes things much easier.

Do these numbers match anything, or have you assigned them artificially?

i.e. are the labels for those well defined for the board? Are they in a
manul, or printed on the board itself?

If these are well-defined and the ports are accessible to, and under the
control of, the end-user, then this would be largely similar to what we
do for serial ports and other user-accessible physical connectors.

>  Especially when doing driver development where unloading and
> reloading the spi driver module will give it a new dynamic number
> every time.
> 
> Yes, it's possible to iterate through all files /sys/class/spi_master
> and then have a table to map those names to device names and create
> symlinks to them, it's just painful.  It's much easier to do be able
> to do "cat data >/dev/spidev1.0" from busybox and not have to set up
> all that infrastructure.  And yes, this is on an embedded system using
> busybox without udev.
> 
> In addition, right now I have a couple of different variants of the
> boards that I work on, and with different SPI ports at different
> addresses.   It's rather nice to be able to reuse the same kernel +
> ramdisk on multiple variants and only have to update the devicetree to
> get sensible devices names on all variants.

If those ports are physically organised and labelled the same, then
using aliases could make sense, to describe the well-defined physical
labels. If you've assigned the numbers artificially, or if the physical
organisation differs across boards, then aliases are not the right tool
for the job.

In the latter cases we're altering the hardware description to suit an
application, rather than providing the necessary abstraction, which is
the kind of (ab)use of aliases which we want to avoid.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
