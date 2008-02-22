From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length
 transfer
Date: Fri, 22 Feb 2008 10:58:52 -0800
Message-ID: <20080222185852.5863D28E371@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200802211026.17816.marc.pignat@hevs.ch>
	<20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200802221030.32263.marc.pignat@hevs.ch>
	<20080222.231510.56565462.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marc.pignat-7TsPiqsLilE@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080222.231510.56565462.anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Quoth Atsushi Nemoto on Fri, 22 Feb 2008:
> On Fri, 22 Feb 2008 10:30:31 +0100, Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org> wrote:
> > > > David, do you think writing 0 bytes is a valid use of this API?
> > > 
> > > Just a zero byte transfer ... no, though it depends what you mean
> > > by "valid".  (I'm not sure I'd expect all controller drivers to
> > > reject such requests.)  That has no effect on bits-on-the-wire,
> > > and would make trouble for various DMA engines.
> >
> > So, the behaviour is undefined,

Not what I said.  To repeat:  it makes sense to pass zero bytes
in at least one case, which is not "just" a zero byte transfer.

And in a practical sense, until we have some kind of regression
testing scheme -- with some kind of "golden device" -- it's not
very sensible for any SPI Protocol Driver to expect that all SPI
Master Controller Drivers act consistently in such cases.


> >	something between 'crash my dma engine',
> > 'assert chip select and wait some time', or 'do_nothing'...
>
> If the driver could not handle zero length transfer, then the driver
> should reject it (just like unsupported transfer mode).

Exactly.  Behaviors like "crash my DMA engine" are clearly "invalid",
in *ALL* cases.  Bugs to get fixed as soon as they're noticed.


>	Then the
> behavior will be 'assert chip select and wait some time' or 'rejected
> by the driver'.

The "wait" mode is what started this thread -- not "just" a zero
byte transfer, but one which does real work.

For "just" a zero byte transfer, I see two main implementation
options ... with no compelling reason to force either one.

  - "ignored" ... the implementation sibling of "wait"
  - "rejected" ... more work

The argument for "rejected" would seem to be only that this is a
case of "protocol drivers should not do this".  But if they don't,
then the difference doesn't matter.


> > > And it would probably deserve a mode flag (sigh) unless someone
> > > can update every master controller driver.
> >
> > Supporting the zero-len-write means checking and perhpaps updating
> > each driver for the benefit of having an unknown length delay.
> > 
> > We should add the delay field in the spi_device, but this means more work.
> > 
> > Is this kind of device so common that we need to do all that work? or can we
> > leave it as is (verified to work only with atmel_spi)?
>
> I think my case is not so common.  But if the driver could support
> zero length transfer easily, there is no reason to reject it.
>
> And if nobody wanted to support zero length transfer on that driver,
> it would be no reason to update it ;)

So long as the controller driver doesn't misbehave, I can't see any
reason to worry about this behavior.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
