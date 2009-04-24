From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: General SPI question
Date: Fri, 24 Apr 2009 00:31:53 -0700
Message-ID: <200904240031.53343.david-b@pacbell.net>
References: <8ee9e87c0904232328j7f912eb6v3d0b9cb0321793a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Arnav Das <arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8ee9e87c0904232328j7f912eb6v3d0b9cb0321793a9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

[ I dropped the PPC folk from the cc list.. ]

On Thursday 23 April 2009, Arnav Das wrote:
> Hi,
> 
> Thanks a lot and sorry for the mistakes. I have gone through the trm of the
> adc as well as the omap driver. my question is that i want to interact the
> adc to the board. now should i directly use the omap driver or should i mak
> one of my own.

Unless you have a compelling reason, use the OMAP controller driver.

You'd write a spi_driver -- a *REALLY* simple one -- using interfaces
described in Documentation/spi/spi-summary for the lower level.  Almost
all the work involved would be in the upper level interface:  presenting
the data to whatever needs it.  Maybe sysfs, maybe not; you've not said
anything about how you need to use this data.  That would usually be
the first thing to figure out...


> if i make one of my own then i would like to know how would 
> the spi registers be changed by driver. should it include the omap2 driver
> or is the fuctionality provided directly when i include spi.h.

You should end up with a simple ADC driver that can hook up to
any platform's SPI controller.  Your driver will talk to a
"struct spi_device" and will be usable on non-OMAP boards.

 
> another doubt: when and why is the spidev.c/h used?

When you want a "userspace driver" instead of a kernel driver.

- Dave


> i am deeply grateful towards you for helping me out
> thanks
> Arnav
> 
> On Fri, Apr 24, 2009 at 11:50 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>wrote:
> 
> > On Thursday 23 April 2009, Arnav Das wrote:
> > > i am a newbie
> >
> > Lesson #1:  make sure your Subject: lines match the message
> > topic (I did a partial repair) and don't post to the wrong
> > list (e.g. PPC lists for OMAP questions).
> >
> >
> > > and am doing a project on beagle board(running
> > > omap3530). i am interfacing an adc(ads7886) to the beagleboard via
> > > spi. need to know how the spi works
> >
> > Read the ads7886 data sheet, in this case.  It uses
> > a subset of SPI ... no input commands, just a 12-bit
> > sample returned each time chipselect pulses.
> >
> >
> > > and how a module can access the
> > > spi registers of the omap. if someones already made an adc driver can
> > > they mail me?
> >
> > Use drivers/spi/omap2_mcspi.c on OMAP3 boards, at
> > least to start with.  If you want streaming conversions
> > you may want to use different modes than are currently
> > supported by that driver.
> >
> > - Dave
> >
> >
> >
> >
> >
> 



------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
