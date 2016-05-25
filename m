From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 13:34:24 +0100
Message-ID: <20160525123423.GL1337@leverpostej>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej>
 <20160525103810.GU8206@sirena.org.uk>
 <57458A64.2090901@weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57458A64.2090901-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, May 25, 2016 at 01:20:04PM +0200, Christer Weinigel wrote:
> On 05/25/2016 12:38 PM, Mark Brown wrote:
> > On Wed, May 25, 2016 at 10:20:34AM +0100, Mark Rutland wrote:
> >> On Tue, May 24, 2016 at 01:41:26PM -0700, Frank Rowand wrote:
> > 
> >>> The code and behavior is in the Linux kernel. It should be
> >>> visible in the documentation instead of being a big mystery of
> >>> how it works.
> > 
> >> As above, I don't entirely agree. Mindlessly documenting existing
> >> Linux behaviour can have the unfortuante effect of moving people
> >> towards the wrong tool for the job.
> > 
> > Yes, this is exactly my concern - the articulated use case (which
> > didn't suprise me at all) is for using spidev which is itself not
> > just Linux specific but this particular version of Linux right now
> > specific.  There are lots of things that happen to work but are in
> > fact terrible ideas that leave messes for our future selves.  We
> > need to distinguish between things that are real, meaningful system
> > descriptions and things that are implementation details resulting
> > from the rush to force everyone on to DT.
> 
> Oh, for *beep* *beep* sake.
> 
> It used to be very easy to use SPI devices on Linux with stable device
> names.  Add a platform device entry and set bus_num.  Add spidev
> entries specifying the chip select, mode, speed and other specifics
> for the devices on the bus.  Then just use
> /dev/spi$bus_num.$chip_select to talk to them.  Very simple to use and
> understand.
> 
> Doing the same with devicetree ought to be just as simple, and since
> Grant added that patch it actually is.  The behaviour is already in
> the Linux kernel.  Nobody is going to rip out the of_alias_get_id
> usage from the spi driver sice that will break existing userspace.
> Nobody is going to rip out the spidev framework from the Linux kernel.
>  The aliases mechanism which is specifically intended to provide
> easy-to use names for userspace.  From "A Symphony of Flavours: Using
> the device tree to describe embedded hardware" by Grant Likely and
> Josh Boyer:
> 
>     In order to ease device lookup in client operating systems, it is
>     often desirable to define an aliases node.  This allows one to
>     provide a shorthand method for identifying a device without having
>     to specify the full path on lookup.
> 
> What is so horrible about documenting the actual behaviour of the
> Linux kernel? 

We have described a set of problems that generally exist (e.g. mis-use
of interfaces, and the fallout that can result). To avoid those, we must
figure out the caveats that apply in this case.

Many of us are immediately aware of mis-use rather than sensible use, as
the former is painful for us while the latter goes by unnoticed. We
asked about your use-case, hoping the it fell in the latter camp and
could be used to drive the specification and perhaps function as an
example.

> How is documenting that serial0 = /amba@0/blah@blah"
> which is ok, so markedly different from documenting spi0 =
> "/amba@0/blah/blah"?

I alluded to this a little bit in a reply to another sub-thread.

Typically, serial ports are much more user-accessible (physically), and
much more directly useful to a user in a generic fashion. They're often
labelled (physically or in a manual) with a number, and we use aliases
to describe those labels to the kernel. The fact that the kernel may use
that to drive its own internal numbering is immaterial to the binding.

> Does everything have to be so damn difficult?

With the varied hardware that exists, and the constant expansion of the
set of things which exist, there is very little that is simple any more.
Things which are simple today can become alarming non-simple tomorrow,
with only minor changes. So unfortunately, yes.

I appreciate that it can feel like all the feedback has been negative,
and that can be especially annoying given that you did not write the
code in question. Please be aware that we are trying to work in your
best interests, along with the best interests of many others who are
using this code and binding today, or may in future.

Specification work is a difficult, tiring process for all involved, for
anything meaningful.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
